# dotfiles
[![Top Langs](https://github-readme-stats.vercel.app/api/top-langs/?username=stephenwelch&count_private=true)](https://github.com/anuraghazra/github-readme-stats)

[![Github Stats](https://github-readme-stats.vercel.app/api?username=stephenwelch&count_private=true&show_icons=true&include_all_commits=true)](https://github.com/anuraghazra/github-readme-stats)

Install dependencies
```
sudo apt install make
```

Clone the repo
```
https://github.com/StephenWelch/dotfiles.git
```

Install dotfiles
```
cd dotfiles
make install
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

- Install gitkraken
- turn on dark mode
		- turn off line highlighting in gedit
- Install oh-my-zsh
- Install p10k
- Install `gnome-tweak-tool` and `chrome-gnome-shell`
- To use airpods: `ControllerMode = bredr` in `/etc/bluetooth/main.conf`, `sudo /etc/init.d/bluetooth restart`
- To fix time on dual-booted systems: `timedatectl set-local-rtc 1`
