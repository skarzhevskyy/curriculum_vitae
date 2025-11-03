#!/bin/bash

################################################################################
# LaTeX CV Watch Script
# 
# This script automatically watches for changes to your CV and recompiles it
# using latexmk in preview continuous mode.
#
# Usage: ./watch.sh
################################################################################

set -e  # Exit on error

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the project root directory (parent of scripts directory)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"
SRC_DIR="$PROJECT_ROOT/src"
BUILD_DIR="$PROJECT_ROOT/build"

# Print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check if latexmk is installed
if ! command -v latexmk &> /dev/null; then
    echo "Error: latexmk is not installed."
    echo ""
    echo "Please run the installation script first:"
    echo "  cd scripts"
    echo "  ./initial-setup.sh"
    exit 1
fi

# Check if source directory exists
if [ ! -d "$SRC_DIR" ]; then
    echo "Error: Source directory not found: $SRC_DIR"
    exit 1
fi

# Check if resume.tex exists
if [ ! -f "$SRC_DIR/resume.tex" ]; then
    echo "Error: resume.tex not found in $SRC_DIR"
    exit 1
fi

# Create build directory if it doesn't exist
mkdir -p "$BUILD_DIR"

# Print header
echo "=========================================="
echo "  LaTeX CV Watch Mode"
echo "=========================================="
echo ""
print_info "Watching: $SRC_DIR/resume.tex"
print_info "Build directory: $BUILD_DIR"
print_info "Output: $SRC_DIR/resume.pdf"
echo ""
print_success "Watch mode started!"
echo ""
echo "The CV will automatically recompile when you save changes."
echo "Intermediate files will be stored in the build/ directory."
echo "Press Ctrl+C to stop watching."
echo ""
echo "------------------------------------------"

# Change to source directory and start watching
cd "$SRC_DIR"

# Run latexmk in preview continuous mode with build directory
# -pdf: Generate PDF output
# -pvc: Preview continuous mode (watch for changes)
# -interaction=nonstopmode: Don't stop for errors
# -output-directory: Store intermediate files in build directory
# -auxdir: Store auxiliary files in build directory
latexmk -pdf -pvc -interaction=nonstopmode \
    -output-directory="$BUILD_DIR" \
    -auxdir="$BUILD_DIR" \
    resume.tex

# Copy PDF to source directory for easy access
if [ -f "$BUILD_DIR/resume.pdf" ]; then
    cp "$BUILD_DIR/resume.pdf" "$SRC_DIR/resume.pdf"
fi

# This will only execute if the user stops latexmk (Ctrl+C)
echo ""
print_info "Watch mode stopped."

