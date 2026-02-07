class ImSwitch < Formula
  desc "CLI to switch keyboard input methods for the im-switch.nvim plugin"
  homepage "https://github.com/chojs23/im-switch.nvim"
  url "https://github.com/chojs23/im-switch.nvim/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "730ae2b0fea5364dabec59c488fbe0ad325ae7845dc3b96e9bde46e679eb8c2e"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "1" if OS.mac?
    system "go", "build", *std_go_args(ldflags: "-s -w"), "."
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/im-switch -h")
  end
end
