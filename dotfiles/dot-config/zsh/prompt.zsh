# HELPERS

_prompt_color() {
	local COLOR="$1"
	local PROMPT="$2"

	echo '%F{'${COLOR}'}'${PROMPT}'%f'
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

    GIT_PROMPT_TEMPLATE='${vcs_info_msg_0_}'
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

generate_dotfiles_git_prompt() {
    DOTFILES_GIT_PROMPT_PART=''
    if git -C ~/Repos/topech/dotfiles status --porcelain=v2 --branch 2>/dev/null |
        grep -Eq '^[12u?] |^# branch\.ab \+[0-9]+ -[1-9]'
    then
        DOTFILES_GIT_PROMPT_PART="$(_prompt_color magenta '[dotfiles!]' )"
    fi
}


generate_venv_prompt() {
	VENV_PROMPT_PART=''

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

	VENV_PROMPT_PART="$(_prompt_color magenta "[${name}]" )"
}


# PROMPT CONFIG 

_configure_prompt
_configure_git_info_in_prompt
_configure_venv_in_prompt


precmd() { 
	generate_git_prompt;
	generate_venv_prompt;
    generate_dotfiles_git_prompt;
}



# PROMPT DEFINITION

local prompt_user_template="%(#.$(_prompt_color red '%n' ).$(_prompt_color cyan '%n' ))"
local prompt_user_machine_template="${prompt_user_template}$(_prompt_color yellow @ )$(_prompt_color cyan '%m' )"
local prompt_symbol_template="%(?.$(_prompt_color green '%#' ).$(_prompt_color red '%#' ))"
local prompt_path_template="$(_prompt_color yellow '%5(~|.../%3~|%~)' )"  # NOTE: %X(~ counts X from ROOT dir, not home dir. how silly
local long_prompt_linebreak_template="$(_prompt_color 8 '%-60(l. . --|'$'\n''|-- )' )"
PROMPT='> ${VENV_PROMPT_PART}'"${GIT_PROMPT_TEMPLATE}"' >>> '"${prompt_user_machine_template}"':'"${prompt_path_template}${long_prompt_linebreak_template}"'${DOTFILES_GIT_PROMPT_PART} '"${prompt_symbol_template}"'  '  

RPROMPT='%F{yellow}%D{%H:%M}%f'
