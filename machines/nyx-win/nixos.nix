{
  inputs,
  pkgs,
  username,
  ...
}:
{
  environment.systemPackages = [ ];
  imports = [
    ../../nixos/core
    ../../nixos/gui
  ]
  ++ (with inputs.nixos-hardware.nixosModules; [
    common-cpu-amd
    common-cpu-amd-pstate
    common-cpu-amd-zenpower
    common-gpu-nvidia-nonprime
    common-hidpi
    common-pc
    common-pc-ssd
  ]);
  security.pam.services.greetd.enableGnomeKeyring = true;
  services = {
    xserver.xkb = {
      layout = "jp";
      model = "pc105";
      options = "caps:none,compose:paus";
      variant = "OADG109A";
    };
  };
  system.stateVersion = "25.05";
  users.users."${username}" = {
    extraGroups = [
      "audio"
      "dialout"
      "networkmanager"
      "video"
      "wheel"
    ];
    isNormalUser = true;
    shell = pkgs.zsh;
  };
}
