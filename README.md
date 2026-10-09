# Git Agent Commit

AI-assisted Conventional Commit message generator supporting multiple CLI agents (`agy`, `claude`, `mimo`, `qwen`) with Zsh and native Git integration.

## Features

- **Multi-Agent Support**: Choose your preferred agent (`agy`, `claude`, `mimo`, `qwen`).
- **Strict Conventional Commits**: Automatically detects intent and formats messages as `<type>(<scope>): <description>`.
- **Zsh Interactive Buffer**: Injects `git commit -m "..."` directly into your command-line buffer (`print -z`), allowing you to review and edit before committing.
- **Git Subcommand Integration**: Works directly via `git agycommit`, `git claudecommit`, etc.
- **High Performance Diffing**: Compact diffs (`-U1`) with noise filtering (excludes lockfiles, binaries, source maps, minified files, assets) and balanced per-file sampling.
- **Context-Aware**: Detects your current Git branch and accepts optional user hints to guide generation.

## Prerequisites

Ensure you have at least one of the supported AI CLIs installed and available in your `PATH`:

- `agy` (Google Antigravity CLI)
- `claude` (Anthropic Claude Code CLI)
- `mimo`
- `qwen`

## Installation

### Oh My Zsh

Clone into your Oh My Zsh custom plugins directory:

```bash
git clone https://github.com/prentece/git-agent-commit.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-agent-commit
```

Add `git-agent-commit` to your plugins in `~/.zshrc`:

```zsh
plugins=(
  # ... other plugins
  git-agent-commit
)
```

Reload your shell:

```zsh
source ~/.zshrc
```

### Zinit

Add the following to your `~/.zshrc`:

```zsh
zinit light prentece/git-agent-commit
```

### Antigen

Add the following to your `~/.zshrc`:

```zsh
antigen bundle prentece/git-agent-commit
```

### Standalone

Install via the automated script:

```bash
curl -fsSL https://raw.githubusercontent.com/prentece/git-agent-commit/main/install.sh | bash
```

Or clone and run locally:

```bash
git clone https://github.com/prentece/git-agent-commit.git ~/.git-agent-commit
~/.git-agent-commit/install.sh
```

## Usage

Stage your changes, then run your preferred agent command:

```bash
git add .
gagy
```

The AI analyzes the staged changes and populates your shell prompt:

```bash
git commit -m "feat(cli): add multi-agent commit tools"
```

Review the message, edit if desired, and press `Enter` to commit.

### Available Commands & Aliases

| Agent | Zsh Alias | Git Command |
|---|---|---|
| **Google Antigravity** | `gagy` | `git agycommit` |
| **Claude** | `gcl` | `git claudecommit` |
| **Mimo** | `gmimo` | `git mimocommit` |
| **Qwen** | `gqwen` | `git qwencommit` |

### Providing Hints

You can append extra instructions or context to steer the commit message:

```bash
gagy "focus on the timeout protection"
# or
git claudecommit "breaking change in auth flow"
```

## License

MIT
