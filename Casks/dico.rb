cask "dico" do
  version "1.0.3"
  sha256 "31418d327071d22f15333351a77b84baa0a7caedbd361e731c84b73918377f7b"

  url "https://github.com/mechanicpanic/dico/releases/download/v#{version}/Dico-#{version}.zip"
  name "Dico"
  desc "French dictionary popup for Russian and English speakers, with flashcards"
  homepage "https://github.com/mechanicpanic/dico"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "Dico.app"
  binary "#{appdir}/Dico.app/Contents/Resources/bin/dico"

  # Signed ad-hoc (no Developer ID): clear the quarantine flag Homebrew set on
  # the download, so the first launch is not blocked by Gatekeeper.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Dico.app"]
  end

  caveats <<~EOS
    Press ⌥D anywhere to open the panel.
  EOS

  zap trash: [
    "~/.dico",
    "~/.dico_config.json",
    "~/Library/Preferences/fr.dico.popup.plist",
  ]
end
