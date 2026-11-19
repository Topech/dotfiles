# Unity CLI
. "/Users/Ben.Longbottom/.unity/env"

# pnpm
export PNPM_HOME='/Users/Ben.Longbottom/Library/pnpm'
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
