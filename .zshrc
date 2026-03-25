# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# -------- NVM: lazy load + Node padrão no PATH --------
# ------------ NVM: carga normal ------------

export NVM_DIR="$HOME/.nvm"

# carrega nvm em todo shell (login/interactive)
if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
fi

# auto-completion opcional
if [ -s "$NVM_DIR/bash_completion" ]; then
  . "$NVM_DIR/bash_completion"
fi

# ------------ Conda: lazy load ------------
_conda_lazy_init() {
  local CONDA_SH="$HOME/miniconda3/etc/profile.d/conda.sh"
  if [ -f "$CONDA_SH" ]; then
    . "$CONDA_SH"
  else
    echo "conda.sh não encontrado em $CONDA_SH"
    return 1
  fi
}

conda() {
  unset -f conda
  _conda_lazy_init
  conda "$@"
}

# Se quiser, você pode descomentar este alias para ativar conda com um comando próprio:
# alias ativar-conda='_conda_lazy_init'

# ------------ PATH extra ------------
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

