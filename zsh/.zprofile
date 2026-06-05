
[[ "$OSTYPE" == "darwin"* ]] && [[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv zsh)"
[[ "$OSTYPE" == "darwin"* ]] && export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
