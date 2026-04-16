class Cw < Formula
  desc "Claude Worktree — git worktree + claude -w 통합 CLI"
  homepage "https://github.com/dunzkoi/cw"
  url "https://github.com/dunzkoi/cw/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "418b8a6f2843c45831f99343a87d8e8edd669515c00f74233b258d1748b620d4"
  license "MIT"
  head "https://github.com/dunzkoi/cw.git", branch: "main"

  depends_on "git"
  depends_on "bash"

  def install
    bin.install "cw"
  end

  test do
    assert_match "cw — Claude Worktree", shell_output("#{bin}/cw help")
  end
end
