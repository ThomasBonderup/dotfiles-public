#-------- Global Alias {{{
#------------------------------------------------------
# Automatically Expanding Global Aliases (Space key to expand)
# references: http://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html 
# globalias() {
#   if [[ $LBUFFER =~ '[A-Z0-9]+$' ]]; then
#     zle _expand_alias
#     zle expand-word
#   fi
#   zle self-insert
# }
# zle -N globalias
# bindkey " " globalias                 # space key to expand globalalias
# # bindkey "^ " magic-space            # control-space to bypass completion
# bindkey "^[[Z" magic-space            # shift-tab to bypass completion
# bindkey -M isearch " " magic-space    # normal space during searches

# blank aliases
typeset -a baliases
baliases=()

balias() {
  alias $@
  args="$@"
  args=${args%%\=*}
  baliases+=(${args##* })
}

# ignored aliases
typeset -a ialiases
ialiases=()

ialias() {
  alias $@
  args="$@"
  args=${args%%\=*}
  ialiases+=(${args##* })
}

# functionality
expand-alias-space() {
  [[ $LBUFFER =~ "\<(${(j:|:)baliases})\$" ]]; insertBlank=$?
  if [[ ! $LBUFFER =~ "\<(${(j:|:)ialiases})\$" ]]; then
    zle _expand_alias
  fi
  zle self-insert
  if [[ "$insertBlank" = "0" ]]; then
    zle backward-delete-char
  fi
}
zle -N expand-alias-space

# starts one or multiple args as programs in background
background() {
  for ((i=2;i<=$#;i++)); do
    ${@[1]} ${@[$i]} &> /dev/null &
  done
}

bindkey " " expand-alias-space
bindkey -M isearch " " magic-space

bindkey "^[l" forward-char
bindkey "^[j" backward-char
bindkey "^[i" history-search-backward
bindkey "^[k" history-search-forward

