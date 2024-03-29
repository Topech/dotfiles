(setq-default indent-tabs-mode nil)

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom (projectile-completion-system 'ivy)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Projects/Code")
    (setq projectile-project-search-path '("~/Projects/Code")))
  (setq projectile-switch-project-action #'projectile-dired))


(use-package counsel-projectile
  :config (counsel-projectile-mode))


;;(use-package magit)


;; (use-package lsp-mode
;;   :commands (lsp lsp-deferred)
;;   :hook
;;   (;(python-mode . lsp-deferred)
;;    (vue-mode . lsp-deferred))
;;   :init
;;   (setq lsp-keymap-prefix "C-c l")
;;   :config
;;   (lsp-enable-which-key-integration t))


;; (use-package lsp-pyright
;;   :hook (python-mode . (lambda ()
;; 			  (require 'lsp-pyright)
;; 			  (lsp-deferred))))


;; (use-package lsp-ui)


;;(use-package company)


(use-package vue-mode)
(use-package python-mode)

(use-package tree-sitter)
(use-package tree-sitter-langs)
