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
        "ahci"
        "ehci_pci"
        "sd_mod"
        "sr_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
      kernelModules = [ ];
    };
    kernelModules = [
      "kvm-intel"
    ];
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/be9dc453-fb43-4c7a-a171-d0f99cdb63aa";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/9F96-EBBC";
      fsType = "vfat";
      options = [
        "dmask=0077"
        "fmask=0077"
      ];
    };
    "/data" = {
      device = "/dev/disk/by-uuid/0fb68635-2536-4e61-9138-16eb3c4807ab";
      fsType = "ext4";
    };
  };
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  swapDevices = [
    {
      device = "/dev/disk/by-uuid/5430ace0-7cac-4a40-83bc-0e98013316df";
    }
  ];
}
