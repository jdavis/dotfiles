if [[ -d ~/.git ]]; then
    echo "Oh my. It looks like you already have a Git repository in your home directory. You'll need to fix this before you install the dotfiles."
    exit
fi

hash git 2> /dev/null || {
    echo "Oh dear. I require Git, but it's not installed."
}

echo "Initializing a blank repo..."
git init

echo "Adding dotfiles remote origin...."
git remote add origin https://github.com/jdavis/dotfiles.git

echo "Pulling all the code..."
git pull origin master

echo "Let submodule this shit..."
git submodule init
git submodule update

builtin cd ~/.vim
git submodule init
git submodule update

echo "To install Vundle Bundles, run the command below:"
echo "\tvim +BundleInstall +qall"

echo "Dotfiles are now installed. Proceed to conquer the universe."
source ~/.zshrc
