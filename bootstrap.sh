########## Variables

dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
files="bash_aliases bash_profile bashrc dir_colors vimrc vim \
       git_svn_bash_prompt gitignore_global \
       mongorc.js vim vimrc"        

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
