class Concord < Formula
  desc "A terminal user interface client for Discord"
  homepage "https://github.com/chojs23/concord"
  version "1.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chojs23/concord/releases/download/v1.4.1/concord-aarch64-apple-darwin.tar.xz"
      sha256 "8fc75cde9e062f0a4e4658e3489d2bdcf10035a8ccabf6f2e608c66f57ac5cd1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chojs23/concord/releases/download/v1.4.1/concord-x86_64-apple-darwin.tar.xz"
      sha256 "920fa1453d8a0cd7df411d72187b10b52a8a5a81462b2e3055c1cfa970188c42"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chojs23/concord/releases/download/v1.4.1/concord-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3e08e9979644adc62412224eb907d3e3c7d1e6c3284e5b5b03c191e5e555627a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chojs23/concord/releases/download/v1.4.1/concord-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5209b05d2f30e0330a29e5e6ecec3db2fd70e04c15d37fd855542469c5f1e128"
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
