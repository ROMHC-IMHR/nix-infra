{
  description = "AI infrastructure at IMHR.";
  inputs = {
    arion.url = "github:hercules-ci/arion";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    kc-nix-infra = {
      url = "github:KerryCerqueira/nix-infra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    owui-nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    ollama-nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    docling-nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    mcpo-nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    expy = {
      url = "github:KerryCerqueira/expy";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tgi-flake.url = "github:huggingface/text-generation-inference";
    pyproject-nix = {
      url = "github:pyproject-nix/pyproject.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pyproject-build-systems = {
      url = "github:pyproject-nix/build-system-pkgs";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.uv2nix.follows = "uv2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    uv2nix = {
      url = "github:pyproject-nix/uv2nix";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    nixpkgs,
    flake-parts,
    expy,
    tgi-flake,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      imports = [
        inputs.home-manager.flakeModules.home-manager
        (inputs.import-tree ./modules)
      ];
    };
}
