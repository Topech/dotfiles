(defun my/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))


(defun my/org-font-setup ()
  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.9)
                  (org-level-2 . 1.7)
                  (org-level-3 . 1.5)
                  (org-level-4 . 1.3)
                  (org-level-5 . 1.2)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Arial" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))


(use-package org
  :hook (org-mode . my/org-mode-setup)
  :config
  (setq org-ellipsis " -")
  (setq org-hide-emphasis-markers nil)
  (setq org-agenda-start-with-log-mode 1)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-agenda-files
	'("~/.emacs.d/Org_Files/Tasks.org"
	  "~/.emacs.d/Org_Files/Habits.org"))

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)
  
  (my/org-font-setup))


(defun my/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . my/org-mode-visual-fill))



