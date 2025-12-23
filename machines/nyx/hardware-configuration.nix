{
  config,
  lib,
  modulesPath,
  ...
}:
{
  boot = {
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "sr_mod"
      ];
      kernelModules = [ ];
    };
    kernelModules = [
      "kvm-amd"
    ];
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/cd0b5b22-18f4-4a0d-abdb-e1e52dfc0a16";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/93E4-CDB7";
      fsType = "vfat";
      options = [
        "dmask=0022"
        "fmask=0022"
      ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/42eb0a26-798a-4e53-a9c7-fe84792a901b";
      fsType = "ext4";
    };
    "/mnt/Games" = {
      device = "/dev/disk/by-uuid/dd212c79-36bb-401f-959e-30696bc5fc7b";
      fsType = "ext4";
    };
    "/mnt/GamesHDD" = {
      device = "/dev/disk/by-uuid/96ec8c60-e47d-4685-9e76-b0a48ac6b7fd";
      fsType = "ext4";
    };
    "/mnt/Movie" = {
      device = "/dev/disk/by-uuid/1F8F-2BF1";
      fsType = "vfat";
    };
    "/mnt/Repo" = {
      device = "/dev/disk/by-uuid/277196c0-dc11-4ee3-98b9-65f849039f30";
      fsType = "ext4";
    };
  };
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  swapDevices = [
    {
      device = "/dev/disk/by-uuid/ae27955d-245c-465d-ad7a-1e24a2a310f0";
    }
  ];
}
