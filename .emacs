;; load path
(setq load-path (cons "~/.emacs.d" load-path))

;; make backup to a designated dir, mirroring the full path

(defun my-backup-file-name (fpath)
  "Return a new file path of a given file path.
If the new path's directories does not exist, create them."
  (let (backup-root bpath)
    (setq backup-root "~/.emacs.d/emacs-backup")
    (setq bpath (concat backup-root fpath "~"))
    (make-directory (file-name-directory bpath) bpath)
    bpath
  )
)

(setq make-backup-file-name-function 'my-backup-file-name)

;;;
;;; octave mode
;;;
(autoload 'octave-mode "octave-mod" nil t)

(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))

(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))
;;;
;;; predictive abbreviations
;;;

(require 'pabbrev "~/.emacs.d/pabbrev.el")
(global-pabbrev-mode)




  


;;;
;;; Org Mode
;;;
(add-to-list 'load-path (expand-file-name "~/org"))
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(require 'org-install)
(setq org-log-done t)
(setq org-agenda-files (quote("~/org/")))

;;
;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(define-key global-map "\C-cc" 'org-capture)

;; flyspell mode for spell checking everywhere
;;(add-hook 'org-mode-hook 'turn-on-flyspell 'append)

;; Enable abbrev-mode
(add-hook 'org-mode-hook (lambda () (abbrev-mode 1)))

;; Enable habit module
(setq org-modules (quote (org-habit)))

(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))

;; Capture setup
(setq org-default-notes-file (expand-file-name "~/org/notes.org"))

;; External web browser
(setq browse-url-browser-function 'browse-url-generic
       browse-url-generic-program  "/usr/bin/google-chrome")

;;;
;;; buffer switching
;;;
(iswitchb-mode 1)

;;;
;;; skeleton rules
;;; 
(define-skeleton jlex-rule
  "jlex rule"
  ""
  "" str " {" \n
  " return new Symbol(TokenConstants." @ _ ");" \n
  "}")

;;(define-abbrev java-mode-abbrev-table "jlr"
;;  "" 'jlex-rule)

;; package manager
(require 'package)
(package-initialize)