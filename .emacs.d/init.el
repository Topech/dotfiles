(load "~/.emacs.d/helpers.el")

(load (my/helpers/xah-get-fullpath "setup_packages.el"))

(load (my/helpers/xah-get-fullpath "general_packages.el"))
(load (my/helpers/xah-get-fullpath "keybinds.el"))
(load (my/helpers/xah-get-fullpath "gui.el"))
(load (my/helpers/xah-get-fullpath "completions.el"))
(load (my/helpers/xah-get-fullpath "programming.el"))

(load (my/helpers/xah-get-fullpath "org.el"))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(setq
 make-backup-files nil
 auto-save-default nil
 create-lockfiles nil)

