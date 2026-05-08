class Concord < Formula
  desc "A terminal user interface client for Discord"
  homepage "https://github.com/chojs23/concord"
  version "1.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chojs23/concord/releases/download/v1.0.3/concord-aarch64-apple-darwin.tar.xz"
      sha256 "52f0b05f051b81023aeab2a1ba5e4e3707df70458e1325b60510e9317bf49656"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chojs23/concord/releases/download/v1.0.3/concord-x86_64-apple-darwin.tar.xz"
      sha256 "ecd7924b66497df506cfccd7f018491257879e32c29d2f432e731282312395e6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chojs23/concord/releases/download/v1.0.3/concord-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4379d2909260184cc7638c82876b982937765701ac830b01adb5b6a1192121ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chojs23/concord/releases/download/v1.0.3/concord-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3ccb29b1e182b4148160ecd55031409e9c0a62ea481c682af85d518648bd3ed2"
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
