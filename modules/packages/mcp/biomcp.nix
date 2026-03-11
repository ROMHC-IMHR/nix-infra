{...}: {
  perSystem = {pkgs, ...}: {
    packages.biomcp = let
      src = pkgs.fetchFromGitHub {
        owner = "genomoncology";
        repo = "biomcp";
        rev = "v0.8.14";
        hash = "sha256-Uf7ar57RKgE/VIqyuvBjM7DTsCQbEW1U4jDmtRSvCac=";
      };
    in
      pkgs.rustPlatform.buildRustPackage {
        pname = "biomcp";
        inherit src;
        version = "0.8.14";
        cargoLock.lockFile = src + "/Cargo.lock";
        nativeBuildInputs = [pkgs.protobuf];
      };
  };
}
