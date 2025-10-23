# uvshot

`uvshot` is a simple, fast script to set up and manage Python virtual environments 
using [`uv`](https://docs.astral.sh/uv/) in a isolated state. It’s ideal for teams who want a consistent, no-fuss environment setup in their projects.

**CAUTION: The shell scripts are only tested work in MacOS within zsh**

## 🚀 Installation & Usage

### 1️⃣ Download the scripts

Run the following commands from your project directory to download both setup and cleanup scripts:

```bash
curl -L https://raw.githubusercontent.com/shafayetShafee/uvshot/v1.0.1/setup.sh -o setup.sh
curl -L https://raw.githubusercontent.com/shafayetShafee/uvshot/v1.0.1/remove-python.sh -o remove-python.sh
```

### 2️⃣ Inspect before use

Always review the downloaded scripts to ensure you trust the content:

```bash
less setup.sh
```

### 3️⃣ Run the setup script

To create and activate a Python virtual environment (default version: 3.9.6):

```bash
source setup.sh
```

Or specify a Python version explicitly, for example:

```bash
source setup.sh 3.11.6
# or
# source setup.sh 3.13
```

This will:

- Create a `.uvshot-env` file with project-specific paths. This dotenv 
  contains the environment variable and value pair used by `uv` to manage
  python download and venv creation.

  **WARNING: If your project directory already contains a `.uvshot-env` dotenv
  file, running `setup.sh` will overwrite the existing dotenv file.**

- Download python version 3.11.6 in a directory `./python` within your project directory
  using `uv`.

- Create a virtual environment in `./venv` directory.

- Install dependencies from requirements.txt (if present).

After completion, you’ll see a success message confirming setup.


### 4️⃣ Clean up

To remove all managed Python installations and cached data created by `uvshot`:

```bash
source remove-python.sh
```

This will safely delete:

- Installed Python versions under your project’s `python` directory
- The `uv-cache` directory
- The `.uvshot-env` file created by `setup.sh`

## 💡 Notes

- ✅ Works on Linux and macOS (POSIX-compliant shells such as bash or zsh)
- ⚠️ Not compatible with Windows cmd.exe or PowerShell — use WSL instead
- 🔍 Always inspect shell scripts before sourcing them in your environment


## 🏷️ Versioning

Releases are tagged on GitHub. You can use a specific version tag in the download URL for stability, for example:

```bash
curl -L https://raw.githubusercontent.com/shafayetShafee/uvshot/v1.0.0/setup.sh -o setup.sh
```

---

**Author:** [Shafayet Khan Shafee](https://github.com/shafayetShafee)  
**License:** [MIT](./LICENSE)
