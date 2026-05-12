class Concord < Formula
  desc "A terminal user interface client for Discord"
  homepage "https://github.com/chojs23/concord"
  version "1.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chojs23/concord/releases/download/v1.3.2/concord-aarch64-apple-darwin.tar.xz"
      sha256 "a5b0290c215dda83473930ab91f28153b111e4ba153380d36384afec10192783"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chojs23/concord/releases/download/v1.3.2/concord-x86_64-apple-darwin.tar.xz"
      sha256 "d1cf685d0cccd9f8df01d76ec18d439997917c71d710bb7b54cc1bf9c82009eb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chojs23/concord/releases/download/v1.3.2/concord-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7ff63d161273f2303b6374e00fa35cd6f5f8dad1b3977239dd0e6e5aabfa98f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chojs23/concord/releases/download/v1.3.2/concord-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "369f3313096abe78703ef7033b07a8f10c2dfca4d12d010390e6bc80c6b2b194"
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
