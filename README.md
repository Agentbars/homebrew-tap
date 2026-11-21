# Agentbars Homebrew tap

```bash
brew trust --cask agentbars/tap/rasklad && brew install --cask agentbars/tap/rasklad
```

Homebrew 7+ loads casks from third-party taps only after `brew trust`.

| Cask | App |
| --- | --- |
| `rasklad` | [Rasklad](https://github.com/Agentbars/rasklad): macOS menu bar app, double-tap Shift to fix text typed in the wrong keyboard layout |

Update: `brew upgrade --cask rasklad`. Remove: `brew uninstall --cask rasklad`.

## Updates

`Update Rasklad cask` (GitHub Actions) checks the latest [Rasklad release](https://github.com/Agentbars/rasklad/releases) every 3 hours and bumps `version` and `sha256` in `Casks/rasklad.rb`. To update right away: Actions → Update Rasklad cask → Run workflow. Locally: `./scripts/update-rasklad.sh [version]`.
