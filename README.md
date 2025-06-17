# Quarto Hybrid R + Python Template

![R ≥ 4.0](https://img.shields.io/badge/R-4.0%2B-blue) ![Python ≥ 3.9](https://img.shields.io/badge/Python-3.9%2B-yellow) ![Quarto ≥ 1.0](https://img.shields.io/badge/Quarto-1.0%2B-brightgreen) ![License: MIT](https://img.shields.io/badge/License-MIT-green)

A reproducible Quarto project template that lets you weave R and Python seamlessly.  
It bootstraps an R library via **renv**, creates a shared Conda environment for Python, and even offers optional NLP setup (NLTK & spaCy).

---

## 🎯 Features

- 🐍 **Hybrid Execution**: run R chunks via `renv` and Python chunks via a Conda env  
- 🔄 **Reproducibility**: dependency management with `renv` and `conda`  
- 🧠 **NLP Helpers**: optional installation of NLTK & spaCy for text analysis  
- 🚀 **One-and-Done**: single `setup.R` script to bootstrap your entire project  
- 📄 **Demo**: a `demo.qmd` showing a ggplot2 chart and an NLTK wordcloud  

---

## 🚀 Template Usage

1. **Use as a GitHub Template**  
   - On GitHub, click **Use this template** → **Create a new repository**  
   - Name it whatever you like (e.g. `my-quarto-project`)

2. **Clone (or open) your new repo**  
   - **GitHub Desktop**: click **Clone**, then **Open in RStudio**  
   - **Terminal**:  
     ```bash
     git clone https://github.com/your-org/my-quarto-project.git
     cd my-quarto-project
     open my-quarto-project.Rproj   # macOS; or double-click in your file browser
     ```

3. **Bootstrap your project**  
   - **Within RStudio**  
     1. In the **Files** pane, open `setup.R`  
     2. Click **Source** (or press Cmd+Shift+Enter)  
 
   - **Or via CLI**  
     ```bash
     Rscript setup.R
     ```
   - This will:
     1. **Initialize or restore** your R library with `renv`  
     2. **Create/activate** a Conda env named `quarto-env` with core Python packages  

4. **Render the demo**  
   ```bash
   quarto render demo.qmd --execute
   ```
   You should see an HTML page with:  
   - A **ggplot2** scatterplot of `mtcars`  
   - A **wordcloud** generated with regex and wordcloud  

---

## 🛠️ Prerequisites

- **R** ≥ 4.0 (with write permissions to install packages)  
- **Python** ≥ 3.9 (optional, managed by Conda)  
- **Conda** (Miniconda or Anaconda) installed and on your `PATH`  
- **Quarto** CLI installed:  
  ```bash
  quarto --version
  ```

---

## 📂 Project Structure

```text
my-quarto-project/
├── .gitignore
├── environment.yml
├── _quarto.yml
├── demo.qmd
├── setup.R
├── quarto-template.Rproj   ← rename to your-project.Rproj
└── scripts/
    ├── setup_conda_env.R
    └── nlp_helpers.R
```

- **`setup.R`**: unified bootstrap for R (`renv`) + Python (Conda) 
- **`scripts/setup_conda_env.R`**: idempotent Conda env creation & activation  
- **`_quarto.yml`**: Quarto project config (theme, execution, env)  
- **`demo.qmd`**: minimal Quarto document with mixed R & Python examples  
- **`environment.yml`**: YAML spec of your Conda env (for sharing without `reticulate`)  

---

## ⚙️ Customization

1. **Rename the RStudio project**  
   - Rename `quarto-template.Rproj` → `my-project.Rproj`  
   - Open it in RStudio to set the project root automatically  

2. **Adjust your Python env name**  
   - If you prefer a different name, edit `env_name <- "quarto-env"` in both `setup.R` and `scripts/setup_conda_env.R`  

3. **Modify `_quarto.yml`**  
   - Change theme, output formats, or disable code-folding as desired  

4. **Add more dependencies**  
   - **R**: run `renv::install("pkg")` and then `renv::snapshot()`  
   - **Python**: run `source("scripts/setup_conda_env.R")` then `ensure_python_package("new_pkg")`  

5. **Regenerate `environment.yml`**  
   ```r
   source("scripts/setup_conda_env.R")
   export_conda_env("quarto-env", file = "environment.yml")
   ```

---

## 🤝 Contributing

Contributions, bug reports, and feature requests are welcome! Please:

1. Fork the repo  
2. Create a topic branch (`git checkout -b feature/xyz`)  
3. Commit your changes & open a PR  

---

## 📜 License

This template is licensed under the **MIT License**. See [LICENSE](LICENSE) for details.  
Feel free to use, modify, and share!
