;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 18 :weight 'semi-light))

(setq doom-theme 'kanagawa-wave)
(doom/set-frame-opacity 95)

;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).

(setq projectile-project-search-path '("~/dev/src"))

(setq org-directory "~/org/")
(after! org
  (setq org-agenda-deadline-leaders '("" "" "%2d d. ago: ")
        org-todo-keywords '((sequence "TODO" "WAIT" "HOLD" "DOING" "|" "DONE"))
        org-log-into-drawer t
        org-deadline-warning-days 0
        org-agenda-span 14
        org-agenda-start-day "-0d"
        org-agenda-skip-function-global '(org-agenda-skip-entry-if 'todo 'done)
        org-log-done 'date)
  (add-to-list 'org-modules 'org-habit t))

(setq-default tab-width 4)

(setq confirm-kill-emacs nil)

(defun doom/quickload-session (force)
  (interactive "P")
  (progn (message "Restoring session...")
         (doom-load-session)
         (message "Session restored. Welcome back.")))
