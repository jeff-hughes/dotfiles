# Jeff's Dotfiles

Here is my collection of dotfiles for configuring some basic programs on my
Linux machine. The process is designed to be relatively easy to set up on a
new machine with little hassle. However, if you don't use the same programs
I do, you should be able to take this repo and add your own config files.

Parts of the code used in this setup were taken from [Nick Nisi's dotfiles
repo](https://github.com/nicknisi/dotfiles).

## Initial setup

First, Clone this repo to ~/.dotfiles on your machine.

```bash
git clone https://github.com/jeff-hughes/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod u+x create_symlinks.sh
./create_symlinks.sh
```

This `create_symlinks.sh` script will do two things:
1. Backup any existing config files that would otherwise get overwritten,
   and store them in `~/dotfiles-backup` (optional).
2. Create symlinks in your home directory that link to the dotfiles in
   the repo.

After running the `create_symlinks.sh` script, you will need to restart your
terminal or run `source ~/.bashrc` to see changes to your terminal.

## Programs configured by these dotfiles

- Bash
- Conky
- Vim
- Tmux
- VS Code (in the repo under "Code - OSS" because I am using the open
  source version)
- Joplin
- Redshift
- GTK (I hate the default GTK scrollbars, so the only thing this does is
  makes them wider)

This also adds some autostart files to start Conky, Plank, and an xcape
command that maps the Windows/Super key to open the Xfce whisker menu.
These autostart files should work on any desktop environment that is
compliant with [XDG specifications](https://www.freedesktop.org/wiki/Specifications/).
However, the `create_symlinks.sh` script *does not* install any packages,
so if you are not using Conky, Plank, or the Xfce whisker menu, you should
delete these files from the `~/.dotfiles/.config/autostart` directory.

## Making modifications

If you want to use this framework to add your own config files, that's
great! Make it your own. The directory structure of the `~/.dotfiles`
folder should mirror the structure of `~/` itself. In other words, a file
in the main directory, like `~/.dotfiles/.foo.symlink`, will create a
symlink at `~/.foo` that points to `~/.dotfiles/.foo.symlink`. If you have
a file at `~/.dotfiles/.config/.bar.symlink`, it will have a corresponding
symlink at `~/.config/.bar`. Thus, you can edit any `.symlink` file in this
repo and it will immediately be reflected (though you may need to restart
the application you are reconfiguring to see the changes). If you add a new
`.symlink` file to the repo, you will need to run `~/.dotfiles/create_symlinks.sh`
again to add the new symlink.

One final note: In the `.bashrc.symlink` file, there is a line that will
source a `~/.localrc` file if it exists. This is a great place to put
data you want in your environment but don't want to add to a git repo, e.g.,
API keys, personal information.
