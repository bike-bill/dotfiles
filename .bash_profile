if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
#if which jenv > /dev/null; then eval "$(jenv init -)"; fi

