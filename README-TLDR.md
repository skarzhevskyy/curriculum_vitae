# LaTeX CV - TL;DR

Get your CV running in 3 steps.

## Quick Start

### 1. Install
```bash
./scripts/initial-setup.sh
```

### 2. Edit
```bash
vim src/resume.tex  # or use your preferred editor
```

### 3. Build
```bash
make              # one-time build
./scripts/watch.sh  # or watch mode (auto-rebuild on save)
```

Output: `src/resume.pdf`

## Commands

```bash
make          # Build
make watch    # Auto-rebuild on save
make clean    # Remove build files
```

## Troubleshooting

- **Missing packages:** Run `./scripts/initial-setup.sh` again
- **Changes not showing:** `make clean && make`

---

📖 Full docs: [README-PROJECT.md](README-PROJECT.md) | [docs/building.md](docs/building.md)

