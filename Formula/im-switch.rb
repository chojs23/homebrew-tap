class ImSwitch < Formula
  desc "CLI to switch keyboard input methods for the im-switch.nvim plugin"
  homepage "https://github.com/chojs23/im-switch.nvim"
  url "https://github.com/chojs23/im-switch.nvim/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "19db1af15ceecfad3af3a6058dad75da7a04f69dc07d64fa60d3d9e560e59dc0"
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
