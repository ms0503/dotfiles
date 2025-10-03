{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfgGUI = config.ms0503.gui;
  cfgHyprland = config.ms0503.desktop.hyprland;
in
{
  config = mkIf (cfgGUI.enable && cfgHyprland.enable) {
    home = {
      file."${config.xdg.configHome}/wofi/style.css".text = ''
        :root {
          font-size: 16px;
        }
        window {
          background-color: rgba(27, 30, 43, 0.9);
          border-radius: 0.75rem;
          font-family: "Noto Sans CJK JP";
          font-weight: bold;
          margin: 0;
        }
        #input {
          all: unset;
          background-color: rgba(200, 211, 245, 0.2);
          border-radius: 0.5rem;
          border: none;
          color: #c8d3f5;
          margin: 0.25rem;
          padding: 0.25rem;
        }
        #inner-box {
          background-color: transparent;
          border: none;
          margin: 0.25rem;
        }
        #outer-box {
          background-color: transparent;
          border: none;
          margin: 0.25rem;
        }
        #scroll {
          border: none;
          margin: 0;
        }
        #text {
          border: none;
          color: #c8d3f5;
          margin: 0.25rem;
        }
        #entry {
          border: none;
        }
        #entry:focus {
          border: none;
        }
        #entry:selected {
          background-color: rgba(200, 211, 245, 0.2);
          border-radius: 0.25rem;
          border: none;
        }
      '';
      packages = with pkgs; [
        wofi
        wofi-emoji
      ];
    };
  };
}
