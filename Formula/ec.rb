class Ec < Formula
  desc "TUI native Git mergetool with 3 pane"
  homepage "https://github.com/chojs23/ec"
  url "https://github.com/chojs23/ec/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "bfd7017c09b395df73850b72d7b27f026fb6001b2ac165097f7c3d7cebf23534"
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
