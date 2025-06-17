#!/usr/bin/env Rscript
# setup.R
# ────────────────────────────────────────────────────────
# Bootstrap R (renv) + build Python env—Option 1 (no activation here)
#
# Usage:
#   Rscript setup.R [--with-nlp]
# ────────────────────────────────────────────────────────

# 0. Flags
args     <- commandArgs(trailingOnly = TRUE)
with_nlp <- "--with-nlp" %in% args

# 1. R: renv init or restore
if (!requireNamespace("renv", quietly = TRUE)) install.packages("renv")
library(renv)

lockfile <- "renv.lock"
if (file.exists(lockfile)) {
  cat("📦 Restoring R environment...\n")
  renv::restore(prompt = FALSE)
} else {
  cat("🌀 Initializing renv (bare)...\n")
  renv::init(bare = TRUE)
  if (!interactive() || !requireNamespace("rstudioapi", quietly = TRUE)) {
    renv::snapshot(prompt = FALSE)
  } else {
    rstudioapi::restartSession()
    quit(status = 0)
  }
}
cat("✅ Renv ready.\n\n")

# 1.5 Ensure core Quarto R packages
core_pkgs <- c("yaml", "knitr", "rmarkdown")
cat("📦 Ensuring core Quarto R packages...\n")
to_install <- setdiff(core_pkgs, rownames(installed.packages()))
if (length(to_install)) {
  renv::install(to_install)
  renv::snapshot(prompt = FALSE)
}
cat("✅ Core Quarto R packages installed.\n\n")

# 1.6 Auto-detect & install R dependencies
cat("🔍 Scanning for R dependencies...\n")
deps <- renv::dependencies(path = ".", dev = FALSE)
detected <- unique(na.omit(deps$Package))
to_install <- setdiff(detected, rownames(installed.packages()))
if (length(to_install)) {
  cat("📦 Installing detected R packages: ", paste(to_install, collapse = ", "), "\n")
  renv::install(to_install)
  renv::snapshot(prompt = FALSE)
}
cat("✅ R dependencies satisfied.\n\n")

# 2. Python: build Conda env (no activation)
cat("🐍 Building Conda environment...\n")
source(file.path("scripts", "setup_conda_env.R"))
cat("✅ Conda env 'quarto-env' created and populated.\n\n")

# # 3. Optional NLP helpers
# if (with_nlp) {
#   cat("💬 Installing NLP helpers...\n")
#   source(file.path("scripts", "nlp_helpers.R"))
#   install_and_configure_py()
#   cat("✅ NLP helpers done.\n\n")
# } else {
#   cat("⚠️ NLP helpers skipped (re-run with `--with-nlp`).\n\n")
# }

cat("🚀 Bootstrap done! Use `quarto render demo.qmd --execute`.\n")
