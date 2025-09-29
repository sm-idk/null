{
  config,
  pkgs,
  ...
}:
{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium; # Ensure this is set if you want to manage it here
    extensions =
      let
        createChromiumExtensionFor =
          browserVersion:
          {
            id,
            sha256,
            version,
          }:
          {
            inherit id;
            crxPath = builtins.fetchurl {
              url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
              name = "${id}.crx";
              inherit sha256;
            };
            inherit version;
          };
        createChromiumExtension = createChromiumExtensionFor (
          pkgs.lib.versions.major config.programs.chromium.package.version
        );
      in
      [
        (createChromiumExtension {
          id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
          sha256 = "sha256:0pdh1v0vx1d5vnl1zh7nbk6j1fh4k4hhwp1ljs203icn306lahsn";
          version = "1.66.4";
        })
        (createChromiumExtension {
          id = "oboonakemofpalcgghocfoadofidjkkk";
          sha256 = "sha256:0zlmwiyzn4cznzrvavp2nsj07v4lrdyi7nw5aarqnj7nj12gixh7";
          version = "1.9.9.6";
        })
        (createChromiumExtension {
          id = "enamippconapkdmgfgjchkhakpfinmaj";
          sha256 = "sha256:118qgvkfrmdcw2blwwa06l5l79fax15qkcal68a8b120vc11jgsx";
          version = "2.1.10";
        })
        (createChromiumExtension {
          id = "mnjggcdmjocbbbhaepdhchncahnbgone";
          sha256 = "sha256:0vwzda6dsy9cm8ml9ahxbs3j6zqjjkjfz55zmfixr0xm0aab1c9j";
          version = "6.0";
        })
      ];
  };
}
