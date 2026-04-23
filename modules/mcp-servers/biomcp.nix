{...}: {
  perSystem = {pkgs, ...}: {
    packages.biomcp = let
      version = "0.8.19";
    in
      pkgs.stdenv.mkDerivation {
        pname = "biomcp";
        inherit version;
        src = pkgs.fetchurl {
          url = "https://github.com/genomoncology/biomcp/releases/download/v0.8.19/biomcp-linux-x86_64.tar.gz";
          hash = "sha256:65aaa2401169818c2b989b76bfba314e90d161021d953630a0459f48e0c8175c";
        };
        meta.mainProgram = "biomcp";
        sourceRoot = ".";
        installPhase = ''
          install -Dm755 biomcp $out/bin/biomcp
        '';
      };
  };
}
