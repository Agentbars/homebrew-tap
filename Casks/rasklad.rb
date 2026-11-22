cask "rasklad" do
  version "0.3.1"
  sha256 "31058ea0df0aa568309fe6166d6f8441149a39f3c7787f25f3c2cc5f80e8df73"

  url "https://github.com/Agentbars/rasklad/releases/download/v#{version}/Rasklad-v#{version}.zip"
  name "Rasklad"
  desc "Menu bar app that fixes text typed in the wrong keyboard layout"
  homepage "https://github.com/Agentbars/rasklad"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Rasklad.app"

  zap trash: "~/Library/Preferences/local.rasklad.plist"

  caveats <<~EOS
    Rasklad is not notarized by Apple yet. On first launch macOS blocks it:
    open it once, then go to System Settings → Privacy & Security → Open Anyway
    (or run: xattr -dr com.apple.quarantine #{appdir}/Rasklad.app).
    Then grant Accessibility and Input Monitoring and relaunch Rasklad.
    From version 0.3 Rasklad updates itself (menu → «Проверить обновления…»).
  EOS
end
