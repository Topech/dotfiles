{ lib, config,... }:


let
  cfgSharedModels = config.llm.sharedModels;

  _makeUserConfig = username: {
    name = username;
    value = { extraGroups = [ cfgSharedModels.group ]; };
  };
  _userConfigList = map _makeUserConfig cfgSharedModels.allowedUsers;

  userConfigsAllowSharedModelsAccess = builtins.listToAttrs _userConfigList;
in
{
  options.llm.sharedModels = {
    dir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/llm-models";
      description = "Unified path for all LLM models";
    };
    group = lib.mkOption {
      type = lib.types.str;
      default = "llm-models";
      description = "Group with read/write access to LLM models";
    };
    allowedUsers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "List of users given read/write acess to LLM models";
    };
  };

  options.llm.secretsDir = lib.mkOption {
    type = lib.types.str;
    default = "/var/lib/llm-models/secrets";
    description = "Path to secrets for LLMs";
  };

  config = {
    users.groups."${cfgSharedModels.group}" = { };
    users.users = userConfigsAllowSharedModelsAccess;

    systemd.tmpfiles.rules = [
      # NOTE: 2XXX is the "Set Group ID" flag, so all files created within will keep the group ID 
      #  (ONLY for created files, not moved ones)
      "d ${cfgSharedModels.dir} 2775 root ${cfgSharedModels.group} - -"
      "d ${config.llm.secretsDir} 0770 root ${cfgSharedModels.group} - -"
      # copy example env file if it doesn't exist
      "C ${config.llm.secretsDir}/.env 0640 root ${cfgSharedModels.group} - ${./env.example}"
    ];
  };
}
