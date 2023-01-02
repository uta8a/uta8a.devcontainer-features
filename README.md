# uta8a devcontainer features

For my personal use.

## done

- `neovim`: Neovim nightly
- `vim`: vim latest

## wip

- `riscv-dev`: cross-compile risc-v environment

### `neovim`

Running `nvim` inside the built container will execute [Neovim](https://neovim.io/) nightly.

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/uta8a/uta8a.devcontainer-features/neovim:1": {}
    }
}
```

```bash
$ nvim
# startup Neovim
```

### `vim`

Running `vim` inside the built container will execute [vim](https://www.vim.org/) latest release at [vim/vim-appimage](https://github.com/vim/vim-appimage/releases)

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/uta8a/uta8a.devcontainer-features/vim:1": {}
    }
}
```

```bash
$ vim
# startup vim
```

## Repo and Feature Structure

Similar to the [`devcontainers/features`](https://github.com/devcontainers/features) repo, this repository has a `src` folder.  Each Feature has its own sub-folder, containing at least a `devcontainer-feature.json` and an entrypoint script `install.sh`. 

```
├── src
│   ├── hello
│   │   ├── devcontainer-feature.json
│   │   └── install.sh
│   ├── color
│   │   ├── devcontainer-feature.json
│   │   └── install.sh
|   ├── ...
│   │   ├── devcontainer-feature.json
│   │   └── install.sh
...
```

An [implementing tool](https://containers.dev/supporting#tools) will composite [the documented dev container properties](https://containers.dev/implementors/features/#devcontainer-feature-json-properties) from the feature's `devcontainer-feature.json` file, and execute in the `install.sh` entrypoint script in the container during build time.  Implementing tools are also free to process attributes under the `customizations` property as desired.

### Options

All available options for a Feature should be declared in the `devcontainer-feature.json`.  The syntax for the `options` property can be found in the [devcontainer Feature json properties reference](https://containers.dev/implementors/features/#devcontainer-feature-json-properties).

For example, the `color` feature provides an enum of three possible options (`red`, `gold`, `green`).  If no option is provided in a user's `devcontainer.json`, the value is set to "red".

```jsonc
{
    // ...
    "options": {
        "favorite": {
            "type": "string",
            "enum": [
                "red",
                "gold",
                "green"
            ],
            "default": "red",
            "description": "Choose your favorite color."
        }
    }
}
```

Options are exported as Feature-scoped environment variables.  The option name is captialized and sanitized according to [option resolution](https://containers.dev/implementors/features/#option-resolution).

```bash
#!/bin/bash

echo "Activating feature 'color'"
echo "The provided favorite color is: ${FAVORITE}"

...
```
