#!/usr/bin/env Rscript
# scripts/setup_conda_env.R
# —————————————————————————————————————————
# Create & populate the `quarto-env` Conda environment—Option 1 (no activation)

if (!requireNamespace("reticulate", quietly = TRUE)) install.packages("reticulate")
library(reticulate)

env_name  <- "quarto-env"
base_pkgs <- c("pandas", "matplotlib", "wordcloud", "scikit-learn",
               "seaborn", "numpy", "scipy", "statsmodels",
               "jupyterlab", "ipykernel", "notebook")

# 1) Create env if missing
existing <- tryCatch(conda_list()$name, error = function(e) character())
if (!(env_name %in% existing)) {
  message("📦 Creating Conda env '", env_name, "'...")
  conda_create(envname = env_name,
               packages = base_pkgs,
               pip      = TRUE)
} else {
  message("✅ Conda env '", env_name, "' already exists.")
}

# 2) Idempotent install of missing packages
installed_py <- tryCatch(conda_list_packages(envname = env_name)$package,
                         error = function(e) character())
to_install <- setdiff(base_pkgs, installed_py)
if (length(to_install)) {
  message("📦 Installing Python packages: ", paste(to_install, collapse = ", "), "...")
  conda_install(envname = env_name, packages = to_install, pip = TRUE)
}
message("✅ Python packages in '", env_name, "' are up to date.")

# 3) Optional export
export_conda_env <- function(env = env_name, file = "environment.yml") {
  message("📝 Exporting Conda env to ", file, "...")
  conda_export(envname = env, filename = file)
  message("✅ Exported.")
}
