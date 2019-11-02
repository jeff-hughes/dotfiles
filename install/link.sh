#!/usr/bin/env bash

# modified from https://github.com/nicknisi/dotfiles

set -e  # Exit immediately if a command exits with a non-zero status.

DOTFILES=$HOME/.dotfiles
BACKUP_DIR=$HOME/dotfiles-backup

linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )

# Make backup of existing dotfiles
read -rn 1 -p "Back up existing, non-symlinked dotfiles? [y/N] " backup
if [[ $backup =~ ^([Yy])$ ]]; then
    echo -e "\\nCreating backup in $BACKUP_DIR"
    echo "=============================="
    mkdir -p "$BACKUP_DIR"

    for file in $linkables; do
        filename="$( basename "$file" )"
        # filepath grabs the whole path after the $DOTFILES directory and before the actual filename;
        # the weird sed code first escapes all the forward slashes in $DOTFILES and $filename so that
        # sed treats them properly
        filepath=$( echo $file | sed "s/${DOTFILES//\//\\/}\/\(.*\)${filename//\//\\/}/\1/g" )
        target="$HOME/$filepath${filename%.symlink}"
        if [ -f "$target" ]; then
            echo "Backing up $filename"
            mkdir -p "$BACKUP_DIR/$filepath"
            cp "$target" "$BACKUP_DIR/$filepath"
        else
            echo -e "${filename%.symlink} does not exist at this location or is a symlink"
        fi
    done
fi


# Create symlinks for all the dotfiles in the ~/.dotfiles directory
echo -e "\\nCreating symlinks"
echo "=============================="
for file in $linkables ; do
    filename=$( basename "$file" )
    filepath=$( echo $file | sed "s/${DOTFILES//\//\\/}\/\(.*\)${filename//\//\\/}/\1/g" )
    target="$HOME/$filepath${filename%.symlink}"

    if [ -e "$target" ]; then
        echo "~/${target#$HOME/} already exists... Skipping."
    else
        if [[ -n "$filepath" && ! -d "$HOME/$filepath" ]]; then
            echo "Creating ~/$filepath"
            mkdir -p "$HOME/$filepath"
        fi

        echo "Creating symlink for $file"
        ln -s "$file" "$target"
    fi
done
