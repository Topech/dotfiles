# HELPERS

_prompt_color() {
	local COLOR="$1"
	local PROMPT="$2"

	echo '%F{'${COLOR}${PROMPT}'%f'
}


_configure_prompt() {
	setopt PROMPT_SUBST
}


_configure_git_info_in_prompt() {
	autoload -Uz vcs_info
	zstyle ':vcs_info:git:*' check-for-changes true
	zstyle ':vcs_info:git:*' stagedstr '.'
	zstyle ':vcs_info:git:*' unstagedstr '+'
	_UNTRACKED_STR='?'  # NOTE: need to do it manually (see untracked_placeholder substitution)
	_UNTRACKED_PLACEHOLDER='___UNTRACKED_PLACEHOLDER___'

	local _STAGED_STR_PROMPT="$(_prompt_color green '%c' )"
	local _UNSTAGED_STR_PROMPT="$(_prompt_color yellow '%u' )"
	_UNTRACKED_STR_PROMPT="$(_prompt_color magenta "${_UNTRACKED_STR}" )"

	local _CHANGES_PROMPT="${_STAGED_STR_PROMPT}${_UNSTAGED_STR_PROMPT}${_UNTRACKED_PLACEHOLDER}"

	zstyle ':vcs_info:git:*' formats "$(_prompt_color green '[%b(' )${_CHANGES_PROMPT}$(_prompt_color green ')]' )"
	zstyle ':vcs_info:git:*' actionformats "$(_prompt_color yellow '[%b:%a(' )${_CHANGES_PROMPT}$(_prompt_color yellow ')]' )"

    GIT_PROMPT_MSG='${vcs_info_msg_0_}'
}


_configure_venv_in_prompt() {
    export VIRTUAL_ENV_DISABLE_PROMPT=yes
}


generate_git_prompt() {
	vcs_info

	if git status --porcelain --untracked-files=normal 2>/dev/null | grep -q '^??' ; then
		vcs_info_msg_0_=${vcs_info_msg_0_//$_UNTRACKED_PLACEHOLDER/$_UNTRACKED_STR_PROMPT}
	else
		vcs_info_msg_0_=${vcs_info_msg_0_//$_UNTRACKED_PLACEHOLDER/}
	fi
}


generate_venv_prompt() {
	VENV_PROMPT=''

	[[ -n ${VIRTUAL_ENV-} ]] || return

	local name=${VIRTUAL_ENV:t}

	if [[ $name == .venv ]]; then
	    local project_dir=${VIRTUAL_ENV:h}
	    name=${project_dir:t}

		if [[ $name == frontend || $name == backend ]]; then
			local parent_dir=${project_dir:h}
			name="${parent_dir:t}/${project_dir:t}"
		fi
  	fi

	VENV_PROMPT="$(_prompt_color magenta "[${name}]" )"
}


# PROMPT CONFIG 

_configure_prompt
_configure_git_info_in_prompt
_configure_venv_in_prompt


precmd() { 
	generate_git_prompt
	generate_venv_prompt
}



# PROMPT DEFINITION

_USER_MACHINE_PROMPT_PART="$(_prompt_color cyan '%n' )$(_prompt_color yellow @ )$(_prompt_color cyan '%m' )"
PROMPT='> ${VENV_PROMPT}'"${GIT_PROMPT_MSG}"' >>> '${_USER_MACHINE_PROMPT_PART}':$(_prompt_color yellow '%~' )  $(_prompt_color yellow '%#' ) '
RPROMPT='%F{yellow}%D{%H:%M}%f'
