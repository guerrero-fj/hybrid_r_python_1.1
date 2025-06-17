#!/usr/bin/env Rscript
# scripts/nlp_helpers.R
# —————————————————————————————————————————
# Utility functions to install & configure NLP helpers in 'quarto-env'

# Ensure reticulate is available
if (!requireNamespace("reticulate", quietly = TRUE)) install.packages("reticulate")
library(reticulate)

# Name of the Conda env
env_name <- "quarto-env"

# Helper: idempotently install Python packages in the env
ensure_python_package <- function(pkgs, env = env_name, pip = TRUE) {
  installed_py <- tryCatch(conda_list_packages(envname = env)$package,
                           error = function(e) character())
  for (pkg in pkgs) {
    if (!(pkg %in% installed_py)) {
      message("📦 Installing Python package '", pkg, "'…")
      conda_install(envname = env, packages = pkg, pip = pip)
    } else {
      message("✅ Python package '", pkg, "' already installed.")
    }
  }
}

# Install & configure NLTK (with punkt tokenizer)
install_and_configure_nltk <- function(env = env_name) {
  message("📚 Installing and configuring NLTK…")
  ensure_python_package("nltk", env = env)
  use_condaenv(env, required = TRUE)
  py_run_string("import nltk; nltk.download('punkt')")
  message("✅ NLTK installed and 'punkt' tokenizer downloaded.")
}

# Install & configure spaCy (with English model)
install_and_configure_spacy <- function(env = env_name) {
  message("🧠 Installing and configuring spaCy…")
  ensure_python_package("spacy", env = env)
  use_condaenv(env, required = TRUE)
  py_run_string("import spacy; spacy.cli.download('en_core_web_sm')")
  message("✅ spaCy installed and 'en_core_web_sm' model downloaded.")
}

# Convenience wrapper to install both
install_and_configure_py <- function(env = env_name) {
  install_and_configure_nltk(env)
  install_and_configure_spacy(env)
  message("🎉 NLP helper setup complete.")
}
