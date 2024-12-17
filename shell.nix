{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.python3Packages.virtualenv
    pkgs.yamlfmt
  ];

  shellHook = ''
    if [ ! -d "venv" ]; then
      virtualenv venv
    fi
    source venv/bin/activate
    pip install yamllint pre-commit
    yamlfmt --version
    // install pre-hooks
    pre-commit install
  '';
}
