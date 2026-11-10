{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.ms0503.sound.streaming.sender;
  stream-node-name = "rtp-sender";
in
{
  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.destination.name != null;
        message = "ms0503.sound.streaming.sender.destination.name must be set";
      }
      {
        assertion = cfg.input-sink.fl != null;
        message = "ms0503.sound.streaming.sender.input-sink.fl must be set";
      }
      {
        assertion = cfg.input-sink.fr != null;
        message = "ms0503.sound.streaming.sender.input-sink.fr must be set";
      }
    ];
    services.pipewire = {
      extraConfig.pipewire."99-rtp-sender"."context.modules" = [
        {
          args = {
            "audio.channels" = 2;
            "audio.format" = "F32LE";
            "audio.rate" = 48000;
            "destination.ip" = cfg.destination.name;
            "destination.port" = cfg.destination.port;
            "sess.media" = "opus";
            "sess.name" = cfg.destination.name;
            "stream.props"."node.name" = stream-node-name;
          };
          name = "libpipewire-module-rtp-sink";
        }
      ];
      wireplumber = {
        extraConfig."99-rtp-sender" = {
          "wireplumber.components" = [
            {
              name = "ms0503/rtp-sender-restore-links.lua";
              provides = "hooks.restore-links";
              type = "script/lua";
            }
          ];
          "wireplumber.profiles".main."hooks.restore-links" = "required";
        };
        extraScripts."ms0503/rtp-sender-restore-links.lua" =
          builtins.readFile ./rtp-sender-restore-links.lua
          |>
            builtins.replaceStrings
              [
                "@input_sink_fl@"
                "@input_sink_fr@"
                "@stream_node_name@"
              ]
              [
                cfg.input-sink.fl
                cfg.input-sink.fr
                stream-node-name
              ];
      };
    };
  };
  options.ms0503.sound.streaming.sender = {
    destination = mkOption {
      description = "Destination host";
      type = types.submodule {
        options = {
          name = mkOption {
            default = null;
            description = "Destination host name or ip address";
            type = types.nullOr types.str;
          };
          port = mkOption {
            default = 5004;
            description = "Destination host port";
            type = types.port;
          };
        };
      };
    };
    enable = mkEnableOption "a sound stream sender";
    input-sink = mkOption {
      description = "Input sink (often named something like 'alsa_output.pci-*.analog-stereo:monitor_*')";
      type = types.submodule {
        options = {
          fl = mkOption {
            default = null;
            description = "Front left output of input sink (often named something like 'alsa_output.pci-*.analog-stereo:monitor_FL')";
            type = types.nullOr types.str;
          };
          fr = mkOption {
            default = null;
            description = "Front right output of input sink (often named something like 'alsa_output.pci-*.analog-stereo:monitor_FR')";
            type = types.nullOr types.str;
          };
        };
      };
    };
    stream-node-name = mkOption {
      default = stream-node-name;
      description = "RTP stream node name";
      readOnly = true;
      type = types.str;
    };
  };
}
