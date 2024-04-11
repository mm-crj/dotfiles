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
`
~/ 
 |-- .zshrc
 |-- .zshenv
 |-- README.md
.config/
  |--- kitty/
  |--- nvim/
  |--- rofi/
  |--- zathura/zathurarc
  |___ rofi/
`

### To Do
  - [ ] Find a way to list all files in telescope, instead of just the ones opened.
  - [ ] The file names should be form the last directory if it is just a level up. I don't need the full path while trying to change buffers.
  - [ ] Make the git structure actully useful or delete it. Lazy git and telescope diff. 
  - [ ] Integrate flit and leap into workflow.

