{ pkgs }:

{
    fake-bpy-module = pkgs.python311Packages.buildPythonPackage {
        pname = "fake-bpy-module";
        version = "20250613";
        src = pkgs.fetchPypi {
            pname = "fake_bpy_module";
            version = "20250613";
            sha256 = "sha256-/ZMG3ixkhmZZstfOD/1aUeU1zq9Zc/hRCpVmTJVryTw=";
        };
        doCheck = false;
        pythonImportsCheck = [ "bpy" ];
    };
}
