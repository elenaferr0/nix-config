{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default];
}
