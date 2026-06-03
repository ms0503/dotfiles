{ lib, myLib, ... }:
let
  inherit (lib)
    attrValues
    flip
    last
    mkOption
    sort
    types
    ;
  inherit (myLib) const;
in
{
  options.ms0503.feature-set =
    let
      feature-set-max = feature-set-values |> last;
      feature-set-min = feature-set-values |> flip builtins.elemAt 0;
      feature-set-values = const.feature-sets |> attrValues |> sort (a: b: a < b);
    in
    mkOption {
      description = "Feature Set.";
      type = types.ints.between feature-set-min feature-set-max;
    };
}
