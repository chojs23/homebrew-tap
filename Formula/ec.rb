class Ec < Formula
  desc "TUI native Git mergetool with 3 pane"
  homepage "https://github.com/chojs23/ec"
  url "https://github.com/chojs23/ec/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "5b1f5d613c8f13c768c80f9d7e6e40a0e34a731a129faf9fc20b56c31439cb7b"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=v#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/ec"
  end

  test do
    (testpath/"merged.txt").write <<~EOS
      line1
      <<<<<<< HEAD
      ours
      =======
      theirs
      >>>>>>> branch
    EOS
    shell_output("#{bin}/ec --check --merged #{testpath}/merged.txt", 1)
  end
end
