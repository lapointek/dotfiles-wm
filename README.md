# Fedora Sway Dotfiles

Personal dotfiles for my Fedora Sway setup.

## Installation

### Requirements

```
- GNU Stow
- Git
```

1. Clone this repository into your $HOME directory:

```
$ git clone https://github.com/lapointek/dotfiles.git

cd dotfiles
```

2. Then use GNU stow in the root of the dotfiles directory to create the symlinks.

```
stow .
```

# Fedora Sway Only

## Development Environment Setup

The script automates the setup of my personal development environment on Fedora Linux. It installs development tools and desktop applications.

## Features

-   Automated system update
-   Auto detect and skip preinstalled packages
-   Package installation:
    -   Desktop applications
    -   Development tools

### Requirements

    - Fedora Linux Sway installation

1. Run the install script.

```
./install.sh
```

2. Follow the script prompts.

3. Reboot system.
