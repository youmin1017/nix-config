{
  isDarwin,
  lib,
  ...
}:
{
  imports = lib.flatten [
    (map lib.custom.relativeToRoot (
      if isDarwin then
        [
          "hosts/core/darwin.nix"
        ]
      else
        [
          "hosts/core/linux.nix"
        ]
    ))
  ];
}
