class Concord < Formula
  desc "A terminal user interface client for Discord"
  homepage "https://github.com/chojs23/concord"
  version "1.3.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chojs23/concord/releases/download/v1.3.3/concord-aarch64-apple-darwin.tar.xz"
      sha256 "58906db132e87aca68322bd0c86cb51f8df89ef65b601d01b948fabff4bd9923"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chojs23/concord/releases/download/v1.3.3/concord-x86_64-apple-darwin.tar.xz"
      sha256 "2d22b671cd92a29219264fd5b9626ae9fdb28e784d1265a8c3b051053a0ecb06"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chojs23/concord/releases/download/v1.3.3/concord-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "19d3edc2450848cb26bc9d23bb387aa18bc48f5e30a86dbba9ea354616f6f365"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chojs23/concord/releases/download/v1.3.3/concord-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "10361f09d2c16534a9ec7bd97f1a67e0700c90780c6ac76060d3463236555b02"
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
