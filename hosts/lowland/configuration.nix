{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../shared
    ];

    nixpkgs = {
/*    overlays = [
      outputs.overlays.modifications
      outputs.overlays.additions
      inputs.nixpkgs-f2k.overlays.stdenvs
    ];*/
    config = {
      # Disable if you don't want unfree packages
      allowUnfreePredicate = _: true;
      allowUnfree = true;
    };
  };
    
  networking.hostName = "lowland";  
  networking.networkmanager.enable = true;

  #Bootloader
  boot.kernelPackages = pkgs.linuxPackages_5_15;
  boot.loader = {
	efi = {
		canTouchEfiVariables = true;
		efiSysMountPoint = "/boot/efi";
	};
	grub = {
		devices = [ "nodev" ];
		efiSupport = true;
		enable = true;
		extraEntries = ''
		 menuentry "Windows" {
			insmod part_gpt
			insmod fat
			insmod search_fs_uuid
			insmod chain
			search --fs-uuid --set=root $FS_UUID
			chainloader /EFI/Microsoft/Boot/bootmgfw.efi
			}
		     '';
#		    version = 2;
		};
	};

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
   
  services = {
    xserver = {
        enable = true;
        dpi = 86;
        displayManager.sddm.enable = true;
        desktopManager.plasma5.enable = true;
        windowManager.awesome.enable = true;
    };
  };


}
