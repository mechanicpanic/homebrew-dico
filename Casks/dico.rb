cask "dico" do
  version "1.0.2"
  sha256 "2d670a2380fe3cd9667dae9158209d44eeb25b6f516da11ed16e2c4877ca9ad9"

  url "https://github.com/mechanicpanic/dico/releases/download/v#{version}/Dico-#{version}.zip"
  name "Dico"
  desc "French dictionary popup for Russian and English speakers — offline, with flashcards"
  homepage "https://github.com/mechanicpanic/dico"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Dico.app"
  binary "#{appdir}/Dico.app/Contents/Resources/bin/dico"

  zap trash: [
    "~/.dico",
    "~/.dico_config.json",
    "~/Library/Preferences/fr.dico.popup.plist",
  ]

  caveats <<~EOS
    The app is signed ad-hoc: the first launch is blocked by Gatekeeper once.
    Either install with --no-quarantine, or open System Settings ▸ Privacy &
    Security and click « Open Anyway » after the first double-click.
    Press ⌥D anywhere to open the panel.
  EOS
end
