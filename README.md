# uvshot

`uvshot` is a simple, fast script to set up and manage Python virtual environments 
using [`uv`](https://docs.astral.sh/uv/) in a isolated state. It’s ideal for teams who want a consistent, no-fuss environment setup in their projects.

---

## 🧩 Prerequisites

- Must have [`uv`](https://docs.astral.sh/uv/getting-started/installation/) installed on your system.

---

## 🚀 Installation & Usage

### 1️⃣ Download the scripts

Run the following commands from your project directory to download both setup and cleanup scripts:

```bash
curl -L https://raw.githubusercontent.com/shafayetShafee/uvshot/v1.0.0/setup.sh -o setup.sh
curl -L https://raw.githubusercontent.com/shafayetShafee/uvshot/v1.0.0/remove-python.sh -o remove-python.sh
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


