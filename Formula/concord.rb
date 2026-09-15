class Concord < Formula
  desc "A terminal user interface client for Discord"
  homepage "https://github.com/chojs23/concord"
  version "2.5.21"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chojs23/concord/releases/download/v2.5.21/concord-aarch64-apple-darwin.tar.xz"
      sha256 "c6eb514736b8bd97af637c9b43c7ab9167a423c0c80d067c64bd28ea0d37ee6e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chojs23/concord/releases/download/v2.5.21/concord-x86_64-apple-darwin.tar.xz"
      sha256 "26df75ef4bcde4974bc2f233869ba1f9ab296852f94f265050ed373afa222281"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chojs23/concord/releases/download/v2.5.21/concord-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2355d9ef1d991f1bd045c0668388c2f8f074e10eac6fd02d2c5bf50dbf199bea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chojs23/concord/releases/download/v2.5.21/concord-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f5447c7b17e907d07f5dd20333ac3bb1733daa2434ae39b11dac10c46bae4c04"
    end
  end
  license "GPL-3.0-only"
  on_linux do
    depends_on "alsa-lib"
    depends_on "libva"
    depends_on "mesa"
    depends_on "pipewire"
  end

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "concord"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "concord"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "concord"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "concord"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
