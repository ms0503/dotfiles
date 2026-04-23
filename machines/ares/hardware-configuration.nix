{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:
{
  boot = {
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules = [
        "ata_piix"
        "sr_mod"
        "uhci_hcd"
        "virtio_blk"
        "virtio_pci"
      ];
      kernelModules = [ ];
    };
    kernelModules = [
      "kvm-intel"
    ];
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/9aaa7e0a-21b0-40bf-ba35-9ab6e76f5417";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/62864fcf-9ab5-440a-aac1-154001a76405";
      fsType = "ext4";
    };
  };
  imports = [
    "${modulesPath}/profiles/qemu-guest.nix"
  ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  swapDevices = [
    {
      device = "/dev/disk/by-uuid/7a9d099c-e0a7-49a1-aef1-f0bcd63830ca";
    }
  ];
}
