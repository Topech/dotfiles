(defvar my/default-font-size 120)

(scroll-bar-mode -1)
(set-fringe-mode 10)


(setq inhibit-startup-message t)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)


;; (set-face-attribute 'default nil :font "monospace" :height my/default-font-size)
;; (set-face-attribute 'fixed-pitch nil :font "monospace" :height my/default-font-size)
;; (set-face-attribute 'variable-pitch nil :font "Ubuntu Regular" :height 140 :weight 'regular)


(use-package all-the-icons)
;; note: must run
    ;; M-x all-the-icons-install-fonts


(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 15))


;; line numbers
(column-number-mode)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

(dolist (mode '(term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


(use-package doom-themes
 :init (load-theme `doom-gruvbox t))

; (use-package zenburn-theme
;  :init (load-theme 'zenburn t))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))


(use-package tab-bar
  :init (tab-bar-mode 1))
