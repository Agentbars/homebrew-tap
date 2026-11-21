cask "rasklad" do
  version "0.2.0"
  sha256 "8455f20d87b69e5edfc629197f48042aa6cbcac521e9e7ea5b5177bf5572454f"

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
    open it once, then go to System Settings → Privacy & Security → Open Anyway.
    Then grant Accessibility and Input Monitoring and relaunch Rasklad.
  EOS
end
