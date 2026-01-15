{
  description = "AI infrastructure at IMHR.";
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    kc-nix-infra.url = "github:KerryCerqueira/nix-infra";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
