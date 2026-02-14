# Credits : https://lorenzbischof.ch/posts/detect-port-conflicts-in-nixos-services/ (why am i even crediting in my personal config)
{
  lib,
  options,
  ...
}:
let
  duplicatePorts = lib.pipe options.homelab.ports.definitionsWithLocations [
    (lib.concatMap (
      entry:
      map (port: {
        file = entry.file;
        port = port;
      }) entry.value
    ))
    (lib.groupBy (entry: toString entry.port))
    (lib.filterAttrs (port: entries: builtins.length entries > 1))
    (lib.mapAttrsToList (
      port: entries:
      "Duplicate port ${port} found in:\n" + lib.concatMapStrings (entry: "  - ${entry.file}\n") entries
    ))
    (lib.concatStrings)
  ];
in
{
  options = {
    homelab.ports = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [ ];
      description = "List of allocated port numbers";
    };
  };
  config = {
    assertions = [
      {
        assertion = duplicatePorts == "";
        message = duplicatePorts;
      }
    ];
  };
}
