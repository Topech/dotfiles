(use-package ivy
  :diminish
  :config
  (ivy-mode 1))  ;; set all default stuff through ivy


(use-package all-the-icons)
;; note: must run
    ;; M-x all-the-icons-install-fonts


(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 15))


;; line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


(use-package doom-themes
  :init (load-theme `doom-gruvbox t))


(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))


(use-package counsel
  :init (counsel-mode 1))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))


