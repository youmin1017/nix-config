{ pkgs, isDarwin, ... }:
let
  tmuxPopup =
    let
      tmux = "${pkgs.tmux}/bin/tmux";
      bash = "${pkgs.bash}/bin/bash";
    in
    # Author: https://hackmd.io/@DailyOops/persistent-tmux-popup
    # Modified to use one floating session per main session.
    pkgs.writeScriptBin "tmux-popup" ''
      #!${pkgs.bash}/bin/bash

      # Automatically fetch the current session name
      current_session_name=$(${tmux} display-message -p '#S')

      # Fetch the current directory of the parent session
      parent_session_dir=$(${tmux} display-message -p -F "#{pane_current_path}" -t0)

      # Construct the unique session name with a "floating" suffix, shared by all windows in the parent session
      session_name="floating_''${current_session_name}"

      startup_command="$1"

      # Check if the floating popup session already exists
      if ${tmux} has-session -t "$session_name" 2>/dev/null; then
          if [ -n "$startup_command" ]; then
              # If a startup command is provided, look for its process in the list of panes
              target_pane=$(${tmux} list-panes -a -F "#{session_name} #{pane_id} #{window_name}" | grep -i "^$session_name" | grep -i "$(echo $startup_command | cut -d' ' -f1)" | awk '{print $2}')
              switch_command=""
              if [ -z "$target_pane" ]; then
                  # If the process is not found, create a new window with the startup_command in target session
                  window_name=$(echo $startup_command | cut -d' ' -f1)
                  ${tmux} new-window -t "$session_name" -n "$window_name" -c "$parent_session_dir" "$startup_command"
              else
                  # If the process is found, switch to that window
                  switch_command="${tmux} select-window -t $(${tmux} display-message -p -F "#{window_index}" -t"$target_pane") ;"
              fi
          fi
          ${tmux} popup -w 90% -h 90% -E "${bash} -c \"${tmux} attach -t $session_name; $switch_command\""  # Attach to the session in a popup
      else
          if [ -z "$startup_command" ]; then
              # If no startup command is provided, just open a shell
              ${tmux} new-session -d -s "$session_name" -c "$parent_session_dir"
          else
              # If a startup command is provided, run it in the new session
              window_name=$(echo $startup_command | cut -d' ' -f1)
              ${tmux} new-session -d -s "$session_name" -c "$parent_session_dir" "$startup_command"
              ${tmux} rename-window -t "$session_name":1 "$window_name"
          fi
          ${tmux} popup -w 90% -h 90% -E "${bash} -c \"${tmux} attach -t $session_name\""  # Attach to the session in a popup
      fi
    '';
in
{
  home.packages = [
    tmuxPopup
  ];

  programs.tmux = {
    enable = true;

    terminal = "xterm-ghostty";
    baseIndex = 1; # Start pane and window indices at 1 instead of 0
    reverseSplit = true;

    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.rose-pine;
        extraConfig = ''
          set -g @rose_pine_variant 'main'
          set -g @rose_pine_host 'on' # Enables hostname in the status bar
          set -g @rose_pine_user 'on' # Turn on the username component in the statusbar
          set -g @rose_pine_bar_bg_disable 'on' # Disables background color, for transparent terminal emulators
          # If @rose_pine_bar_bg_disable is set to 'on', uses the provided value to set the background color
          # It can be any of the on tmux (named colors, 256-color set, `default` or hex colors)
          # See more on http://man.openbsd.org/OpenBSD-current/man1/tmux.1#STYLES
          set -g @rose_pine_bar_bg_disabled_color_option 'default'

          set -g @rose_pine_default_window_behavior 'on' # Forces tmux default window list behaviour
          set -g @rose_pine_show_current_program 'on' # Forces tmux to show the current running program as window name
          set -g @rose_pine_show_pane_directory 'on' # Forces tmux to show the current directory as window name
        '';
      }
      # session
      tmuxPlugins.resurrect
    ];

    extraConfig = ''
      set -g mouse on
      set -wg mode-keys vi
      set -sg escape-time 10                    # faster command sequence
      set -sg repeat-time 400                   # increase repeat timeout
      set-option -g renumber-windows on         # renumber windows when a window is closed
       
      set -s set-clipboard external
      set -g allow-passthrough on
      set -s copy-command ${
        if isDarwin then "pbcopy" else "wl-copy"
      }  # use pbcopy on macOS, wl-copy on Linux

      bind "'" if-shell "[[ $(tmux display-message -p '#S') = floating* ]]" {
          detach-client
      } {
        run-shell tmux-popup
      }

      # detach client
      bind C-d detach \; display "Detached from session!"

      # reload config with prefix + r
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"

      # split current window horizontally and vertically
      bind _ split-window -v
      bind - split-window -h

      # pane evenly
      bind | select-layout even-horizontal \; display "Even horizontal split!"

      # pane navigation
      bind -r h select-pane -L  # move left
      bind -r j select-pane -D  # move down
      bind -r k select-pane -U  # move up
      bind -r l select-pane -R  # move right

      # pane resizing
      bind -r H resize-pane -L 2
      bind -r J resize-pane -D 2
      bind -r K resize-pane -U 2
      bind -r L resize-pane -R 2

      # window navigation
      unbind n
      unbind p
      bind d run -b "tmux rename-window \"#{b:pane_current_path}\"" # rename current window to CWD
      bind -r C-h previous-window                             # select previous window
      bind -r C-l next-window                                 # select next window
      bind -r C-j swap-window -t -1 \; select-window -t -1  # swap current window with the previous one
      bind -r C-k swap-window -t +1 \; select-window -t +1  # swap current window with the next one
      bind Tab last-window                                    # move to last active window

      # choose window in current session
      bind w display-popup -w 90% -h 90% -E \
        "tmux list-windows -F '#{window_index}: #{window_name}' | \
        fzf --ansi --reverse --preview 'tmux capture-pane -e -pt $(echo {} | cut -d: -f1)' --preview-window=right:70%:wrap | \
        cut -d: -f1 | \
        xargs tmux select-window -t"

      # sesh integration
      bind s run-shell "sesh connect \"$(
        sesh list --icons | fzf-tmux -p 80%,70% \
          --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
          --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
          --bind 'tab:down,btab:up' \
          --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
          --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list --icons -t)' \
          --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list --icons -c)' \
          --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list --icons -z)' \
          --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
          --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
          --preview-window 'right:55%' \
          --preview 'sesh preview {}'
      )\""
    '';
  };
}
