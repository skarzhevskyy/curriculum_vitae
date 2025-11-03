# LaTeX CV Project Documentation

A professional CV/resume built with LaTeX using the [moderncv](https://ctan.org/pkg/moderncv) template.

> **🚀 Want to get started quickly?** See [README-TLDR.md](README-TLDR.md) for a quick start guide!
>
> **👤 Personal CV:** See [README.md](README.md) for the main CV page.

## Overview

This project contains a modern, customizable CV template designed for software developers. The template uses the `moderncv` document class with the banking style, providing a clean and professional appearance.

## Project Structure

```
curriculum_vitae/
├── src/
│   ├── resume.tex          # Main LaTeX CV source file
│   └── resume.pdf          # Compiled CV (after building)
├── assets/
│   └── cv-preview.png      # CV preview image for README
├── build/                  # Intermediate build files (git-ignored)
├── docs/
│   └── building.md         # Detailed build instructions
├── scripts/
│   ├── initial-setup.sh    # Automated installation script
│   └── watch.sh            # Watch mode for live recompilation
├── Makefile                # Build automation
├── README.md               # Personal CV page
├── README-PROJECT.md       # This file (comprehensive guide)
└── README-TLDR.md          # Quick start guide
```

## Quick Start

### 1. Install LaTeX

Run the automated setup script to install all necessary LaTeX packages:

```bash
chmod +x ./scripts/initial-setup.sh
./scripts/initial-setup.sh
```

The script will automatically detect your operating system (Fedora, Ubuntu/Debian, or macOS) and install the appropriate LaTeX distribution.

### 2. Edit Your CV

Customize the CV by editing `src/resume.tex`:

```bash
# Use your favorite text editor
vim src/resume.tex
# or
code src/resume.tex
```

### 3. Build Your CV

**Option A: Using Make** (recommended, cleanest)

```bash
make          # Build the CV
make watch    # Watch mode for live updates
make clean    # Clean build directory
```

**Option B: Using the watch script** (best for editing)

```bash
./scripts/watch.sh
```

**Option C: Manual build with latexmk**

```bash
cd src
latexmk -pdf -output-directory=../build resume.tex
cp ../build/resume.pdf .
```

**Option D: Quick build with pdflatex**

```bash
cd src
pdflatex -output-directory=../build resume.tex
pdflatex -output-directory=../build resume.tex  # Run twice
cp ../build/resume.pdf .
```

Your compiled CV will be available as `src/resume.pdf`. All intermediate build files (`.aux`, `.log`, etc.) are stored in the `build/` directory, keeping your source directory clean.

## Detailed Documentation

For comprehensive build instructions, troubleshooting, and customization tips, see:

📖 **[Building Instructions](docs/building.md)**

## Features

- **Modern Design**: Clean, professional layout using moderncv casual style
- **Easy Customization**: Well-structured LaTeX code with clear sections
- **Multiple Styles**: Support for different moderncv styles (casual, classic, banking, fancy)
- **Color Themes**: Built-in color schemes (blue, orange, green, red, purple, grey, black)
- **Icons**: Social media and contact icons using fontawesome
- **Cross-platform**: Works on Linux, macOS, and Windows

## Customization

### Changing the Style

Edit the style line in `src/resume.tex`:

```latex
\moderncvstyle{casual}  % Options: casual, classic, banking, oldstyle, fancy
```

### Changing the Color

Edit the color line in `src/resume.tex`:

```latex
\moderncvcolor{blue}  % Options: blue, orange, green, red, purple, grey, black
```

### Adding Your Information

Update the personal data section in `src/resume.tex`:

```latex
\name{Your}{Name}
\title{Your Title}
\address{Street}{City}{Country}
\email{your.email@example.com}
\social[linkedin]{yourlinkedin}
\social[github]{yourgithub}
```

## Requirements

- **LaTeX Distribution**: TeX Live (recommended) or MiKTeX
- **Required Packages**:
  - moderncv
  - fontawesome
  - fontawesome5
  - geometry
  - inputenc
  - latexmk (for continuous compilation)

All requirements are automatically installed by the `initial-setup.sh` script.

## Development Tools

### Recommended LaTeX Editors

- **TeXstudio** - Feature-rich LaTeX editor (cross-platform)
- **VS Code** - With LaTeX Workshop extension
- **Overleaf** - Online LaTeX editor (no installation required)
- **Vim/Neovim** - With vimtex plugin

### Continuous Compilation

For automatic recompilation on file changes, use the provided watch script:

```bash
./scripts/watch.sh
```

This script uses latexmk in watch mode to automatically detect changes and recompile your CV whenever you save the file. It provides:
- Automatic recompilation on save
- Build status feedback
- Smart error handling
- Easy stop with `Ctrl+C`

Alternatively, you can use latexmk directly:

```bash
cd src
latexmk -pdf -pvc resume.tex
```

## License

This template is based on the moderncv package, which is distributed under the LaTeX Project Public License (LPPL) version 1.3c.

## Resources

- [moderncv CTAN Page](https://ctan.org/pkg/moderncv)
- [moderncv Examples](https://www.latextemplates.com/cat/curricula-vitae)
- [LaTeX Documentation](https://www.latex-project.org/help/documentation/)
- [TeX Stack Exchange](https://tex.stackexchange.com/) - Q&A for LaTeX

## Support

For detailed build instructions, troubleshooting, and FAQs, please refer to [docs/building.md](docs/building.md).

## Contributing

Feel free to customize this template to your needs. If you encounter any issues or have suggestions for improvements, please open an issue or submit a pull request.
