_: {
  blockIpv4FromList =
    ips: ips |> builtins.map (ip: "ip saddr ${ip} drop") |> builtins.concatStringsSep "\n";
  blockIpv6FromList =
    ips: ips |> builtins.map (ip: "ip6 saddr ${ip} drop") |> builtins.concatStringsSep "\n";
}
