function _git_prompt_info {
    [[ -n $(whence git_prompt_info) ]] && git_prompt_info
}

function _docker_prompt_info {
    DOCKER_PROMPT_INFO="${DOCKER_PROMPT_INFO:-${DOCKER_MACHINE_NAME}}"
    DOCKER_PROMPT_INFO="${DOCKER_PROMPT_INFO:-${DOCKER_HOST/tcp:\/\//}}"
    if [ -n "${DOCKER_PROMPT_INFO}" ]; then
        echo "${ZSH_THEME_DOCKER_PROMPT_PREFIX}${DOCKER_PROMPT_INFO}${ZSH_THEME_DOCKER_PROMPT_SUFFIX}"
    fi
}

function _custom_prompt_prefix() {
  echo "(${ZSH_KUBECTL_PROMPT}) "
}

PROMPT='╭ %{$fg[red]%}%{$fg[green]%}$(_custom_prompt_prefix)%{$fg[cyan]%}%~ %{$fg[blue]%}$(_docker_prompt_info)$(_git_prompt_info)%{$fg[blue]%} % %{$reset_color%}
╰ » '

ZSH_THEME_GIT_PROMPT_PREFIX="git:‹%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}› %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}›"

ZSH_THEME_DOCKER_PROMPT_PREFIX="docker:‹%{$fg[red]%}"
ZSH_THEME_DOCKER_PROMPT_SUFFIX="%{$fg[blue]%}› "

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
RPS1='%{$fg[yellow]%}[%D{%f/%m} %T]%{$reset_color%}${return_code}'
