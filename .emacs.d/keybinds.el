(defun my/insert-line-above (n)
  (interactive "p")
  (save-excursion
    (end-of-line 0)
    (open-line n)))


(defun my/insert-line-below (n)
  (interactive "p")
  (save-excursion
    (end-of-line)
    (open-line n)))


(defun my/kill-all-windows ()
  (interactive)
  (delete-other-windows)
  (delete-window))


(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-tree)
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

  (evil-global-set-key 'normal (kbd "<leader>o") 'my/insert-line-below)
  (evil-global-set-key 'normal (kbd "<leader>O") 'my/insert-line-above)
  
  (evil-global-set-key 'motion (kbd "<leader>x") 'execute-extended-command)

  (evil-global-set-key 'motion (kbd "<leader>wh") 'evil-window-left)
  (evil-global-set-key 'motion (kbd "<leader>wj") 'evil-window-down)
  (evil-global-set-key 'motion (kbd "<leader>wk") 'evil-window-up)
  (evil-global-set-key 'motion (kbd "<leader>wl") 'evil-window-right)

  (evil-global-set-key 'motion (kbd "<leader>wH") 'evil-window-move-far-left)
  (evil-global-set-key 'motion (kbd "<leader>wJ") 'evil-window-move-very-bottom)
  (evil-global-set-key 'motion (kbd "<leader>wK") 'evil-window-move-very-top)
  (evil-global-set-key 'motion (kbd "<leader>wL") 'evil-window-move-far-right)

  (evil-global-set-key 'motion (kbd "<leader>ws") 'evil-window-split)
  (evil-global-set-key 'motion (kbd "<leader>wS") 'evil-window-vsplit)

  (evil-global-set-key 'normal "U" 'evil-redo)
)


;; (use-package evil-collection
  ;; :after evil
  ;; :config
  ;; (evil-collection-init))
