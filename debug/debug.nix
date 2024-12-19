{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.kubectl
  ];

  shellHook = ''
    kubectl --help
    ls -Rla
  '';
}
