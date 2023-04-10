# secrets/secrets.nix

let
    Foxsummit = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTJTJ8rSJhyCBbev272hIq1JyD22OF5kOheBVo6z6OC";
    TortiseCove = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILC7uVOlqHKRxQiGFwvXWoVGfOkjKdXyFAvY3rWtnh/h";
    DoveTrail = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDQysvK01pWVVxeYJ0e/TCBmJ9rotds/GhzLLfsPChfK";
    RaccoonRapids = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFh6+nX/vmyP5MSijcbL3Dv5NBI1hllZ396I45xnhpLr";
    systems = [ Foxsummit TortiseCove DoveTrail RaccoonRapids ];
in
{
    "credentials.age".publicKeys = [TortiseCove Foxsummit];
} # nix run github:ryantm/agenix -- -e credentials.age
