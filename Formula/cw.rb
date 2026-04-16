class Cw < Formula
  desc "Claude Worktree — git worktree + claude -w 통합 CLI"
  homepage "https://github.com/dunzkoi/cw"
  url "https://github.com/dunzkoi/cw/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "12b6764fc560ba93a29790888b6a0a2e56ebc67f85334731876647a0e9c6d77d"
  license "MIT"
  head "https://github.com/dunzkoi/cw.git", branch: "main"

  # 의존성 안 걸어둠 — cw는 bash 3.2 호환 스크립트, 시스템 git/bash로 동작
  # 환경에 git이 없는 경우에만 사용자가 직접 설치

  def install
    bin.install "cw"
  end

  test do
    assert_match "cw — Claude Worktree", shell_output("#{bin}/cw help")
  end
end
