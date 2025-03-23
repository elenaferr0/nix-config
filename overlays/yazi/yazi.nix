{
  rustPlatform,
  fetchFromGitHub,
  lib,
  installShellFiles,
  stdenv,
  Foundation,
  rust-jemalloc-sys,
}:
rustPlatform.buildRustPackage rec {
  pname = "yazi";
  version = "25.3.2";
  src = fetchFromGitHub {
    owner = "sxyazi";
    repo = "yazi";
    rev = "v${version}";
    hash = "sha256-j1Tva+w0kkSW1OiZIm+bkdOEeXGvOlQXnXpsPZ3JOYY=";
  };
  cargoHash = "sha256-60hwDcGAJNQRkU9kOHJPvZDXWx2aJJsGYTFbVc4jrGE=";
  env.YAZI_GEN_COMPLETIONS = true;
  env.VERGEN_GIT_SHA = "Nixpkgs";
  env.VERGEN_BUILD_DATE = "2024-09-04";
  nativeBuildInputs = [installShellFiles];
  buildInputs = [rust-jemalloc-sys] ++ lib.optionals stdenv.hostPlatform.isDarwin [Foundation];
  postInstall = ''
    installShellCompletion --cmd yazi \
      --bash ./yazi-boot/completions/yazi.bash \
      --fish ./yazi-boot/completions/yazi.fish \
      --zsh  ./yazi-boot/completions/_yazi
    install -Dm444 assets/yazi.desktop -t $out/share/applications
    install -Dm444 assets/logo.png $out/share/pixmaps/yazi.png
  '';
  passthru.updateScript.command = [./update.sh];
  meta = {
    description = "Blazing fast terminal file manager written in Rust, based on async I/O";
    homepage = "https://github.com/sxyazi/yazi";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      eljamm
      khaneliman
      linsui
      matthiasbeyer
      uncenter
      xyenon
    ];
    mainProgram = "yazi";
  };
}
