class Concord < Formula
  desc "A terminal user interface client for Discord"
  homepage "https://github.com/chojs23/concord"
  version "2.6.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chojs23/concord/releases/download/v2.6.4/concord-aarch64-apple-darwin.tar.xz"
      sha256 "86594cbf3f02d6235ea30a566898ad09ebf3dabfcf6f161140b57236348137db"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chojs23/concord/releases/download/v2.6.4/concord-x86_64-apple-darwin.tar.xz"
      sha256 "bbb3aec585dbaa2c9975835036335e6ad8e34b055f18c29c40fbdbfc3a2efd51"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chojs23/concord/releases/download/v2.6.4/concord-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "777bc978ecc274b427f9eab66a005bca2adc085a853264a1dbd2ea1475576499"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chojs23/concord/releases/download/v2.6.4/concord-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "89563bf940de90b3673fa74100a5933d2ae6bef04575cbe093158091b6fff89a"
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
