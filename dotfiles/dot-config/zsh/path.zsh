# Unity CLI
if [ -d "$HOME/.unity/env" ] ; then
    . "$HOME/.unity/env" 
fi


export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac


local user_bin="$HOME/bin"
case ":$PATH:" in
  *":$user_bin:"*) ;;
  *) export PATH="$user_bin:$PATH" ;;
esac


local user_local_bin="$HOME/.local/bin"
case ":$PATH:" in
  *":$user_local_bin:"*) ;;
  *) export PATH="$user_local_bin:$PATH" ;;
esac


local snowcli_path="/Users/Ben.Longbottom/.local/share/snowflake-cli/bin:$PATH"
if [ -d "$snowcli_path" ] ; then
    case ":$PATH:" in
      *":$snowcli_path:"*) ;;
      *) export PATH="$snowcli_path:$PATH" ;;
    esac
fi
