{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.ms0503.sound.streaming.receiver;
in
{
  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.output-sink != null;
        message = "ms0503.sound.streaming.receiver.output-sink must be set";
      }
    ];
    services.pipewire.extraConfig.pipewire."99-rtp-receiver"."context.modules" = [
      {
        args = {
          "audio.channels" = 2;
          "audio.format" = "F32LE";
          "audio.rate" = 48000;
          "sess.media" = "opus";
          "source.ip" = "0.0.0.0";
          "source.port" = 5004;
          "stream.props" = {
            "node.name" = "rtp-receiver";
            "target.object" = cfg.output-sink;
          };
        };
        name = "libpipewire-module-rtp-source";
      }
    ];
  };
  options.ms0503.sound.streaming.receiver = {
    enable = mkEnableOption "a sound stream receiver";
    output-sink = mkOption {
      default = null;
      description = "Output sink (often named something like 'alsa_output.pci-*.analog-stereo')";
      type = types.nullOr types.str;
    };
  };
}
