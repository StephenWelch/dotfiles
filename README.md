# dotfiles
[![Top Langs](https://github-readme-stats.vercel.app/api/top-langs/?username=stephenwelch&count_private=true)](https://github.com/anuraghazra/github-readme-stats)

[![Github Stats](https://github-readme-stats.vercel.app/api?username=stephenwelch&count_private=true&show_icons=true&include_all_commits=true)](https://github.com/anuraghazra/github-readme-stats)

Install dependencies
```
sudo apt install stow curl make neovim build-essential
```

Clone the repo
```
https://github.com/StephenWelch/dotfiles.git
```

Symlink dotfiles
```
cd dotfiles
make
```

Set up [vim-plug](https://github.com/junegunn/vim-plug)
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Install neovim plugins
```
nvim
:PlugInstall
```

Create SSH Key
```
ssh-keygen
```
