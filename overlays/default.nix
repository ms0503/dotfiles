{
  default =
    final: prev:
    let
      inherit (final) lib;
    in
    {
      alcom = prev.alcom.overrideAttrs (
        _: prev': {
          nativeBuildInputs = builtins.concatLists [
            (prev'.nativeBuildInputs or [ ])
            (with final; [
              makeBinaryWrapper
            ])
          ];
          # See https://github.com/tauri-apps/tauri/issues/10702
          postInstall =
            (prev'.postInstall or "")
            + lib.optionalString final.stdenv.hostPlatform.isLinux ''
              wrapProgram "$out/bin/ALCOM" \
                --set __GL_THREADED_OPTIMIZATIONS 0 \
                --set __NV_DISABLE_EXPLICIT_SYNC 1
            '';
        }
      );
      gimp = final.gimp3;
      gimp3 = prev.gimp.overrideAttrs (
        let
          python = final.python3.withPackages (
            pp: with pp; [
              pygobject3
            ]
          );
        in
        _: prev: {
          preFixup = prev.preFixup + ''
            gappsWrapperArgs+=(
              --prefix PATH : ${
                lib.makeBinPath [
                  python
                ]
              }
            )
          '';
        }
      );
      platformio-core = prev.platformio-core.overrideAttrs (
        _: _: {
          disabledTestPaths = [
            "tests/commands/pkg/test_exec.py::test_pkg_specified"
            "tests/commands/pkg/test_exec.py::test_unrecognized_options"
            "tests/commands/pkg/test_install.py"
            "tests/commands/pkg/test_list.py"
            "tests/commands/pkg/test_outdated.py"
            "tests/commands/pkg/test_search.py"
            "tests/commands/pkg/test_show.py"
            "tests/commands/pkg/test_uninstall.py"
            "tests/commands/pkg/test_update.py"
            "tests/commands/test_boards.py"
            "tests/commands/test_check.py"
            "tests/commands/test_ci.py::test_ci_boards"
            "tests/commands/test_ci.py::test_ci_build_dir"
            "tests/commands/test_ci.py::test_ci_keep_build_dir"
            "tests/commands/test_ci.py::test_ci_lib_and_board"
            "tests/commands/test_ci.py::test_ci_project_conf"
            "tests/commands/test_init.py::test_init_custom_framework"
            "tests/commands/test_init.py::test_init_duplicated_boards"
            "tests/commands/test_init.py::test_init_enable_auto_uploading"
            "tests/commands/test_init.py::test_init_ide_atom"
            "tests/commands/test_init.py::test_init_ide_clion"
            "tests/commands/test_init.py::test_init_ide_eclipse"
            "tests/commands/test_init.py::test_init_ide_vscode"
            "tests/commands/test_init.py::test_init_incorrect_board"
            "tests/commands/test_init.py::test_init_special_board"
            "tests/commands/test_lib.py::test_global_install_archive"
            "tests/commands/test_lib.py::test_global_install_registry"
            "tests/commands/test_lib.py::test_global_install_repository"
            "tests/commands/test_lib.py::test_global_lib_list"
            "tests/commands/test_lib.py::test_global_lib_uninstall"
            "tests/commands/test_lib.py::test_global_lib_update"
            "tests/commands/test_lib.py::test_global_lib_update_check"
            "tests/commands/test_lib.py::test_install_duplicates"
            "tests/commands/test_lib.py::test_lib_show"
            "tests/commands/test_lib.py::test_lib_stats"
            "tests/commands/test_lib.py::test_saving_deps"
            "tests/commands/test_lib.py::test_search"
            "tests/commands/test_lib.py::test_update"
            "tests/commands/test_lib_complex.py::test_global_install_archive"
            "tests/commands/test_lib_complex.py::test_global_install_registry"
            "tests/commands/test_lib_complex.py::test_global_install_repository"
            "tests/commands/test_lib_complex.py::test_global_lib_list"
            "tests/commands/test_lib_complex.py::test_global_lib_uninstall"
            "tests/commands/test_lib_complex.py::test_global_lib_update"
            "tests/commands/test_lib_complex.py::test_global_lib_update_check"
            "tests/commands/test_lib_complex.py::test_install_duplicates"
            "tests/commands/test_lib_complex.py::test_lib_show"
            "tests/commands/test_lib_complex.py::test_lib_stats"
            "tests/commands/test_lib_complex.py::test_search"
            "tests/commands/test_platform.py"
            "tests/commands/test_run.py"
            "tests/commands/test_test.py"
            "tests/misc/ino2cpp/test_ino2cpp.py"
            "tests/misc/test_maintenance.py"
            "tests/package/test_manager.py::test_download"
            "tests/package/test_manager.py::test_install_force"
            "tests/package/test_manager.py::test_install_from_registry"
            "tests/package/test_manager.py::test_install_lib_depndencies"
            "tests/package/test_manager.py::test_registry"
            "tests/package/test_manager.py::test_uninstall"
            "tests/package/test_manager.py::test_update_with_metadata"
            "tests/package/test_manager.py::test_update_without_metadata"
            "tests/test_builder.py::test_build_flags"
            "tests/test_builder.py::test_build_unflags"
            "tests/test_builder.py::test_debug_custom_build_flags"
            "tests/test_builder.py::test_debug_default_build_flags"
            "tests/test_misc.py::test_api_cache"
            "tests/test_misc.py::test_ping_internet_ips"
            "tests/test_misc.py::test_platformio_cli"
            "tests/test_pkgmanifest.py::test_packages"
          ];
        }
      );
      pnpm = prev.pnpm.override {
        nodejs-slim = final.nodejs-slim_latest;
      };
      prismlauncher = prev.prismlauncher.overrideAttrs (
        _: prev': {
          qtWrapperArgs = builtins.concatLists [
            (prev'.qtWrapperArgs or [ ])
            [
              "--unset WAYLAND_DISPLAY"
            ]
          ];
        }
      );
      realvnc-vnc-viewer =
        assert lib.versionOlder prev.realvnc-vnc-viewer.version "8.0.0";
        prev.realvnc-vnc-viewer.overrideAttrs (
          final': prev': {
            buildInputs = with final; [
              at-spi2-atk
              cairo
              fontconfig.lib
              glib
              gtk3
              libepoxy
              pango
            ];
            meta = prev'.meta // {
              mainProgram = "rvncconnect";
            };
            name = "${final'.pname}-${final'.version}";
            postPatch = ''
              substituteInPlace ./usr/share/applications/com.realvnc.rvncconnect.desktop \
                --replace /usr/lib/rvncconnect/rvncconnect rvncconnect \
                --replace /usr/share/icons/hicolor/scalable/apps/com.realvnc.rvncconnect.svg com.realvnc.rvncconnect.svg
              substituteInPlace ./usr/share/applications/com.realvnc.rvncconnect.connect.uri.desktop \
                --replace /usr/lib/rvncconnect/rvncconnect rvncconnect
            '';
            preInstall = ''
              install -dm755 ./usr/bin
              ln -s ../lib/rvncconnect/rvncconnect ./usr/bin/rvncconnect
              for data in $(find ./usr/lib/.build-id -type l -exec sh -c 'echo {},$(readlink {} | sed "s;^../../../../usr;../../..;")' \;); do
                IFS=, read -a d <<<"$data"
                rm "''${d[0]}"
                ln -s "''${d[1]}" "''${d[0]}"
              done
              unset d
            '';
            src = final.fetchurl rec {
              hash = "sha256-k0n6VuPwUEBpEQinCs+rabziMNqZR0At/4ONBHVnJSo=";
              name = "RealVNC-Connect-Viewer-${final'.version}-Linux-x64.rpm";
              url = "https://downloads.realvnc.com/download/file/realvnc-connect-viewer/${name}";
            };
            version = "8.4.2";
          }
        );
      yarn-berry = prev.yarn-berry.override {
        nodejs = final.nodejs_latest;
      };
    };
}
