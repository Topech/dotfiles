(defun insert-line-above ()
  (interactive)
  (save-excursion
    (end-of-line 0)
    (open-line 1)))


(defun insert-line-below ()
  (interactive)
  (save-excursion
    (end-of-line)
    (open-line 1)))


(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)

  (evil-set-leader 'motion (kbd "<SPC>"))
  
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-global-set-key 'motion "H" 'evil-first-non-blank)
  (evil-global-set-key 'normal "J" 'evil-next-line)
  (evil-global-set-key 'motion "K" 'evil-previous-line)
  (evil-global-set-key 'motion "L" 'evil-last-non-blank)

  (evil-global-set-key 'normal (kbd "<leader>o") 'insert-line-below)
  (evil-global-set-key 'normal (kbd "<leader>O") 'insert-line-above)
  
  (evil-global-set-key 'motion (kbd "<leader>x") 'execute-extended-command)

  (evil-global-set-key 'motion (kbd "<leader>wh") 'evil-window-left)
  (evil-global-set-key 'motion (kbd "<leader>wj") 'evil-window-down)
  (evil-global-set-key 'motion (kbd "<leader>wk") 'evil-window-up)
  (evil-global-set-key 'motion (kbd "<leader>wl") 'evil-window-right)
)

;; (use-package evil-collection
  ;; :after evil
  ;; :config
  ;; (evil-collection-init))