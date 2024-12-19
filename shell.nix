{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.python312
    pkgs.yamlfmt
  ];

  shellHook = ''
    pip install filelock pre-commit ruff

    if [ ! -d "venv" ]; then
      virtualenv venv
    fi

    source venv/bin/activate

    yamlfmt --version
    ruff --version
    pre-commit install
  '';
}
