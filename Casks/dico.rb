cask "dico" do
  version "1.0.6"
  sha256 "df41b51f955b006c85a90d178c4f15dab14123cdec913875ad7df48970681246"

  url "https://github.com/mechanicpanic/dico/releases/download/v#{version}/Dico-#{version}.zip"
  name "Dico"
  desc "French dictionary popup for Russian and English speakers, with flashcards"
  homepage "https://github.com/mechanicpanic/dico"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Dico.app"
  binary "#{appdir}/Dico.app/Contents/Resources/bin/dico"

  # Signed ad-hoc (no Developer ID): clear the quarantine flag Homebrew set on
  # the download, so the first launch is not blocked by Gatekeeper.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Dico.app"]
  end

  zap trash: [
    "~/.dico",
    "~/.dico_config.json",
    "~/Library/Preferences/fr.dico.popup.plist",
  ]

  caveats <<~EOS
    Press ⌥D anywhere to open the panel.
  EOS
end
