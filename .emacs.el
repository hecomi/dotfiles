;; Ctrl+h
(global-set-key "\C-h" 'delete-backward-char)


;Temporary Folder
(setq backup-directory-alist
`((".*" . ,"/tmp/emacs/backup/")))

(setq auto-save-file-name-transforms
`((".*" ,"/tmp/emacs/backup/" t)))


;; EUC
;(set-terminal-coding-system 'euc-jp)
;(set-keyboard-coding-system 'euc-jp)

;; emacs sudo
(defun file-root-p (filename)
  "Return t if file FILENAME created by root."
  (eq 0 (nth 2 (file-attributes filename))))

(defun th-rename-tramp-buffer ()
  (when (file-remote-p (buffer-file-name))
    (rename-buffer
     (format "%s:%s"
             (file-remote-p (buffer-file-name) 'method)
             (buffer-name)))))

(add-hook 'find-file-hook
          'th-rename-tramp-buffer)

(defadvice find-file (around th-find-file activate)
  "Open FILENAME using tramp's sudo method if it's read-only."
  (if (and (file-root-p (ad-get-arg 0))
           (not (file-writable-p (ad-get-arg 0)))
           (y-or-n-p (concat "File "
                             (ad-get-arg 0)
                             " is read-only.  Open it as root? ")))
      (th-find-file-sudo (ad-get-arg 0))
    ad-do-it))

(defun th-find-file-sudo (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file (concat "/sudo::" file))))


;; Flymake
(require 'flymake)

(setq flymake-gui-warnings-enabled nil)

(defun flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "g++-4.6" (list "-Wall" "-Wextra" "-fsyntax-only" "-std=c++0x" "-fpermissive" "-lboost_system" local-file))))

(push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)

(add-hook 'c++-mode-hook
          '(lambda ()
             (flymake-mode t)))

;; Color-theme
(add-to-list 'load-path "~/.emacs.d")
;(require 'color-theme)
;(color-theme-initialize)
;(color-theme-Comidia)