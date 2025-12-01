{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  
  networking.networkmanager.enable = true;

  # Timezone/locale
  time.timeZone = "Africa/Kampala"; 
  i18n.defaultLocale = "en_US.UTF-8";

  # Users
  users.users.yourusername = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager"];  # For sudo
    initialPassword = "changeme";
  };

  # Enable sudo without password
  security.sudo.wheelNeedsPassword = false;

  # Packages/services
  virtualisation.vmware.guest.enable = true;
  environment.systemPackages = with pkgs; [ git vim wget open-vm-tools ];
  services.openssh.enable = true;  #for SSH access

  system.stateVersion = "25.05";  #Nix version
}
