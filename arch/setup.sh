# sync deps
sudo pacman -S - < arch.txt

if [ ! -f "~/.zshrc_initialized" ]; then
  cp .p10k.zsh ~/.
  cat zshrc_append >> ~/.zshrc
  touch ~/.zshrc_initialized
fi
