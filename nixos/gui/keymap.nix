{
  inputs,
  username,
  ...
}:
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
# vim: et sts=2 sw=2 ts=2
