{ lib, pkgs, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      keepassxc
      ;
  };

  programs.keepassxc.settings = {
    General.MinimizeAfterUnlock = true;
    Browser.Enabled = true;
    GUI = {
      ApplicationTheme = "dark";
      ColorPasswords = true;
      MinimizeToTray = true;
      ShowTrayIcon = true;
      TrayIconAppearance = "monochrome-light";
    };
    SecretServiceIntegration.Enabled = true;
  };

  # Start KeePassXC with the graphical session so Secret Service and browser
  # integration are available immediately after unlocking your database.
  systemd.user.services.keepassxc = {
    Unit = {
      Description = "KeePassXC password manager";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${lib.getExe pkgs.keepassxc} --minimized";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
