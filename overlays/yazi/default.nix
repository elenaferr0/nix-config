self: super: {
  yazi = super.yazi.overrideAttrs (old: {
    version = "25.3.2";
    src = super.fetchFromGitHub {
      owner = "sxyazi";
      repo = "yazi";
      rev = "v25.3.2";
      hash = "sha256-j1Tva+w0kkSW1OiZIm+bkdOEeXGvOlQXnXpsPZ3JOYY="; # Replace with actual hash
    };
    cargoHash = "sha256-60hwDcGAJNQRkU9kOHJPvZDXWx2aJJsGYTFbVc4jrGE="; # Replace with actual hash
  });
}
