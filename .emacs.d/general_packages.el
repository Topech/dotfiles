(use-package ivy
  :diminish
  :config
  (ivy-mode 1))  ;; set all default stuff through ivy




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


