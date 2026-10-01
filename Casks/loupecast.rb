cask "loupecast" do
  version :latest
  sha256 :no_check

  url "https://github.com/dunzkoi/loupecast/releases/latest/download/Loupecast.zip"
  name "Loupecast"
  desc "Screen recorder with automatic click zoom and cut editing"
  homepage "https://github.com/dunzkoi/loupecast"

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
