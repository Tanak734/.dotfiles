# ~/.zshrc

# No Zsh, o arquivo .zshrc só é carregado em sessões interativas por padrão, 
# então a verificação de "interactive shell" do bash é opcional, mas vamos manter por segurança.
[[ -o interactive ]] || return

# --- Aliases Básicos ---
alias ls='eza -a --icons' # Note que este alias sobrescreve o 'ls --color=auto' abaixo
alias grep='grep --color=auto'
alias cls="clear"

# --- Variáveis de Ambiente ---
export JAVA_HOME=/usr/lib/jvm/default
export PATH=$PATH:$JAVA_HOME/bin
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH=${PATH}:$HOME/.config/composer/vendor/bin/

# --- Rust (Cargo) ---
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# --- Ruby (rbenv) ---
# O comando init detecta o shell automaticamente, mas é bom garantir
eval "$(rbenv init - zsh)"

# --- Conda (Anaconda/Miniconda) ---
# Ajustado para usar o script compatível com Zsh se disponível
alias conda_on='source ~/miniconda3/etc/profile.d/conda.sh' 
# Dica: Se não funcionar, tente: source ~/anaconda3/etc/profile.d/conda.zsh

# --- NVM (Node Version Manager) ---
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# IMPORTANTE: O bash_completion não funciona no Zsh. 
# O Zsh tem seu próprio sistema de completion. 
# Se você usa Oh My Zsh, basta adicionar 'nvm' na lista de plugins.
if [ -s "$NVM_DIR/bash_completion" ]; then
    # Opcional: Carregar suporte de compatibilidade se necessário
    autoload -U +X compinit && compinit
    autoload -U +X bashcompinit && bashcompinit
    source "$NVM_DIR/bash_completion"
fi

# --- Prompt (Starship) ---
# ALTERAÇÃO CRÍTICA: Mudamos de 'bash' para 'zsh'
eval "$(starship init zsh)"


# --- Adicionando plugins do ZSH ---
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Configuração de Histórico (Opcional, mas recomendado)
HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory sharehistory


# Completação ignorando case (Maiúsculas/Minúsculas)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Isso garante que se você digitar 'mkdir PastaNova', 
# o diretório será criado exatamente com o 'P' e 'N' maiúsculos.
