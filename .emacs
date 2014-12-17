;Load path
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3.1")
(add-to-list 'load-path "~/.emacs.d/nlinum-1.2")

;Background
(set-background-color "white")
; Disable the splash screen
(setq inhibit-splash-screen t)
;; Set window title to be full file path
(setq frame-title-format '("Emacs @ " system-name ": %b %+%+ %f"))
; Add marmalade repo
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
;Add melpa
;(add-to-list 'package-archives
;  '("melpa" . "http://melpa.milkbox.net/packages/") t)
;Fix dependency backward issue
 ;; (defadvice package-compute-transaction
 ;;  (before package-compute-transaction-reverse (package-list requirements) activate compile)
 ;;    "reverse the requirements"
 ;;    (setq requirements (reverse requirements))
 ;;    (print requirements))

; scheme enviroment
(require 'quack)
(setq scheme-program-name "scheme48")
(defun scheme-mode-quack-hook ()
(setq quack-fontify-style 'emacs))
(add-hook 'scheme-mode-hook 'scheme-mode-quack-hook)


;Org mode stuff
(require 'org-install)
(setq org-startup-indented t)
;;(setq org-hide-leading-stars t)
(setq org-src-fontify-natively t)
(setq org-odd-level-only nil)

;; ;Smartparens
;; (require 'smartparens-config)
;; (smartparens-global-mode t)


;Emacs customizations
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(show-paren-mode 1)
;(setq show-paren-delay 0)

; Give buffers with same file name more distinquished names
(require 'uniquify)


;Backward kill word
(global-set-key "\C-q" 'backward-kill-word)

;;Backwards Line kill
(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))
(global-set-key (kbd "C-S-k") 'backward-kill-line) ;; `C-c u'
;;disables arrow keys
;(require 'no-easy-keys)
;(no-easy-keys 1)
;;more kill stuff
(defun my-delete-line-backward ()
  "Delete text between the beginning of the line to the cursor position."
  (interactive)
  (let (x1 x2)
    (setq x1 (point))
    (move-beginning-of-line 1)
    (setq x2 (point))
    (delete-region x1 x2)))


(defun my-delete-line ()
  "Delete text from current position to end of line char."
  (interactive)
  (delete-region
   (point)
   (save-excursion (move-end-of-line 1) (point)))
  (delete-char 1)
)
(defun my-delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times.
This command does not push erased text to kill-ring."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun my-backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument, do this that many times.
This command does not push erased text to kill-ring."
  (interactive "p")
  (my-delete-word (- arg)))

;Evil
(require 'evil)
    (evil-mode 1)
(setq evil-default-cursor t)
;Evil nerd commenting
(evilnc-default-hotkeys)
;Evil-surround
(require 'surround)
(global-surround-mode 1)
;Evil-visual star
(require 'evil-visualstar)
;;Exit insert mode by pressing j and then j quickly
(require 'key-chord)
;;Evil matchit
(require 'evil-matchit)
(global-evil-matchit-mode 1)
;;Key Chord bindings
 (setq key-chord-two-keys-delay 0.4)
 (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
;;Visual and Normal mode
 (key-chord-define evil-normal-state-map "gp" 'evilmi-jump-items)
(define-key evil-normal-state-map  (kbd "gl") 'goto-line)
(define-key evil-normal-state-map (kbd "esc") 'electric-buffer-list)
(define-key evil-normal-state-map (kbd "gd") 'find-tag)
(define-key evil-normal-state-map (kbd "gb") 'pop-tag-mark)
(key-chord-define evil-visual-state-map "gp" 'evilmi-jump-items)
(define-key evil-visual-state-map (kbd "gl") 'goto-line)
(define-key evil-visual-state-map (kbd "esc") 'electric-buffer-list)
(global-set-key (kbd "<M-backspace>") 'my-backward-delete-word)
;(global-set-key (kbd "C-S-k") 'my-delete-line-backward) ;; `C-c u'
;; Alternative for `M-x'
(key-chord-define evil-normal-state-map ";'"   'smex)

;;Emacs picture mode hjkl bindings
(defun pict-mode ()(interactive) (picture-mode) (message "To exit picture mode, C-c C-c"))
(defun picture-mode-map () 
(local-set-key (kbd "C-c") nil)
(local-set-key (kbd "C-k") nil)
(local-set-key (kbd "C-j") 'picture-movement-down)
(local-set-key (kbd "C-k") 'picture-movement-up)
(local-set-key (kbd "C-l") 'picture-movement-right)
(local-set-key (kbd "C-h") 'picture-movement-left)

(local-set-key (kbd "C-u") 'picture-movement-nw)
(local-set-key (kbd "C-o") 'picture-movement-ne)
(local-set-key (kbd "C-n") 'picture-movement-sw)
(local-set-key (kbd "C-.") 'picture-movement-se)

(local-set-key (kbd "C-c C-c")   'picture-mode-exit)
(defun picture-normal-exit()(interactive) (picture-mode-exit) (evil-normal-state))

(local-set-key (kbd "C-c C-c")   'picture-normal-exit)
)
(add-hook 'picture-mode-hook 'picture-mode-map)
(add-hook 'picture-mode-hook 'evil-emacs-state)


;;Magit Stuff
  (key-chord-define evil-normal-state-map "-[" 'magit-status)
;;;MAgit keybindings
(add-hook 'magit-mode-hook
(lambda ()
(local-set-key (kbd "j") 'evil-next-line)
(local-set-key (kbd "k") 'evil-previous-line)
(local-set-key (kbd "K") 'magit-discard-item)
(local-set-key (kbd "<escape>") 'magit-mode-quit-window)))
;;Undo Tree status
(key-chord-define evil-normal-state-map ";u" 'undo-tree-visualize)
(when (boundp 'setup-undo-tree-loaded)

;  (define-key evil-normal-state-map  "U"   'undo-tree-redo)
  (key-chord-define-global "\}\}" 'undo-tree-switch-branch))

;;Make C-e and C-r work in evil
;;(define-key evil-normal-state-map "\C-r" 'isearch-backward)
(define-key evil-normal-state-map "\C-e" 'evil-end-of-line)
(define-key evil-motion-state-map "\C-e" 'evil-end-of-line)
;;Indenting
(define-key evil-visual-state-map (kbd "<tab>") 'c-indent-line-or-region)
;;Wind move bindings
(define-key evil-normal-state-map (kbd "J") 'windmove-down)
(define-key evil-normal-state-map (kbd "H") 'windmove-left)
(define-key evil-normal-state-map (kbd "L") 'windmove-right)
(define-key evil-normal-state-map (kbd "K") 'windmove-up)
(define-key evil-visual-state-map (kbd "J") 'windmove-down)
(define-key evil-visual-state-map (kbd "H") 'windmove-left)
(define-key evil-visual-state-map (kbd "L") 'windmove-right)
(define-key evil-visual-state-map (kbd "K") 'windmove-up)
;Remap j to gj and such, but is a bad idea
;; (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
;; (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

;;(define-key evil-normal-state-map (kbd "gj") 'evil-next-line)
;;(define-key evil-normal-state-map (kbd "gk") 'evil-previous-line)

(key-chord-mode 1)


;Set colors based on mode

;;;(load "~/Dropbox/emacs/colors.el")
;Load all the latex and auctex stuff, easily commentoutable for other computers
(load "~/Dropbox/emacs/latex.el")
;Make emacs docview auto refresh changes to file.
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

;Docview as default viewer

;Flyspell and linewrap
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(add-hook 'text-mode-hook (lambda () (flyspell-mode 1)))

(add-hook 'tex-mode-hook 'turn-on-visual-line-mode)
(add-hook 'tex-mode-hook (lambda () (flyspell-mode 1)))
 (add-hook 'LaTeX-mode-hook 'visual-line-mode)
 (add-hook 'LaTeX-mode-hook 'flyspell-mode)
 (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

;Autocomplete and smartcompile
(require 'auto-complete-clang)
(global-auto-complete-mode 1)


(require 'smart-compile)
(add-to-list 'smart-compile-alist '("\\.cpp$" . "g++ -O2 -Wall -o %n %f"))

;Was below auctex stuff
(require 'xml)






(require 'ido)
(ido-mode t)
;Ido ubiq stuff

(defvar ido-cur-item nil)
(defvar ido-default-item nil)
(defvar ido-cur-list nil)
(ido-ubiquitous-mode 1)

;Change cursor color
   ;;(require 'cursor-chg)  ; Load the library

   ;;(change-cursor-mode 1) ; Turn on change for overwrite, read-only, and input mode





;save macro
 (defun save-macro (name)
    "save a macro. Take a name as argument
     and save the last defined macro under
     this name at the end of your .emacs"
     (interactive "SName of the macro :")  ; ask for the name of the macro
     (kmacro-name-last-macro name)         ; use this name for the macro
     (find-file user-init-file)            ; open ~/.emacs or other user init file
     (goto-char (point-max))               ; go to the end of the .emacs
     (newline)                             ; insert a newline
     (insert-kbd-macro name)               ; copy the macro
     (newline)                             ; insert a newline
     (switch-to-buffer nil))               ; return to the initial buffer












;; C code following this guide http://truongtx.me/2013/03/10/emacs-setting-up-perfect-environment-for-cc-programming/
(require 'cc-mode)

(define-key c++-mode-map (kbd "C-c C-c") 'smart-compile)

;; (setq-default c-basic-offset 4 c-default-style "linux")
;; (setq-default tab-width 4 indent-tabs-mode t)
;;C indenting
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
	 (column (c-langelem-2nd-pos c-syntactic-element))
	 (offset (- (1+ column) anchor))
	 (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
          (lambda ()
            (let ((filename (buffer-file-name)))
              ;; Enable kernel mode for the appropriate files
              (when (and filename
                         (string-match (expand-file-name "~/src/linux-trees")
                                       filename))
                (setq indent-tabs-mode t)
                (c-set-style "linux-tabs-only")))))

(add-hook 'c++-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))

(add-hook 'c++-mode-hook
          (lambda ()
            (let ((filename (buffer-file-name)))
              ;; Enable kernel mode for the appropriate files
              (when (and filename
                         (string-match (expand-file-name "~/src/linux-trees")
                                       filename))
                (setq indent-tabs-mode t)
                (c-set-style "linux-tabs-only")))))
(setq c-default-style "linux")
(setq c++-default-style "linux")
;;4 space indent, remove when done with project.
(setq-default c-basic-offset 4)

(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
;Auto completels parens and some other limiters
(require 'autopair)
(autopair-global-mode -1)
(setq autopair-autowrap t)
(load-library "paren")
;(require 'auto-complete-clang)
;(define-key c++-mode-map (kbd "C-S-<return>") 'ac-complete-clang)
;; replace C-S-<return> with a key binding that you want

;(require 'flymake)
;;check-syntax:
;;     gcc -o nul -S ${CHK_SOURCES}
;;Add above two lines to make file to enable flycheck
(require 'member-function)
(add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++11")))
(setq mf--source-file-extension "cpp")
;; CPP std add
;;Gcc sense
(require 'gccsense)



;;Import slime stuff

;(load "~/Dropbox/emacs/slime.el")


;;Kill buffer in evil with ,q
(define-key evil-normal-state-map ",q" 'kill-buffer) ; quit (current buffer; have to press RETURN)



;;Set org default directory
(setq org-directory "~/Dropbox")




;; Pretty parenthesis, usefull for Elisp, Clojure, Scheme, etc.
(require 'rainbow-delimiters)
(rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;(global-rainbow-delimiters-mode)


;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; Toggles between a dark theme and a light theme.
(defun toggle-bg ()
  "Toggles from dark to light background (and vice-versa)"
  (interactive)
  (if (eq (frame-parameter (next-frame) 'background-mode) 'dark)
      (progn
        (set-background-color "white")
        (set-foreground-color "black"))
        ;;(disable-theme 'zenburn)
        ;;(load-theme 'solarized-light t))
    (set-background-color "black")
    (set-foreground-color "grey90")))
;;    (disable-theme 'solarized-light)
;;    (load-theme 'zenburn t)))

;; Bind it to F5
(global-set-key (kbd "<f5>") 'toggle-bg)

;Line numbering stuff

;;Enable line numbers
;(require 'nlinum)


;Load linum
(require 'linum-relative)
(add-hook 'find-file-hook (lambda () (linum-mode 1)))
;;Turn relative linum on or off with f8 and enable linum mode

;(global-set-key (kbd "<f8>") 'nlinum-mode)
(global-set-key (kbd "<f8>") 'linum-relative-toggle)

;(global-set-key (kbd "<f8>") 'linum-mode)

;(global-set-key (kbd "<f9>") 'nlinum-mode)

;Load common lisp
(require 'cl)



;Examples for basic functions
;; insert string at current cursor position
;;(insert "i ♥ u")

;; insert part of a buffer
;;(insert-buffer-substring-no-properties myBuffer myStartPos myEndPos)

;; insert a file's content
;;(insert-file-contents myPath)




;Valgrind capabilities
;;(defun valgrind ()
;;(interactive)
;;(compilation-minor-mode)
;;(define-key compilation-minor-mode-map (kbd "")'comint-send-input)
;;(define-key compilation-minor-mode-map (kbd "S-")'compile-goto-error))

;;(add-hook 'shell-mode-hook 'valgrind)
;Above causes problems with shell mode, so use below toggle instead to manually turn it on and off.
;; Toggles between a dark theme and a light theme.
;; Bind it to F5
(global-set-key (kbd "<f6>") 'compilation-minor-mode)



;Make f7 toggle between shells, C-u f7 to make a new shell.
 (global-set-key [f7] 'alt-shell-dwim)

 (defun alt-shell-dwim (arg)
   "Run an inferior shell like `shell'. If an inferior shell as its I/O
 through the current buffer, then pop the next buffer in `buffer-list'
 whose name is generated from the string \"*shell*\". When called with
 an argument, start a new inferior shell whose I/O will go to a buffer
 named after the string \"*shell*\" using `generate-new-buffer-name'."
   (interactive "P")
   (let* ((shell-buffer-list
 	  (let (blist)
	     (dolist (buff (buffer-list) blist)
	       (when (string-match "^\\*shell\\*" (buffer-name buff))
	 	(setq blist (cons buff blist))))))
	  (name (if arg
	 	   (generate-new-buffer-name "*shell*")
	 	 (car shell-buffer-list))))
     (shell name)))

;Require windmove
(require 'windmove)
(windmove-default-keybindings 'shift)
;Golden Ratio stuff
(require 'golden-ratio)

;(golden-ratio-mode 1)

 (global-set-key [f9] 'golden-ratio-mode)



;Browse Kill ring
;(setq debug-on-error t)
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)
(global-set-key "\C-cy" 'browse-kill-ring)

;Ace jump stuff
(add-to-list 'load-path "which-folder-ace-jump-mode-file-in/")
    (require 'ace-jump-mode)
;    (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
     (define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)

;; Smex bindings
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;Yasnippet
(require 'yasnippet)
(yas-global-mode 1)


;;Power Line
 (add-to-list 'load-path "~/.emacs.d/powerline/")
 (require 'powerline)
(powerline-evil-theme)

;;Magit Stuff
(require 'magit)

;; Hippy expanson
(global-set-key (kbd "M-\\") 'hippie-expand)


;; Hide-show mode
(load-library "hideshow")
(define-key evil-normal-state-map (kbd "zf") 'hs-toggle-hiding)
(define-key evil-normal-state-map (kbd "zR") 'hs-hide-all)
;(define-key evil-normal-state-map (kbd "zr") 'hs-hide-block)
(define-key evil-normal-state-map (kbd "zM") 'hs-show-all)
;(define-key evil-normal-state-map (kbd "zm") 'hs-toggle-hiding)


(add-hook 'cpp 'hs-minor-mode)
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)

    ;; zm to unfold
    ;; zr to fold
    ;; zM to unfold all
    ;; zR to fold all
    ;; zt to toggle


;;Subliminity stuff
;;(require 'sublimity)
 (require 'sublimity-scroll)
;; (require 'sublimity-map)
;; (require 'sublimity-attractive)
(setq sublimity-scroll-weight 2
      sublimity-scroll-drift-length 1)

(sublimity-mode 1)

;;Ace-window mode
(require 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(global-set-key (kbd "C-x p") 'ace-window)
;;Emacs tags for code navigation
;http://www.coverfire.com/archives/2004/06/24/emacs-source-code-navigation/
  (defun create-tags (dir-name)
    "Create tags file."
    (interactive "DDirectory: ")
    (shell-command
     (format "ctags -f %s -e -R %s" path-to-ctags (directory-file-name dir-name)))
  )
  (defadvice find-tag (around refresh-etags activate)
   "Rerun etags and reload tags if tag not found and redo find-tag.
   If buffer is modified, ask about save before running etags."
  (let ((extension (file-name-extension (buffer-file-name))))
    (condition-case err
    ad-do-it
      (error (and (buffer-modified-p)
          (not (ding))
          (y-or-n-p "Buffer is modified, save it? ")
          (save-buffer))
         (er-refresh-etags extension)
         ad-do-it))))

  (defun er-refresh-etags (&optional extension)
  "Run etags on all peer files in current dir and reload them silently."
  (interactive)
  (shell-command (format "etags *.%s" (or extension "el")))
  (let ((tags-revert-without-query t))  ; don't query, revert silently
    (visit-tags-table default-directory nil)))
;;Tramp
 (setq tramp-default-method "ssh")
;;Rename current buffer
 (defun delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

(global-set-key (kbd "C-x C-r") 'rename-current-buffer-file)

;;Git fringe
;; (require 'git-gutter-fringe)
;; (setq git-gutter-fr:side 'right-fringe)
;; ;;https://github.com/syohex/emacs-git-gutter-fringe

;;Emacs backups
(setq backup-directory-alist '((".*" . "~/.emacs-autosave/"))
     backup-by-copying t
     delete-old-versions t
     kept-new-versions 6
     kept-old-versions 2
     version-control 1)
;;Eshell fuckery

;;  (global-set-key [f7] 'eshell-to-buffer)
;; ;;; Kills current eshell, start new one in buffer
;; (defun eshell-to-buffer nil
;;   (interactive)
;;   (when (get-buffer "*eshell*")
;;     (kill-buffer "*eshell*"))
;;   (eshell))

;;; Switches the eshell to buffer directory with a cd command, and goes to that eshell. Doesn't work with spaces, would need regex or something
;; (defun eshell-remote-cd (target)
;;   (switch-to-buffer-other-window "*eshell*")
;;   (end-of-buffer)
;;   (eshell-kill-input)
;;   (insert (concat "cd " target))
;;   (eshell-send-input))

;; (defun eshell-to-buffer nil
;;   (interactive)
;;   (when (get-buffer "*eshell*")
;;     (eshell-remote-cd
;;      (or (buffer-file-name)
;;          default-directory)))
;;   (eshell))



;;Fly check

;Winner mode

;(winner-mode)
;gcc sense
;;REquires some other packages that must be compiled from source, will do somepoint
;; http://cx4a.org/software/gccsense/manual.html
;(require 'gccsense)


;; (defun goto-match-paren (arg)
;;   "Go to the matching parenthesis if on parenthesis, otherwise insert %.
;; vi style of % jumping to matching brace."
;;   (interactive "p")
;;   (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;;         ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;;         (t (self-insert-command (or arg 1)))))

;; (defun goto-match-paren (arg)
;; 	;(modify-syntax-entry ?< \"(>\" )
;;    	;(modify-syntax-entry ?> \")<\" )
;;  (interactive "p")
;;      (let
;;          ((syntax (char-syntax (following-char))))
;;      (cond
;;       ((= syntax ?\()
;;        (forward-sexp 1) (backward-char))
;;       ((= syntax ?\))
;;        (forward-char) (backward-sexp 1))
;;       (t (message "No match"))
;;       )
;;      ))
;; ; { test }



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-list (quote (("" "Name = Evince Command evince --page-index=%(outpage)"))))
 '(TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi") (output-pdf "Evince") (output-html "xdg-open"))))
 '(global-flycheck-mode t nil (flycheck))
 '(org-babel-load-languages (quote ((java . t) (emacs-lisp . t) (C . t) (plantuml . t))))
 '(org-plantuml-jar-path "~/.emacs.d/plantuml.jar")
 '(quack-programs (quote ("scheme58" "bigloo" "csi" "csi -hygienic" "gosh" "gracket" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "mzscheme" "racket" "racket -il typed/racket" "rs" "scheme" "scheme48" "scsh" "sisc" "stklos" "sxi")))
 '(scheme-program-name "scheme48")
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(user-full-name "Matthew Bregg"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



(fset 'stdifier
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([98 105 115 116 100 58 58 escape 119 119] 0 "%d")) arg)))
