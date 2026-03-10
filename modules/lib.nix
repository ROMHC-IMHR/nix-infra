{
  self,
  inputs,
  ...
}: {
  flake.lib = {
    muncherUser = {
      username,
      fullname,
      uid,
      sshKeys,
      extraPkgs ? [],
    }: let
      hddPath = "/mnt/hddstore/users/${username}";
      hddHomePath = "/home/${username}/hdd";
      ssdPath = "mnt/ssdstore/users/${username}";
      ssdHomePath = "/home/${username}/ssd";
    in
      {pkgs, ...}: {
        users.users."${username}" = {
          isNormalUser = true;
          description = fullname;
          uid = uid;
          openssh.authorizedKeys.keys = sshKeys;
          packages = with pkgs; [
            uv
          ];
        };
        fileSystems."${ssdHomePath}" = {
          device = ssdPath;
          options = ["bind"];
          depends = ["/mnt/ssdstore"];
        };
        fileSystems."${hddHomePath}" = {
          device = hddPath;
          options = ["bind"];
          depends = ["/mnt/hddstore"];
        };
        systemd.tmpfiles.rules = [
          "d ${ssdPath} 0700 ${username} users -"
          "d ${ssdHomePath} 0700 ${username} users -"
          "d ${hddPath} 0700 ${username} users -"
          "d ${hddHomePath} 0700 ${username} users -"
        ];
      };
    mkUvDrv = {
      pkgs,
      uv2nix,
      pyproject-build-systems,
    }: {
      pname,
      src,
      entrypoint ? pname,
    }: let
      workspace = uv2nix.lib.workspace.loadWorkspace {
        workspaceRoot = src;
      };
      overlay = workspace.mkPyprojectOverlay {
        sourcePreference = "wheel";
      };
      pythonSet =
        (pkgs.callPackage inputs.pyproject-nix.build.packages {
          python = pkgs.python3;
        }).overrideScope (
          pkgs.lib.composeManyExtensions ([
              pyproject-build-systems.overlays.default
              overlay
            ]
            ++ self.mcp.pythonOverrides)
        );
      venv = pythonSet.mkVirtualEnv "${pname}-env" workspace.deps.default;
    in
      pkgs.writeShellScriptBin pname ''
        exec ${venv}/bin/${entrypoint} "$@"
      '';
  };
}
