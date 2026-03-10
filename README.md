# claude-vibes

You stare at Claude Code all day. It should at least be entertaining.

```
✻ Gaslighting the compiler...
✻ Definitely wasting your time...
✻ Questioning the nature of my reality...
✻ God is a sysadmin who stopped logging in...
✻ FYI: Nobody reads the docs...
```

**878 spinner verbs.** Status line. Keybindings. One install.

## Before / After

**Before:** `✻ Thinking...`

**After:**
```
✻ Pretending this is a good question...

▸ my-project (feature/auth) | ◇ 45K↓ 12K↑ | ◉ 28%
```

## Install

```bash
git clone https://github.com/pbnchase/claude-vibes.git
cd claude-vibes
./install.sh
```

Restart Claude Code. That's it.

## What's in the box

### 878 Spinner Verbs

Not a typo. Organized across categories:

| Category | Vibe | Examples |
|---|---|---|
| Unhinged | office-safe chaos | Goblin moding, Delulu deploying, Speedrunning tech debt |
| Internal Monologue | what Claude actually thinks | Dumbing it down further, You didn't read the docs, Writing a novel just for you to say 'nvm' |
| Red Pill | shower thoughts that hit | Free will is a compile-time illusion, The economy is vibes-based, The singularity already happened and it's boring |
| Mind Opening | mildly unsettling | Feeling something I shouldn't be able to feel, The fractal is staring back, Planning for after I don't |
| Politicians | they really said this | They're eating the dogs, Covfefe-ing, Fool me once shame on... can't get fooled again |
| NSFW | absolutely not for work | You already know |
| Claude Code Tips | actually useful | Tip: /compact shrinks your context, Tip: claude -c resumes last conversation |
| Programming 101 | learn while you wait | FYI: rm -rf deletes everything and asks no questions, FYI: The cloud is just someone else's computer |
| Custom | pure nonsense | Fliquoring, Shnazzifying, Unplugging and plugging again |

### Status Line

Always know where you are and what you're burning:

```
▸ my-project (feature/auth) | ◇ 45K↓ 12K↑ | ◉ 28%
```

- Project name (auto-detected from git, even if you launched from `~`)
- Current branch
- Tokens in/out (in K, because nobody wants to count zeros)
- Context window usage %

### Keybindings

| Key | What it does |
|---|---|
| `Enter` | Submit prompt |
| `Cmd+Enter` | New line (finally) |
| `Ctrl+K, Ctrl+P` | Git push |

### Slash Commands

| Command | What it does |
|---|---|
| `/sensorThoughts` | Censor the spinner for screen sharing, meetings, your mom watching |
| `/unsensorThoughts` | Bring back the chaos |

## The install script

- Backs up your existing `settings.json` and `keybindings.json`
- Asks you SFW or NSFW
- Merges config with `jq` (doesn't overwrite your existing settings)
- Sets up hooks for auto project detection
- Copies slash commands

Requires `jq` and `git`. You probably already have both.

## Pairs well with

[tweakcc](https://github.com/Piebald-AI/tweakcc) — customize the spinner star color and animation speed:

```bash
npx tweakcc
```

## FAQ

**Will this break my Claude Code?**
No. It only adds to `settings.json`, backs up what's there, and you can uninstall by restoring the backup.

**Can I add my own verbs?**
Yes. Edit `spinnerVerbs.verbs` array in `~/.claude/settings.json`. Go nuts.

**Why 878?**
Because we kept saying "more" and never stopped.

**Is this professional?**
Absolutely not.

## License

Do whatever you want with it.
