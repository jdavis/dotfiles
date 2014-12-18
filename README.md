Dotfiles
========

> Sometimes the standard configuration just isn't enough.

Over the course of my many (not really) years of developing and using UNIX based
systems. I have amassed various settings, configurations, and what not for my
environment. This is where all of it lives. And it lives on gloriously.

Installation
------------

In order to use these dotfiles, you probably should install them. Below are two
methods of doing so.

### Automatic Installation

The dotfiles can be installed just by running the automatic installer located in
this repository.

**Note:** Piping `curl` straight into `sh` can be very dangerous. Please,
please, look over any file that you are doing this for. In this case, the
original file can be viewed [here][installer].

[installer]: https://github.com/jdavis/dotfiles/blob/master/bin/install_dotfiles.sh

To install, use one of the commands listed below:

Using `curl`:

```bash
    $ curl -L https://raw.githubusercontent.com/jdavis/dotfiles/master/bin/install_dotfiles.sh | sh
```

Using `wget`:

```bash
    $ wget https://raw.githubusercontent.com/jdavis/dotfiles/master/bin/install_dotfiles.sh -O | sh
```

### Manual Installation

1. Clone the repository.

    ```bash
        $ git clone https://github.com/jdavis/dotfiles.git
    ```

2. Copy every single file (including dotfiles) to your home directory. Good luck
   with this. Some useful resources [here][resources].

3. Either restart zsh or run this command:

    ```bash
        $ source ~/.zshrc
    ```

[resources]: http://superuser.com/q/61611
