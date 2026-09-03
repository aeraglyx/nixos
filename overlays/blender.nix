# inspired by https://github.com/edolstra/nix-warez

final: prev:
let
    inherit (final) lib;

    srcOfficial = version: hash: (
        let majorMinor = lib.versions.majorMinor version; in
        import <nix/fetchurl.nix> {
            url = "https://download.blender.org/release/Blender${majorMinor}/blender-${version}-linux-x64.tar.xz";
            inherit hash;
        }
    );

    mkBlender = { version, src }:
        with final;

        let
            majorMinor = lib.versions.majorMinor version;
            libs = [
                wayland
                libdecor
                libx11
                libxi
                libxxf86vm
                libxfixes
                libxrender
                libsm
                libice
                libxkbcommon
                libGLU
                libglvnd
                numactl
                SDL2
                libdrm
                ocl-icd
                stdenv.cc.cc.lib
                openal
                alsa-lib
                pulseaudio
                zlib
            ];
        in

        stdenv.mkDerivation {
            pname = "blender-bin";
            inherit version src;

            buildInputs = [ makeWrapper ];

            preUnpack = ''
                mkdir -p $out/libexec
                cd $out/libexec
            '';

            installPhase = ''
                cd $out/libexec
                mv blender-* blender

                mkdir -p $out/share/applications
                mv ./blender/blender.desktop $out/share/applications/blender-${majorMinor}.desktop

                substituteInPlace $out/share/applications/blender-${majorMinor}.desktop \
                    --replace "Name=Blender" "Name=Blender ${version}" \
                    --replace "Exec=blender" "Exec=blender-${version}"

                mkdir $out/bin
                makeWrapper $out/libexec/blender/blender $out/bin/blender-${version} \
                    --prefix LD_LIBRARY_PATH : /run/opengl-driver/lib:${lib.makeLibraryPath libs}

                patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
                    blender/blender

                patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
                    $out/libexec/blender/*/python/bin/python3*
            '';

            meta.mainProgram = "blender-${version}";
        };

    mkBlenderSymlink = final: blender: final.symlinkJoin {
        name = "blender";
        paths = [ blender ];
        postBuild = ''
            ln -sf ${blender}/bin/blender-${lib.getVersion blender} $out/bin/blender
        '';
    };

in rec {

    blender_5_2 = mkBlender rec {
        version = "5.2.0";
        src = srcOfficial version "sha256-lvbBgaMPSVBgeDnchNQqNUslDYoCMbCYtZt7xpw1HEg=";
    };

    blender = mkBlenderSymlink final blender_5_2;

}
