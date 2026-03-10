# claude-vibes

Make Claude Code actually fun to look at all day.

## What you get

- **Status line** showing project name, git branch, token count (K), and context %
- **Auto project detection** via hook — works even if you launch from `~`
- **Custom spinner verbs** — SFW or NSFW, your call
- **Keybindings** — Cmd+Enter for newline, Ctrl+K Ctrl+P for git push
- **`/sensorThoughts`** — instantly censor the spinner for screen sharing
- **`/unsensorThoughts`** — bring back the chaos

## Install

```bash
git clone https://github.com/pbnchase/claude-vibes.git
cd claude-vibes
./install.sh
```

Restart Claude Code after installing.

## Verb Packs

### SFW (work-safe but still funny)
> Gaslighting the compiler... Delulu deploying... Emotionally unavailable for bugs... Goblin moding...

### NSFW (you've been warned)
> Raw dogging this code... Edging the deployment... Balls deep in production... Shitting code...

Switch between them anytime:
- `/sensorThoughts` — go clean
- `/unsensorThoughts` — go feral

## Status Line

```
▸ my-project (feature/auth) | ◇ 45K↓ 12K↑ | ◉ 28%
```

- **▸** project name (auto-detected from git)
- **(branch)** current git branch
- **◇** tokens in/out in K
- **◉** context window usage %

## Keybindings

| Key | Action |
|---|---|
| Enter | Submit prompt |
| Cmd+Enter | New line |
| Ctrl+K, Ctrl+P | Git push |

## Requirements

- Claude Code
- `jq` (for the install script)
- `git` (for project detection in status line)

## Optional: tweakcc

For spinner color/animation customization, also check out [tweakcc](https://github.com/Piebald-AI/tweakcc):

```bash
npx tweakcc
```

## License

Do whatever you want with it.
