# Building Your CV

This document provides comprehensive instructions for building your LaTeX CV using the moderncv template.

## Prerequisites

You need a LaTeX distribution installed on your system. The recommended distribution is **TeX Live**, which includes all necessary packages including moderncv.

### Required Packages

- **TeX Live** (or equivalent LaTeX distribution)
- **moderncv** package (included in TeX Live)
- **fontawesome** package (for icons)
- **geometry** package (for page layout)

## Installation

### Quick Setup

We provide an automated installation script that detects your operating system and installs the necessary dependencies:

```bash
cd scripts
chmod +x initial-setup.sh
./initial-setup.sh
```

### Manual Installation

#### Fedora / Red Hat / CentOS

```bash
sudo dnf install texlive-scheme-full latexmk
# Or for a minimal installation:
sudo dnf install texlive texlive-moderncv texlive-fontawesome texlive-fontawesome5 texlive-collection-fontsrecommended latexmk
```

#### Ubuntu / Debian

```bash
sudo apt-get update
sudo apt-get install texlive-full latexmk
# Or for a minimal installation:
sudo apt-get install texlive texlive-latex-extra texlive-fonts-recommended latexmk
```

#### macOS

Using Homebrew:

```bash
brew install --cask mactex
# Or for a minimal installation:
brew install --cask basictex
sudo tlmgr update --self
sudo tlmgr install moderncv fontawesome fontawesome5 collection-fontsrecommended latexmk
```

Alternatively, download MacTeX from: https://www.tug.org/mactex/

#### Windows

1. Download and install MiKTeX from: https://miktex.org/download
2. Or download TeX Live from: https://www.tug.org/texlive/windows.html
3. MiKTeX will automatically install missing packages when you first compile

## Building the CV

All build methods store intermediate files in the `build/` directory, keeping your source directory clean. The final PDF is placed in `src/resume.pdf`.

### Using Make (Recommended)

The simplest way to build:

```bash
make
```

Other make targets:

```bash
make watch    # Start watch mode for live updates
make clean    # Remove build directory
make cleanall # Remove build directory and PDF
make help     # Show all available targets
```

### Command Line Build with latexmk

Build using latexmk with output directory:

```bash
cd src
latexmk -pdf -output-directory=../build resume.tex
cp ../build/resume.pdf .
```

### Command Line Build with pdflatex

For manual builds, run pdflatex twice to ensure all references are resolved:

```bash
cd src
pdflatex -output-directory=../build resume.tex
pdflatex -output-directory=../build resume.tex
cp ../build/resume.pdf .
```

The output PDF will be available as `src/resume.pdf`, while all intermediate files (`.aux`, `.log`, `.out`, etc.) are stored in the `build/` directory.

### Using the Makefile

A Makefile is provided for convenient building:

```bash
make          # Build the CV
make watch    # Watch for changes
make clean    # Clean build directory (keep PDF)
make cleanall # Clean everything including PDF
make help     # Show all available targets
```

The Makefile automatically:
- Creates the `build/` directory if it doesn't exist
- Compiles your CV with proper settings
- Stores intermediate files in `build/`
- Copies the final PDF to `src/`

### Using an IDE

#### TeXstudio (Cross-platform)

1. Install TeXstudio: https://www.texstudio.org/
2. Open `src/resume.tex`
3. Press F5 or click the green arrow to compile

#### Overleaf (Online)

1. Upload the `resume.tex` file to Overleaf: https://www.overleaf.com/
2. The document will compile automatically
3. Download the PDF when ready

## Output Location

After successful compilation, you will find:

- **src/resume.pdf** - Your compiled CV (final output)
- **build/** - All intermediate files (`.aux`, `.log`, `.out`, etc.)

The `build/` directory is git-ignored, keeping your repository clean.

## Troubleshooting

### Missing Package Errors

**Error**: `File 'moderncv.cls' not found`

**Solution**: Install the moderncv package:

```bash
# Fedora
sudo dnf install texlive-moderncv

# Ubuntu/Debian
sudo apt-get install texlive-latex-extra

# macOS (with BasicTeX)
sudo tlmgr install moderncv
```

### Font Issues

**Error**: `File 'fontawesome5.sty' not found` or font warnings

**Solution**: Install the fontawesome5 package (required by modern moderncv versions):

```bash
# Fedora
sudo dnf install texlive-fontawesome5

# Ubuntu/Debian
sudo apt-get install texlive-fonts-extra

# macOS
sudo tlmgr install fontawesome5
```

If you're still having issues, also install the older fontawesome package:

```bash
# Fedora
sudo dnf install texlive-fontawesome

# Ubuntu/Debian
sudo apt-get install texlive-fonts-recommended

# macOS
sudo tlmgr install fontawesome
```

### Unicode/Encoding Errors

**Error**: Unicode character errors

**Solution**: Ensure your file is saved with UTF-8 encoding. If using pdflatex fails, try using xelatex or lualatex:

```bash
xelatex resume.tex
# or
lualatex resume.tex
```

### Compilation Hangs

**Issue**: Compilation seems to hang or takes too long

**Solution**: 
1. Check for errors in your .tex file
2. Delete auxiliary files and try again:
   ```bash
   cd src
   rm -f *.aux *.log *.out
   pdflatex resume.tex
   ```

### Stale Auxiliary Files

**Issue**: Changes not reflected in output PDF

**Solution**: Clean build directory and recompile:

```bash
make clean
make
```

Or manually:

```bash
rm -rf build/
cd src
latexmk -pdf -output-directory=../build resume.tex
cp ../build/resume.pdf .
```

## Customization Tips

### Changing Colors

Edit the color option in `resume.tex`:

```latex
\moderncvcolor{blue}  % Options: blue, orange, green, red, purple, grey, black
```

### Changing Style

Edit the style option in `resume.tex`:

```latex
\moderncvstyle{casual}  % Options: casual, classic, banking, oldstyle, fancy
```

### Adjusting Margins

Modify the geometry package settings:

```latex
\usepackage[scale=0.75]{geometry}  % Increase scale for smaller margins
```

### Adding a Photo

Uncomment and update the photo line:

```latex
\photo[64pt][0.4pt]{picture}  % Add your photo file (picture.jpg) to src/
```

## Continuous Compilation

For development, you can use tools that automatically recompile on file changes:

### Using the Watch Script (Recommended)

The easiest way to enable watch mode:

```bash
./scripts/watch.sh
```

This convenient script:
- Automatically detects your project structure
- Verifies latexmk is installed
- Starts watch mode with proper settings
- Provides clear status messages
- Press `Ctrl+C` to stop

### Using latexmk directly

```bash
cd src
latexmk -pdf -pvc resume.tex
```

Options:
- `-pdf`: Generate PDF output
- `-pvc`: Preview continuous mode (watch for changes)
- `-interaction=nonstopmode`: Don't stop for errors

### Using entr (Linux/macOS)

Alternative file watcher if you prefer entr:

```bash
ls src/resume.tex | entr pdflatex src/resume.tex
```

## Version Control

When using git, the `.gitignore` file is configured to exclude build artifacts:

- `build/` - All intermediate build files
- LaTeX auxiliary files (if they end up in `src/`)

The final PDF (`src/resume.pdf`) is NOT ignored by default, so it will be tracked in git.

### Build Directory Structure

```
curriculum_vitae/
├── src/
│   ├── resume.tex      # Your source file (tracked)
│   └── resume.pdf      # Final output (tracked)
├── build/              # All intermediate files (git-ignored)
│   ├── resume.aux
│   ├── resume.log
│   ├── resume.out
│   ├── resume.fdb_latexmk
│   └── ... (other build artifacts)
└── .gitignore
```

This keeps your repository clean while maintaining the final PDF for easy access.

## Additional Resources

- [moderncv Documentation](https://ctan.org/pkg/moderncv)
- [LaTeX Wikibook](https://en.wikibooks.org/wiki/LaTeX)
- [TeX Stack Exchange](https://tex.stackexchange.com/) - For LaTeX questions
- [Overleaf Documentation](https://www.overleaf.com/learn)

## Getting Help

If you encounter issues not covered in this guide:

1. Check the LaTeX log file (`resume.log`) for detailed error messages
2. Search for the error message on [TeX Stack Exchange](https://tex.stackexchange.com/)
3. Verify all packages are installed: `tlmgr list --installed | grep moderncv`
4. Ensure your TeX distribution is up to date: `sudo tlmgr update --all`

