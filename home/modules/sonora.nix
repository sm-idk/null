{
  inputs,
  ...
}:
{
  imports = [ inputs.sonora.homeManagerModules.default ];
  programs.sonora.enable = true;
}
