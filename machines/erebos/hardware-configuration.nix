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
        "nvme"
        "xhci_pci"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ ];
    };
    kernelModules = [
      "kvm-amd"
    ];
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/1a65a80d-1d3e-41e4-9be8-88fcf40af1d4";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/6897-AF55";
      fsType = "vfat";
      options = [
        "dmask=0022"
        "fmask=0022"
      ];
    };
  };
  hardware.cpu.amd.updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;
  imports = [
    "${modulesPath}/installer/scan/not-detected.nix"
  ];
  networking.useDHCP = mkDefault true;
  nixpkgs.hostPlatform = mkDefault "x86_64-linux";
  swapDevices = [
    {
      device = "/dev/disk/by-uuid/0a943e07-390e-4810-a528-d1845c862246";
    }
  ];
}
