{ inputs, ... }:
{
  null = (import ./null { inherit inputs; }).null;
  ledatel = (import ./ledatel { inherit inputs; }).ledatel;
  zero = (import ./zero { inherit inputs; }).zero;
}
