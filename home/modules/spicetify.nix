{ inputs, ... }:
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];
  programs.spicetify.enable = true;
  programs.spicetify.enabledExtensions = builtins.attrValues {
    inherit (inputs.spicetify-nix.legacyPackages.x86_64-linux.extensions)
      adblock
      beautifulLyrics # Apple Music like Lyrics
      copyLyrics
      fullAlbumDate
      popupLyrics # Popup window with the current song's lyrics scrolling across it
      shuffle # Shuffle properly, using Fisher-Yates with zero bias
      ;
  };
}
