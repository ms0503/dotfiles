{
  config,
  lib,
  modulesPath,
  ...
}:
let
  inherit (lib) mkDefault;
in
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
      device = "/dev/disk/by-uuid/883dcc72-bb12-483c-97d1-89ffcbe3b1cc";
      fsType = "btrfs";
      options = [
        "compress=zstd"
        "discard=async"
      ];
    };
  };
  hardware.cpu.intel.updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;
  imports = [
    "${modulesPath}/installer/scan/not-detected.nix"
  ];
  nixpkgs.hostPlatform = mkDefault "x86_64-linux";
  swapDevices = [
    {
      device = "/dev/disk/by-uuid/5430ace0-7cac-4a40-83bc-0e98013316df";
    }
  ];
}
