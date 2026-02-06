{ pkgs, pkgsUnstable, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      nil
      nixd
      nixfmt-rfc-style
      bash-language-server
      shfmt
      ;
  };
  programs.zed-editor.enable = true;
  programs.zed-editor.package = pkgsUnstable.zed-editor;
  programs.zed-editor.extensions = [
    "nix"
    "xml"
    "cspell"
    "csv"
    "toml"
    "yaml"
    "ini"
    "stylelint"
  ]
  ++ [
    "material-icon-theme"
  ];

  programs.zed-editor.userSettings = {
    auto_update = false; # Obviously we can't use that...
    telemetry = {
      diagnostics = false;
      metrics = false;
    };
    wrap_guides = [
      72
      80
      120
    ];
    icon_theme = "Material Icon Theme";

    autosave = "on_focus_change";
    disable_ai = true;

    restore_on_startup = "none";
    edit_predictions = {
      mode = "subtle";
      enabled_in_text_threads = true;
    };
    agent = {
      default_profile = "terminal";
      profiles = {
        terminal = {
          name = "TERMINAL";
          tools = {
            list_directory = true;
            read_file = true;
            open = true;
            edit_file = true;
            diagnostics = true;
            terminal = false;
          };
        };
      };
    };
    vim_mode = true;
    lsp = {
      nil = {
        formatting.command = [ "nixfmt" ];
      };
    };
  };

  programs.zed-editor.userSettings.languages = {
    "Nix" = {
      language_servers = [ "nil" ];
      formatter = {
        external = {
          command = "nixfmt";
        };
      };
    };

    "Bash" = {
      language_servers = [ "bash-language-server" ];
      formatter = {
        external = {
          command = "shfmt";
          arguments = [
            "-i"
            "2"
          ];
        };
      };
    };
  };
}
