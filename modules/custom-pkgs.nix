{ pkgs-unstable }:

{
    fake-bpy-module = pkgs-unstable.python314Packages.buildPythonPackage {
        pname = "fake-bpy-module";
        version = "20251003";
        src = pkgs-unstable.fetchPypi {
            pname = "fake_bpy_module";
            version = "20251003";
            sha256 = "sha256-Q9f9CC78NEl+I43jrU0x+4UPLRqLsHQYrjbq5WwcdDQ=";
        };
        doCheck = false;
        pythonImportsCheck = [ "bpy" ];
        pyproject = true;
        build-system = [ pkgs-unstable.python314Packages.setuptools ];
    };
}
