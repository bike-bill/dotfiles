########## Variables

dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
files=".bash_aliases .bash_profile .bashrc .dir_colors .vimrc .vim \
       .git .git_svn_bash_prompt .gitconfig .gitignore_global \
       .mongorc.js .vim .vimrc"        

##########

# create dotfiles_old in homedir
echo "Removing the previous $olddir"
rm -rf $olddir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/$file $olddir
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file
done

source ~/.bash_profile