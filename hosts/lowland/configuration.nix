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
  i18n.defaultLocale = "es_ES.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };
   
  services = {
    xserver = {
    layout = "es";
    videoDrivers = [ "amdgpu" ];
    xkbVariant = "";
    enable = true;
    displayManager = {
        defaultSession = "none+awesome";
#        startx.enable = true;
       autoLogin.enable = true;
       autoLogin.user = "pablo";
    };
    windowManager = {
        awesome.enable = true;
        dwm.enable = false;
    };
    desktopManager.gnome.enable = false;
   }; 
};
  # Configure console keymap
  console.keyMap = "es";

}
