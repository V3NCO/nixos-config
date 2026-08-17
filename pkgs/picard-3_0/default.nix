{
  lib,
  stdenv,
  python313Packages,
  fetchFromGitHub,
  chromaprint,
  gettext,
  qt6,
  enablePlayback ? true,
  gst_all_1,
  writableTmpDirAsHomeHook,
  nix-update-script,
  cacert,
}:

let
  pythonPackages = python313Packages;
  pyqt6 = pythonPackages.pyqt6;
in

pythonPackages.buildPythonApplication (finalAttrs: {
  pname = "picard";
  version = "3.0.0b9";
  pyproject = true;
  strictDeps = true;
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "metabrainz";
    repo = "picard";
    tag = "release-${finalAttrs.version}";
    hash = "sha256-obY6SRdBoF33b4OTWl3nygGn2p7uzDsBgxKuuP2naGU=";
  };

  nativeBuildInputs = [
    gettext
    qt6.wrapQtAppsHook
    pythonPackages.setuptools
  ];

  buildInputs = [
    qt6.qtbase
  ]
  ++ lib.optionals (lib.meta.availableOn stdenv.hostPlatform qt6.qtwayland) [
    qt6.qtwayland
  ]
  ++ lib.optionals enablePlayback [
    qt6.qtmultimedia
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
  ];

  pythonRelaxDeps = lib.optionals stdenv.hostPlatform.isDarwin [
    "pyobjc-core"
    "pyobjc-framework-Cocoa"
    "pyobjc-framework-MediaPlayer"
  ];

  # Mirrors pyproject.toml's [project.dependencies].
  dependencies =
    with pythonPackages;
    [
      charset-normalizer
      chromaprint
      discid
      markdown
      mutagen
      pygit2
      pyjwt
      pyqt6
      pyyaml
      tomlkit
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [
      pyobjc-core
      pyobjc-framework-Cocoa
      pyobjc-framework-MediaPlayer
    ];

  disabledTestPaths = lib.optionals stdenv.hostPlatform.isDarwin [
    "test/test_const_appdirs.py::AppPathsTest::test_cache_folder_macos"
    "test/test_const_appdirs.py::AppPathsTest::test_config_folder_macos"
    "test/test_const_appdirs.py::AppPathsTest::test_plugin_folder_macos"
    "test/test_plugins.py"
    "test/test_utils.py::HiddenFileTest::test_macos"
  ];

  setupPyGlobalFlags = [
    "build"
    "--disable-autoupdate"
  ];

  nativeCheckInputs = [
    pythonPackages.pytestCheckHook
    writableTmpDirAsHomeHook
  ];

  doCheck = true;

  preCheck = ''
     export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
  '';

  preFixup = ''
    makeWrapperArgs+=("''${qtWrapperArgs[@]}")
  ''
  + lib.optionalString enablePlayback ''
    makeWrapperArgs+=(--prefix GST_PLUGIN_SYSTEM_PATH_1_0 : "$GST_PLUGIN_SYSTEM_PATH_1_0")
  '';

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version-regex"
      "release-(.*)"
    ];
  };

  meta = {
    homepage = "https://picard.musicbrainz.org";
    changelog = "https://picard.musicbrainz.org/changelog";
    description = "Official MusicBrainz tagger (3.0 beta)";
    mainProgram = "picard";
    license = lib.licenses.gpl2Plus;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ doronbehar ];
  };
})
