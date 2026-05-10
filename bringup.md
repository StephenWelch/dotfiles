- install gitkraken
- turn on dark mode
		- turn off line highlighting in gedit
- install neovim
- alias vim to neovim: `alias vim=nvim`
- install oh-my-zsh
- install p10k
- to use airpods: `ControllerMode = bredr` in `/etc/bluetooth/main.conf`, `sudo /etc/init.d/bluetooth restart`
- on mac: add `auth sufficient pam_tid.so` to `/etc/pam.d/sudo` to enable touch id for sudo
- to install vim-plug:
`sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'`
- shortcut for taking screenshot of area: https://askubuntu.com/a/170460

## Beads workflow (medusa)

One-time per project:

```
bd init        # creates the .beads/ graph DB
```

`medusa` is the entrypoint. N defaults to 1.

```
medusa                        # one agent in the current repo
medusa 3                      # three agents in git worktrees, tmux panes
BD_HARNESS=claude medusa 3    # same swarm, Claude Code as the brain
                              #   (install: npm i -g @anthropic-ai/claude-code)
```
