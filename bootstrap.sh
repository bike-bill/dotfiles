########## Variables

dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
files="aliases bash_profile bashrc \
       gitconfig \
       git_svn_bash_prompt gitignore_global \
       mongorc.js vim vimrc zsh-dircolors.config \
       zshrc zshrc.pre-oh-my-zsh"        

##########

# create dotfiles_old in homedir
rm -rf $olddir
mkdir -p $olddir

# change to the dotfiles directory
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    mv ~/.$file $olddir
    ln -s $dir/$file ~/.$file
done

source ~/.bash_profile
