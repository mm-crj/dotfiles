# dotfiles

The main branch keeps track of the config on my work pc and the laptop branch does it for my personal laptop. This branching becomes necessery as the config still has hard coded '$HOME' variables at places. Sometimes I don't know how to replace them. I hope to do it some day..... :)

### Usage

The alias for git on this git bare repo is `df` as you can see [here](https://github.com/mm-crj/dotfiles/blob/9fe79177cd02dd5bd79158969c0cfec68eb50ef4/.zshrc#L106). To add all the tracked files and push follow the below commands

```zsh
df add -u
df commit -m 'some message'
df push
```

### Directory structure

`.config/kitty
.config/nvim
.config/rofi
.config/zathura/zathurarc
.julia/config/startup.jl
.zshenv
.zshrc
README.md`
