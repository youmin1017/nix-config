{ config, lib, ... }:
{
  services.github-runners = {
    runner_1 = {
      enable = true;
      name = "nixos-dev-runner-1";
      url = "https://github.com/WKEBaaS";
      tokenFile = config.sops.secrets."env/github/runner_1/token".path;
    };
  };

  sops.secrets."env/github/runner_1/token" = {
    sopsFile = lib.custom.relativeToRoot "secrets/github.yaml";
  };
}
