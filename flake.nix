{
  description = "AI infrastructure at IMHR.";
  inputs = {
    import-tree.url = "github:vic/import-tree";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
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
        (inputs.import-tree ./apps)
        (inputs.import-tree ./shells)
      ];
    };
}
