# homebrew-tap

## 목적

dunzkoi 계정의 개인 Homebrew tap이다. `brew tap dunzkoi/tap`으로 설치한다.

## 구조

- `Formula/cw.rb`: cw 셸 CLI formula (소스: github.com/dunzkoi/cw)
- `Casks/loupecast.rb`: Loupecast macOS 앱 cask (소스: github.com/dunzkoi/loupecast)
- `.github/workflows/bump-loupecast.yml`: loupecast cask 자동 버전 올림 워크플로

## 버전 올림 경로

두 패키지는 갱신 경로가 다르다. 이 저장소에서 손으로 버전을 올리는 일은 거의 없다.

- cw: `~/toy/cw/release.sh vX.Y.Z`가 태그·릴리스를 만든 뒤 `CW_TAP_PATH` 경로의 `Formula/cw.rb`에서 url과 sha256을 고치고 커밋·push한다.
  - 기본 경로는 `../homebrew-tap`이지만 실제 tap은 `~/orca/projects/homebrew-tap`에 있으므로 `CW_TAP_PATH=~/orca/projects/homebrew-tap`을 지정해 실행한다.
  - release.sh는 pull 없이 push한다. 워크플로가 main에 먼저 커밋했을 수 있으니, 실행 전에 tap에서 `git pull --rebase`를 한다.
- loupecast: GitHub Releases에 올라간 `SHA256SUMS.txt`를 기준으로 갱신한다.
  - `bump-loupecast` 워크플로가 매일 03:17 UTC(수동 실행도 가능)에 최신 태그를 읽고, `Loupecast-<tag>.zip` 해시로 cask의 `version`·`sha256` 두 줄을 바꿔 `chore: bump loupecast to <tag>`로 main에 push한다.
  - 손으로 올릴 때도 같은 두 줄만 바꾼다. url은 `#{version}`으로 따라간다.

## 검증 명령

```bash
brew style dunzkoi/tap
brew audit --strict --tap dunzkoi/tap
brew test dunzkoi/tap/cw
```

- 위 명령은 설치된 tap(`$(brew --repository dunzkoi/tap)`)을 검사한다. 커밋 전 작업 사본을 검사하려면 임시 tap을 심링크로 걸어 같은 명령을 돌리고 끝나면 지운다.
  - `mkdir "$(brew --repository)/Library/Taps/fsdcheck" && ln -s "$PWD" "$(brew --repository)/Library/Taps/fsdcheck/homebrew-tap"`
  - 정리: `rm -r "$(brew --repository)/Library/Taps/fsdcheck"`
- cask 체크섬까지 보려면 `brew audit --strict --online --cask dunzkoi/tap/loupecast`, 버전 감지는 `brew livecheck dunzkoi/tap/loupecast`.
- 워크플로를 고치면 `actionlint .github/workflows/*.yml`.

## 불변 조건

- cw formula에 `git`·`bash` 의존성(`depends_on`)을 걸지 않는다. cw는 bash 3.2 호환 스크립트라 시스템 git·bash로 충분하고, brew가 자체 복사본을 설치하지 않게 하려고 뺐다(커밋 af428b1).
- loupecast는 공증(notarization)되지 않았으므로 caveats의 quarantine 해제 안내(`xattr -dr com.apple.quarantine`)를 유지한다.
- loupecast cask는 버전 고정 url과 sha256을 쓴다. `version :latest`·`sha256 :no_check`로 되돌리지 않는다. 앱이 자체 업데이터로 번들을 교체하므로 `auto_updates true`도 유지한다.
