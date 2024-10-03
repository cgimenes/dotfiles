(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(ido-mode 1)
(ido-everywhere 1)
(global-display-line-numbers-mode 1)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package kanagawa-themes
  :ensure t
  :config
  (load-theme 'kanagawa-wave t))

(use-package smex
  :ensure t
  :bind (("M-x" . smex)
         ("C-c C-c M-x" . execute-extended-command)))

(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)
         ("C-\"" . mc/skip-to-next-like-this)
         ("C-:" . mc/skip-to-previous-like-this)))

(global-set-key (kbd "C-,") 'duplicate-line)

(setq org-directory "~/org/"
      org-agenda-deadline-leaders '("" "" "%2d d. ago: ")
      org-todo-keywords '((sequence "TODO" "WAIT" "HOLD" "DOING" "|" "DONE"))
      org-deadline-warning-days 0
      org-agenda-span 14
      org-agenda-start-day "-0d"
      org-agenda-skip-function-global '(org-agenda-skip-entry-if 'todo 'done)
      org-log-done 'date)

(setq-default tab-width 4)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-selected-packages '(multiple-cursors smex kanagawa-themes))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Iosevka Nerd Font Mono" :foundry "nil" :slant normal :weight regular :height 181 :width normal)))))
