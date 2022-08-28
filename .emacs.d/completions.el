(use-package ivy
  ;; Ivy provides a minibuffer completion interface.
  :diminish
  :config
  (ivy-mode 1))


(use-package counsel
  ;; Counsel improves ivy functionality for common Emacs commands
  :init (counsel-mode 1))


(use-package ivy-rich
  ;; Ivy-Rich improves ivy buffers
  :init (ivy-rich-mode 1))


(use-package helpful
  ;; Helpful improves upon the built-in Emacs help buffer
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))


(use-package which-key
  ;; Which-key shows possible keys and commands after a delay
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))
