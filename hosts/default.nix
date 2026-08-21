{ inputs, ... }:
{
  null = (import ./null { inherit inputs; }).null;
  laptop = (import ./laptop { inherit inputs; }).laptop;
  ledatel = (import ./ledatel { inherit inputs; }).ledatel;
  nothing-spacewar = (import ./nothing-spacewar { inherit inputs; }).nothing-spacewar;
  zero = (import ./zero { inherit inputs; }).zero;
}
