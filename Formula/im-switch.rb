class ImSwitch < Formula
  desc "CLI to switch keyboard input methods for the im-switch.nvim plugin"
  homepage "https://github.com/chojs23/im-switch.nvim"
  url "https://github.com/chojs23/im-switch.nvim/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "1b40a5a7d52205a0435fda3ccd29ed18310ddf34caf894a5041aa06aad5dfb4c"
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
