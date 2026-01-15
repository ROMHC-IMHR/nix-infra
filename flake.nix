{
  description = "AI infrastructure at IMHR.";
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    kc-nix-infra = {
      url = "github:KerryCerqueira/nix-infra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    expy = {
      url = "github:KerryCerqueira/expy";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tgi-flake.url = "github:huggingface/text-generation-inference";
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
        (inputs.import-tree ./modules)
        (inputs.import-tree ./shells)
      ];
    };
}
