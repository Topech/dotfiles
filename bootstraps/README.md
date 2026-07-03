# Bootstrap Scripts

This directory contains scripts for bootstrapping machines and getting them ready enough to directly use dotfiles.

To use one of these scripts, do the following:

1. get the URL

	```
	$ GITHUB_USER=topech
	$ REPO=dotfiles
	$ REPO_BRANCH=master
	$ BOOTSTRAP_SCRIPT=nixos-bootstrap.sh  # NOTE: choose one of the existing files in the folder

	$ BOOTSTRAP_SCRIPT_URL="https://raw.githubusercontent.com/${GITHUB_USER}/${REPO}/${REPO_BRANCH}/bootstraps/${BOOTSTRAP_SCRIPT}"

	$ echo $BOOTSTRAP_SCRIPT_URL
	https://raw.githubusercontent.com/topech/dotfiles/master/bootstraps/nixos-bootstrap.sh
	```

2. Execute on machine

	```
	$ curl --silent $BOOTSTRAP_SCRIPT_URL | bash -s
	# or
	# curl --silent https://raw.githubusercontent.com/topech/dotfiles/master/bootstraps/nixos-bootstrap.sh | bash -s
	```
