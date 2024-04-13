{inputs, username, ...}: {
  imports = [
    inputs.xremap.nixosModules.default
  ];
  services.xremap = {
    config.modmap = [
      {
        name = "CapsLock is dead";
        remap.CapsLock = "Ctrl_L";
      }
    ];
    serviceMode = "system";
    userName = username;
  };
}
