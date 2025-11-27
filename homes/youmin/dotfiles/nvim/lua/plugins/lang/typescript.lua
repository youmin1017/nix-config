---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        root_dir = function(bufnr, on_dir)
          -- The project root is where the LSP can be started from
          -- As stated in the documentation above, this LSP supports monorepos and simple projects.
          -- We select then from the project root, which is identified by the presence of a package
          -- manager lock file.
          local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
          -- Give the root markers equal priority by wrapping them in a table
          root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
            or vim.list_extend(root_markers, { ".git" })

          -- -- exclude deno
          -- if vim.fs.root(bufnr, { "deno.json", "deno.jsonc", "deno.lock" }) then
          --   return
          -- end

          -- We fallback to the current working directory if no project root is found
          local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

          on_dir(project_root)
        end,
      },
    },
    setup = {
      --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
      --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
      tsserver = function()
        -- disable tsserver
        return true
      end,
      ts_ls = function()
        -- disable tsserver
        return true
      end,
      denols = function()
        -- disable denols
        return true
      end,
      vtsls = function(_, opts)
        Snacks.util.lsp.on({ name = "vtsls" }, function(buffer, client)
          client.commands["_typescript.moveToFileRefactoring"] = function(command, ctx)
            ---@type string, string, lsp.Range
            local action, uri, range = unpack(command.arguments)

            local function move(newf)
              client:request("workspace/executeCommand", {
                command = command.command,
                arguments = { action, uri, range, newf },
              })
            end

            local fname = vim.uri_to_fname(uri)
            client:request("workspace/executeCommand", {
              command = "typescript.tsserverRequest",
              arguments = {
                "getMoveToRefactoringFileSuggestions",
                {
                  file = fname,
                  startLine = range.start.line + 1,
                  startOffset = range.start.character + 1,
                  endLine = range["end"].line + 1,
                  endOffset = range["end"].character + 1,
                },
              },
            }, function(_, result)
              ---@type string[]
              local files = result.body.files
              table.insert(files, 1, "Enter new path...")
              vim.ui.select(files, {
                prompt = "Select move destination:",
                format_item = function(f)
                  return vim.fn.fnamemodify(f, ":~:.")
                end,
              }, function(f)
                if f and f:find("^Enter new path") then
                  vim.ui.input({
                    prompt = "Enter move destination:",
                    default = vim.fn.fnamemodify(fname, ":h") .. "/",
                    completion = "file",
                  }, function(newf)
                    return newf and move(newf)
                  end)
                elseif f then
                  move(f)
                end
              end)
            end)
          end
        end)
        -- copy typescript settings to javascript
        opts.settings.javascript =
          vim.tbl_deep_extend("force", {}, opts.settings.typescript, opts.settings.javascript or {})
      end,
    },
  },
}
