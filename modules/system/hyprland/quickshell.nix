{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = lib.optional (inputs ? quickshell) (
    inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
  );
}
