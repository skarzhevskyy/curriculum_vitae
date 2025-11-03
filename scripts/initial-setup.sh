#!/bin/bash

################################################################################
# LaTeX CV Environment Setup Script
# 
# This script automatically detects your operating system and installs
# the necessary LaTeX packages to build your CV using the moderncv template.
#
# Supported platforms:
#   - Fedora / Red Hat / CentOS (DNF/YUM)
#   - Ubuntu / Debian (APT)
#   - macOS (Homebrew)
#
# Usage: ./initial-setup.sh
################################################################################

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect operating system
detect_os() {
    print_info "Detecting operating system..."
    
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/fedora-release ]; then
            OS="fedora"
            print_info "Detected: Fedora/RHEL-based system"
        elif [ -f /etc/redhat-release ]; then
            OS="rhel"
            print_info "Detected: Red Hat/CentOS-based system"
        elif [ -f /etc/debian_version ]; then
            OS="debian"
            print_info "Detected: Debian/Ubuntu-based system"
        else
            OS="unknown-linux"
            print_warning "Unknown Linux distribution"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        print_info "Detected: macOS"
    else
        OS="unknown"
        print_error "Unsupported operating system: $OSTYPE"
        exit 1
    fi
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install on Fedora/RHEL
install_fedora() {
    print_info "Installing LaTeX packages using DNF..."
    
    if ! command_exists dnf; then
        print_error "DNF package manager not found"
        exit 1
    fi
    
    print_info "This will install TeX Live packages. You may be prompted for your password."
    
    # Ask user preference for installation size
    echo ""
    echo "Choose installation option:"
    echo "  1) Full installation (recommended, ~4GB) - includes all packages"
    echo "  2) Minimal installation (~500MB) - only required packages"
    read -p "Enter choice [1-2]: " choice
    
    case $choice in
        1)
            print_info "Installing full TeX Live distribution..."
            sudo dnf install -y texlive-scheme-full
            ;;
        2|*)
            print_info "Installing minimal TeX Live packages..."
            sudo dnf install -y \
                texlive \
                texlive-moderncv \
                texlive-fontawesome \
                texlive-fontawesome5 \
                texlive-collection-fontsrecommended \
                texlive-collection-latexextra \
                latexmk
            ;;
    esac
    
    print_success "LaTeX packages installed successfully!"
}

# Install on Debian/Ubuntu
install_debian() {
    print_info "Installing LaTeX packages using APT..."
    
    if ! command_exists apt-get; then
        print_error "APT package manager not found"
        exit 1
    fi
    
    print_info "Updating package lists..."
    sudo apt-get update
    
    # Ask user preference for installation size
    echo ""
    echo "Choose installation option:"
    echo "  1) Full installation (recommended, ~5GB) - includes all packages"
    echo "  2) Minimal installation (~800MB) - only required packages"
    read -p "Enter choice [1-2]: " choice
    
    case $choice in
        1)
            print_info "Installing full TeX Live distribution..."
            sudo apt-get install -y texlive-full
            ;;
        2|*)
            print_info "Installing minimal TeX Live packages..."
            sudo apt-get install -y \
                texlive \
                texlive-latex-extra \
                texlive-fonts-recommended \
                texlive-fonts-extra \
                texlive-latex-recommended \
                latexmk
            ;;
    esac
    
    print_success "LaTeX packages installed successfully!"
}

# Install on macOS
install_macos() {
    print_info "Installing LaTeX packages on macOS..."
    
    # Check for Homebrew
    if ! command_exists brew; then
        print_error "Homebrew not found. Please install Homebrew first:"
        echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    fi
    
    # Ask user preference for installation size
    echo ""
    echo "Choose installation option:"
    echo "  1) Full installation (MacTeX, recommended, ~4GB) - includes all packages"
    echo "  2) Minimal installation (BasicTeX, ~100MB) - requires additional package installation"
    read -p "Enter choice [1-2]: " choice
    
    case $choice in
        1)
            print_info "Installing MacTeX (this may take a while)..."
            brew install --cask mactex
            
            # Add TeX binaries to PATH for current session
            export PATH="/Library/TeX/texbin:$PATH"
            
            print_info "Please add the following line to your ~/.zshrc or ~/.bash_profile:"
            echo '  export PATH="/Library/TeX/texbin:$PATH"'
            ;;
        2|*)
            print_info "Installing BasicTeX..."
            brew install --cask basictex
            
            # Add TeX binaries to PATH for current session
            export PATH="/Library/TeX/texbin:$PATH"
            
            print_info "Updating TeX Live Manager..."
            sudo tlmgr update --self
            
            print_info "Installing required packages..."
            sudo tlmgr install \
                moderncv \
                fontawesome \
                fontawesome5 \
                collection-fontsrecommended \
                collection-latexextra \
                latexmk
            
            print_info "Please add the following line to your ~/.zshrc or ~/.bash_profile:"
            echo '  export PATH="/Library/TeX/texbin:$PATH"'
            ;;
    esac
    
    print_success "LaTeX packages installed successfully!"
}

# Verify installation
verify_installation() {
    print_info "Verifying installation..."
    
    if command_exists pdflatex; then
        PDFLATEX_VERSION=$(pdflatex --version | head -n 1)
        print_success "pdflatex found: $PDFLATEX_VERSION"
    else
        print_error "pdflatex not found. Installation may have failed."
        return 1
    fi
    
    # Try to find moderncv.cls
    if kpsewhich moderncv.cls >/dev/null 2>&1; then
        MODERNCV_PATH=$(kpsewhich moderncv.cls)
        print_success "moderncv package found: $MODERNCV_PATH"
    else
        print_warning "moderncv package not found. You may need to install it manually."
        return 1
    fi
    
    return 0
}

# Display next steps
show_next_steps() {
    echo ""
    echo "=========================================="
    print_success "Setup completed successfully!"
    echo "=========================================="
    echo ""
    echo "Next steps:"
    echo "  1. Edit your CV: src/resume.tex"
    echo "  2. Build your CV:"
    echo "       cd src"
    echo "       pdflatex resume.tex"
    echo "  3. View the output: src/resume.pdf"
    echo ""
    echo "For detailed build instructions, see: docs/building.md"
    echo ""
}

# Main installation flow
main() {
    echo "=========================================="
    echo "  LaTeX CV Environment Setup"
    echo "=========================================="
    echo ""
    
    # Detect OS
    detect_os
    
    # Check if LaTeX is already installed
    if command_exists pdflatex && kpsewhich moderncv.cls >/dev/null 2>&1; then
        print_warning "LaTeX and moderncv appear to be already installed."
        read -p "Do you want to continue anyway? [y/N]: " continue_install
        if [[ ! "$continue_install" =~ ^[Yy]$ ]]; then
            print_info "Installation cancelled."
            verify_installation
            show_next_steps
            exit 0
        fi
    fi
    
    # Install based on OS
    case $OS in
        fedora|rhel)
            install_fedora
            ;;
        debian)
            install_debian
            ;;
        macos)
            install_macos
            ;;
        unknown-linux)
            print_error "Unsupported Linux distribution."
            print_info "Please install TeX Live manually from: https://www.tug.org/texlive/"
            exit 1
            ;;
        *)
            print_error "Unsupported operating system."
            exit 1
            ;;
    esac
    
    # Verify installation
    echo ""
    if verify_installation; then
        show_next_steps
    else
        print_error "Installation verification failed."
        print_info "Please check the error messages above and refer to docs/building.md"
        exit 1
    fi
}

# Run main function
main

