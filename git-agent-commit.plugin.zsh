0="${ZERO:-${${0:A}:-${(%):-%N}}}"
local plugin_dir="${0:h}"
if [[ ! "$PATH" == *"${plugin_dir}/bin"* ]]; then
  export PATH="${plugin_dir}/bin:$PATH"
fi

_bind_commit_agent() {
  local cmd_name="$1"
  eval "
    $cmd_name() {
      local msg
      msg=\$(command $cmd_name \"\$@\") || return 1
      print -z \"git commit -m \\\"\$msg\\\"\"
    }
  "
}

_bind_commit_agent "git-agycommit"
_bind_commit_agent "git-mimocommit"
_bind_commit_agent "git-claudecommit"
_bind_commit_agent "git-qwencommit"

alias gagy="git-agycommit"
alias gmimo="git-mimocommit"
alias gcl="git-claudecommit"
alias gqwen="git-qwencommit"

git() {
  case "$1" in
    agycommit|mimocommit|claudecommit|qwencommit)
      local sub="$1"
      shift
      "git-$sub" "$@"
      ;;
    *)
      command git "$@"
      ;;
  esac
}