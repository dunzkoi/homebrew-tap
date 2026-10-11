cask "loupecast" do
  version "0.7.0"
  sha256 "5883d0fb06692f4ad0f17189ce20c1ba2bf79e5b5a6e4cfa638bef9809e0d5b8"

  url "https://github.com/dunzkoi/loupecast/releases/download/v#{version}/Loupecast-v#{version}.zip"
  name "Loupecast"
  desc "Screen recorder with automatic click zoom and cut editing"
  homepage "https://github.com/dunzkoi/loupecast"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "Loupecast.app"

  zap trash: [
    "~/Library/Application Support/Loupecast",
    "~/Library/Preferences/com.flowoodz.loupecast.plist",
  ]

  caveats <<~EOS
    Loupecast is not notarized yet. If macOS refuses to open it, run once:
      xattr -dr com.apple.quarantine "#{appdir}/Loupecast.app"
  EOS
end
