{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.python312
    pkgs.yamlfmt
    pkgs.k9s
    pkgs.kubectl
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
