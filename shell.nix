{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.python3Packages.virtualenv
    pkgs.yamlfmt
    pkgs.kubectx
    pkgs.minio-client
  ];

  shellHook = ''
    if [ ! -d "venv" ]; then
      virtualenv venv
    fi
    source venv/bin/activate
    pip install pre-commit
    yamlfmt --version
    mc --version
    pre-commit install
  '';
}
