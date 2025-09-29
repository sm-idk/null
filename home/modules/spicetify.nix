{ spicetify-nix, ... }:
{
  imports = [ spicetify-nix.homeManagerModules.default ];
  programs.spicetify.enable = true;
  programs.spicetify.enabledExtensions = builtins.attrValues {
    inherit (spicetify-nix.legacyPackages.x86_64-linux.extensions)
      # NO❗❗❗ 🙀 😾 HOW WILL SPOTIFY MAKE MONEY FROM THEIR
      # AI-GENERATED SONGS AND KEEP ALL THE PROFITS FOR THEMSELVES?!
      # *(Allegedly)*
      adblock
      beautifulLyrics # Apple Music like Lyrics
      copyLyrics
      fullAlbumDate
      popupLyrics # Popup window with the current song's lyrics scrolling across it
      shuffle # Shuffle properly, using Fisher-Yates with zero bias
      ;
  };
}
