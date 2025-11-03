# Makefile for LaTeX CV
#
# Usage:
#   make          # Build the CV
#   make watch    # Watch for changes and rebuild
#   make clean    # Remove build directory
#   make cleanall # Remove build directory and PDF

# Directories
SRC_DIR = src
BUILD_DIR = build
ASSETS_DIR = assets

# Files
MAIN_TEX = resume.tex
MAIN_PDF = resume.pdf
PREVIEW_IMG = cv-preview.png

# Commands
LATEXMK = latexmk
LATEXMK_FLAGS = -pdf -interaction=nonstopmode -halt-on-error

.PHONY: all watch clean cleanall preview help

# Default target: build the CV
all: $(SRC_DIR)/$(MAIN_PDF)

# Generate preview image for README
preview: $(SRC_DIR)/$(MAIN_PDF)
	@if command -v pdftoppm >/dev/null 2>&1; then \
		echo "Generating preview image..."; \
		mkdir -p $(ASSETS_DIR); \
		pdftoppm $(SRC_DIR)/$(MAIN_PDF) $(ASSETS_DIR)/$(basename $(PREVIEW_IMG)) -png -singlefile -scale-to 800 >/dev/null 2>&1; \
		if [ -f $(ASSETS_DIR)/$(PREVIEW_IMG) ]; then \
			echo "✓ Preview image created: $(ASSETS_DIR)/$(PREVIEW_IMG)"; \
		fi \
	fi

# Build the CV
$(SRC_DIR)/$(MAIN_PDF): $(SRC_DIR)/$(MAIN_TEX)
	@echo "Building CV..."
	@mkdir -p $(BUILD_DIR)
	@cd $(SRC_DIR) && $(LATEXMK) $(LATEXMK_FLAGS) \
		-output-directory=../$(BUILD_DIR) \
		-auxdir=../$(BUILD_DIR) \
		$(MAIN_TEX)
	@cp $(BUILD_DIR)/$(MAIN_PDF) $(SRC_DIR)/$(MAIN_PDF)
	@echo "✓ CV built successfully: $(SRC_DIR)/$(MAIN_PDF)"
	@$(MAKE) preview --no-print-directory

# Watch for changes and rebuild automatically
watch:
	@echo "Starting watch mode..."
	@./scripts/watch.sh

# Clean build directory (keep PDF)
clean:
	@echo "Cleaning build directory..."
	@rm -rf $(BUILD_DIR)
	@echo "✓ Build directory cleaned"

# Clean everything including PDF
cleanall: clean
	@echo "Removing PDF..."
	@rm -f $(SRC_DIR)/$(MAIN_PDF)
	@echo "✓ All generated files removed"

# Show help
help:
	@echo "LaTeX CV Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  make          - Build the CV (default)"
	@echo "  make watch    - Watch for changes and rebuild automatically"
	@echo "  make preview  - Generate preview image for README"
	@echo "  make clean    - Remove build directory (keep PDF)"
	@echo "  make cleanall - Remove build directory and PDF"
	@echo "  make help     - Show this help message"
	@echo ""
	@echo "Output:"
	@echo "  PDF: $(SRC_DIR)/$(MAIN_PDF)"
	@echo "  Preview: $(ASSETS_DIR)/$(PREVIEW_IMG)"
	@echo "  Build files: $(BUILD_DIR)/"

