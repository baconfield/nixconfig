# secrets/secrets.nix

let
    Foxsummit       = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTJTJ8rSJhyCBbev272hIq1JyD22OF5kOheBVo6z6OC";
    systems = [ Foxsummit ];
in
{
    "credentials.age".publicKeys = [ Foxsummit];
    "nextcloudPass.age".publicKeys = [ Foxsummit ];
} # nix run github:ryantm/agenix -- -e credentials.age
