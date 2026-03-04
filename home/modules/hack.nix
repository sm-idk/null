{
  pkgsUnstable,
  ...
}:
{
  # programs.ghidra.enable = true;
  home.packages = builtins.attrValues {
    inherit (pkgsUnstable)
      autopsy
      nuclei
      cent
      binwalk
      valgrind
      netscanner
      zap
      amass
      httpx
      feroxbuster
      dalfox
      websocat
      ;
  };
}
