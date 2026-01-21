let
  youmin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAJG6OSYPAJ/58ZP7RrXmsxLEhlQ6RvlBoDlbrusjXBY youmin@nixos";
  # users = [ youmin ];
in
{
  "youmin-password.age".publicKeys = [ youmin ];
}
