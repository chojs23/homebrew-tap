class Concord < Formula
  desc "A terminal user interface client for Discord"
  homepage "https://github.com/chojs23/concord"
  version "1.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chojs23/concord/releases/download/v1.4.2/concord-aarch64-apple-darwin.tar.xz"
      sha256 "d66734f817d2510d67ee52967f4c8322e35c4a6e19b939ae6fd4c7f75a23e5e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chojs23/concord/releases/download/v1.4.2/concord-x86_64-apple-darwin.tar.xz"
      sha256 "f562ed70c871f24deea6f5b5aba071170824870522a7dca2ae06cf8ef7b71488"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chojs23/concord/releases/download/v1.4.2/concord-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b85f9ca1417356147c2cea5da23ee90782a7c0e705e2585524cc5d24c58f0e3b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chojs23/concord/releases/download/v1.4.2/concord-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "995d47d819d052c13dc0c1cf9020aab1c94a6190c6682a170275351260b6c895"
    end
  end
  license "GPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "concord" if OS.mac? && Hardware::CPU.arm?
    bin.install "concord" if OS.mac? && Hardware::CPU.intel?
    bin.install "concord" if OS.linux? && Hardware::CPU.arm?
    bin.install "concord" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
