_: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap"; 
    global.brewfile = true;
    
    taps = [
      { name = "theboredteam/boring-notch"; trusted = true; }
    ];

    brews = [
      "xcode-build-server"
    ];

    casks = [
      "font-maple-mono-normal-nf-cn"
      "hex-fiend"
      "iterm2"
      "visual-studio-code"
      "appcleaner"
      "linearmouse"
      "localsend"
      "keka"
      "secretive"
      "shottr"
      "theboredteam/boring-notch/boring-notch"
      "uninstallpkg"
      "baidunetdisk"
      "bitwarden"
      "firefox"
      "google-chrome"
      "gpg-suite"
      "handbrake-app"
      "iina"
      "inkscape"
      "mediainfo"
      "obs"
      "prismlauncher"
      "qbittorrent"
      "steam"
      "xld"
    ];
  };
}
