{ inputs, username, ... }:
{
  hardware.uinput.enable = true;
  imports = [
    inputs.xremap.nixosModules.default
  ];
  services.xremap = {
    config = {
      keymap = [ ];
      modmap = [ ];
    };
    serviceMode = "user";
    userName = username;
  };
  users.groups = {
    input.members = [
      username
    ];
    uinput.members = [
      username
    ];
  };
}
