# uvshot

`uvshot` is a simple, fast script to set up and manage Python virtual environments using `uv`.

---

## Prerequisites

- [uv](https://docs.astral.sh/uv/getting-started/installation/) must be installed on your system.

---

## Installation & Usage

1. Download the setup script in your project directory with `curl`

    ```bash
    curl -L https://raw.githubusercontent.com/shafayetShafee/uvshot/main/setup.sh -o setup.sh
    ```

2. Inspect the sciprt before using.

3. if seems trustable, then run `source setup.sh` from your project directory.

4. Or you can download all the repo contents,

   ```bash
    curl -L https://github.com/shafayetShafee/uvshot/archive/refs/heads/main.zip -o uvshot.zip && \
    unzip uvshot.zip && \
    mv uvshot-main/* . && \
    rm -rf uvshot-main uvshot.zip
   ```