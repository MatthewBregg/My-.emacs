;Load path
(add-to-list 'load-path "~/.emacs.d/lisp")

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
;eclim
(require 'eclim)
(global-eclim-mode)
(require 'eclimd)
(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)
;; regular auto-complete initialization
;(require 'auto-complete-config)
;(ac-config-default)

;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)

;;Handle font scale

;;Turn off auto-resize plugin when on laptop
(when (not (string= system-name "localhost.localdomain"))
  (require 'auto-resize))



;Org mode stuff
(require 'org-install)
(setq org-startup-indented t)
;;(setq org-hide-leading-stars t)
(setq org-src-fontify-natively t)
(setq org-odd-level-only nil)

;; ;Smartparens
;; (require 'smartparens-config)
;; (smartparens-global-mode t)

;;Facebook chat ;;Jabber.el was broken
;;(require 'jabber-autoloads)
;; (setq jabber-account-list '(
;;                             ("matthew.bregg.1@chat.facebook.com"
;;                              (:network-server . "chat.facebook.com")
;;                              (:connection-type . starttls)
;;                              (:port . 5222)

;;                              )
;;                             ))


;; Disable jabber.el presence notifications
;; (remove-hook 'jabber-alert-presence-hooks
;;              'sr-jabber-alert-presence-func)
;; Connect to all my jabber.el accounts on startup
;(jabber-connect-all)

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
(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map
  (read-kbd-macro evil-toggle-key) 'evil-normal-state)
(define-key evil-insert-state-map [escape] 'evil-normal-state)
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
 (setq key-chord-two-keys-delay 0.6)
;;(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
;;;;; Remove jj as a modifier to enter normal state,
;;;;; as I am now using capslock -> esc instead.
;;;;; The jj mapping is annoying.
 (key-chord-define evil-normal-state-map "sf" 'imenu)
 (key-chord-define evil-normal-state-map "zz" 'narrow-or-widen-dwim)
;;Visual and Normal mode
 (key-chord-define evil-normal-state-map "gp" 'evilmi-jump-items)
(key-chord-define evil-normal-state-map "ss" 'ace-window)
(key-chord-define evil-normal-state-map "  " 'ido-switch-buffer)

(key-chord-define evil-motion-state-map "ss" 'ace-window)
(key-chord-define evil-motion-state-map "  " 'ido-switch-buffer)

;; Enable modifying the width of a window in all three evil states.
(define-key evil-emacs-state-map (kbd "C->") 'evil-window-increase-width)
(define-key evil-emacs-state-map (kbd "C-<") 'evil-window-decrease-width)
(define-key evil-normal-state-map (kbd "C->") 'evil-window-increase-width)
(define-key evil-normal-state-map (kbd "C-<") 'evil-window-decrease-width)
(define-key evil-insert-state-map (kbd "C->") 'evil-window-increase-width)
(define-key evil-insert-state-map (kbd "C-<") 'evil-window-decrease-width)
(define-key evil-visual-state-map (kbd "C->") 'evil-window-increase-width)
(define-key evil-visual-state-map (kbd "C-<") 'evil-window-decrease-width)


(define-key evil-normal-state-map  (kbd "gl") 'goto-line)
(define-key evil-normal-state-map (kbd "esc") 'electric-buffer-list)
(define-key evil-normal-state-map (kbd "gd") 'ggtags-find-tag-evil)
  (defun ggtags-find-tag-evil()
    (interactive)
    (call-interactively 'ggtags-find-tag-dwim)
  )
(defun ggtags-create-and-update()
  (interactive)
  (call-interactively 'ggtags-create-tags)
  (call-interactively 'ggtags-update-tags))


;;Paren-completer stuff
(require 'paren-completer)
(key-chord-define evil-normal-state-map (kbd "mP")
		  '(lambda ()
		     (interactive)
		     (paren-completer-add-all-delimiters-with-newline)
		     (forward-char)))
(key-chord-define evil-normal-state-map (kbd "mp")
		  '(lambda ()
	     (interactive)
	     (if (not
		  (eq (paren-completer-add-single-delimiter) 0))
		 (insert-char 10)
	       (cond ((derived-mode-p 'sgml-mode) (sgml-close-tag) (insert-char 10))
		     ((derived-mode-p 'nxml-mode) (nxml-finish-element) (insert-char 10)))
	       )
	     (forward-char)))
		     

(global-set-key (kbd "C-x <SPC>") 'ido-switch-buffer)
(define-key evil-normal-state-map (kbd "gb") 'pop-tag-mark)
(key-chord-define evil-visual-state-map "gp" 'evilmi-jump-items)
(define-key evil-visual-state-map (kbd "gl") 'goto-line)
(define-key evil-visual-state-map (kbd "esc") 'electric-buffer-list)
(global-set-key (kbd "<M-backspace>") 'my-backward-delete-word)
(define-key evil-normal-state-map (kbd "<C-tab>") 'ff-find-other-file)
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
  (setq magit-last-seen-setup-instructions "1.4.0")

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
(define-key evil-visual-state-map (kbd "<tab>") 'indent-region)
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
(add-hook 'org-mode-hook (lambda () (flyspell-mode 1)))

;; this is how I did spell checking in programming buffers.
;; OVerall I am deciding against it, for now. Might turn it back on later, but need a way to eliminate more falsepostiives.
;; Maybe only run on words > 8, so stuff like i, iter, and such don't get caught? chars?
;; Also find a way to get it to only run on variable definations!!
;; So perhaps startb y only running in C++ mode, and go from there....
;; Good project to come back to one day!
;;(add-hook 'text-mode-hook (lambda () (flyspell-mode 1)))

(add-hook 'tex-mode-hook 'turn-on-visual-line-mode)
(add-hook 'tex-mode-hook (lambda () (flyspell-mode 1)))
 (add-hook 'LaTeX-mode-hook 'visual-line-mode)
 (add-hook 'LaTeX-mode-hook 'flyspell-mode)
 (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

;Autocomplete and smartcompile
;(require 'auto-complete-clang)
;(global-auto-complete-mode 1)


(require 'smart-compile)
(add-to-list 'smart-compile-alist '("\\.cpp$" . "g++ -O2 -Wall -o %n %f -std=gnu++11"))

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
;;Semantic Stuff
(require 'srefactor)
(define-key c-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
(define-key c++-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
;;Load tags in, and rename all functions
(defun semantic-rename-symbol (name)
  (interactive (list (read-string "Enter new name: ")) )
  (create-gtags-in-current-dir)
  (semantic-symref)
  (semantic-symref-list-expand-all)
  (semantic-symref-list-rename-open-hits name)
  (kill-buffer)
  )



(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
;;Semantic function def

(semantic-mode 1)
;(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
(setq-default semantic-symref-tool 'global)
(semanticdb-enable-gnu-global-databases 'c-mode t)
(semanticdb-enable-gnu-global-databases 'c++-mode t)
;;(when (cedet-gnu-global-version-check t) ;Do stuff if gnu global is available

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
(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))
(require 'flycheck-pos-tip)
(eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))
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

;;Load theme stuff
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-material-theme")
(load-theme 'material-light t)


;; Toggles between a dark theme and a light theme.
(defun toggle-bg ()
  "Toggles from dark to light background (and vice-versa)"
  (interactive)
  (if (eq (frame-parameter (next-frame) 'background-mode) 'dark)
      (progn
	(load-theme 'material-light t))
    (load-theme 'material t)))

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
 ;(global-set-key [f7] 'eshell)

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
;; Make java handle annotations correctly
(add-hook 'java-mode-hook
              (lambda ()
                "Treat Java 1.5 @-style annotations as comments."
                (setq c-comment-start-regexp "(@|/(/|[*][*]?))")
                (modify-syntax-entry ?@ "< b" java-mode-syntax-table)))

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
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))
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

(defun create-gtags-in-current-dir()
;(start-process "tagging" "*Messages*" "gtags" default-directory)
(shell-command  "gtags" default-directory)
  )
(defun refactor-simple-rename (name)
  (interactive (list (read-string "Enter new name: ")) )
  (narrow-to-defun)
  (let ((old (thing-at-point 'symbol)))
  (beginning-of-buffer)
  (replace-string  old name)
  (widen)
  ))


;;Narrower
(defun narrow-or-widen-dwim (p)
  "If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
Intelligently means: region, subtree, or defun, whichever applies
first.

With prefix P, don't widen, just narrow even if buffer is already
narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((derived-mode-p 'org-mode) (org-narrow-to-subtree))
        (t (narrow-to-defun))))


;;Whitespace managers
(setq dtrt-indent-verbosity 0)
(add-hook 'c-mode-common-hook 'ws-butler-mode)
(add-hook 'java-mode-common-hook 'ws-butler-mode)
(add-hook 'c++-mode-common-hook 'ws-butler-mode)
(dtrt-indent-mode 1)
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

(dolist (hook '(prog-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
;;The following code is from
;; http://blog.binchen.org/posts/what-s-the-best-spell-check-set-up-in-emacs.html
;; if (aspell installed) { use aspell}
;; else if (hunspell installed) { use hunspell }
;; whatever spell checker I use, I always use English dictionary
;; I prefer use aspell because:
;; 1. aspell is older
;; 2. looks Kevin Atkinson still get some road map for aspell:
;; @see http://lists.gnu.org/archive/html/aspell-announce/2011-09/msg00000.html

(defun flyspell-detect-ispell-args (&optional RUN-TOGETHER)
  "if RUN-TOGETHER is true, spell check the CamelCase words"
  (let (args)
    (cond
     ((string-match  "aspell$" ispell-program-name)
      ;; force the English dictionary, support Camel Case spelling check (tested with aspell 0.6)
      (setq args (list "--sug-mode=ultra" "--lang=en_US"))
      (if RUN-TOGETHER
          (setq args (append args '("--run-together" "--run-together-limit=5" "--run-together-min=2")))))
     ((string-match "hunspell$" ispell-program-name)
      (setq args nil)))
    args
    ))

(cond
 ((executable-find "aspell")
  (setq ispell-program-name "aspell"))
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  ;; just reset dictionary to the safe one "en_US" for hunspell.
  ;; if we need use different dictionary, we specify it in command line arguments
  (setq ispell-local-dictionary "en_US")
  (setq ispell-local-dictionary-alist
        '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil nil nil utf-8))))
 (t (setq ispell-program-name nil)))

;; ispell-cmd-args is useless, it's the list of *extra* arguments we will append to the ispell process when "ispell-word" is called.
;; ispell-extra-args is the command arguments which will *always* be used when start ispell process
(setq ispell-extra-args (flyspell-detect-ispell-args t))
;; (setq ispell-cmd-args (flyspell-detect-ispell-args))
(defadvice ispell-word (around my-ispell-word activate)
  (let ((old-ispell-extra-args ispell-extra-args))
    (ispell-kill-ispell t)
    (setq ispell-extra-args (flyspell-detect-ispell-args))
    ad-do-it
    (setq ispell-extra-args old-ispell-extra-args)
    (ispell-kill-ispell t)
    ))

(defadvice flyspell-auto-correct-word (around my-flyspell-auto-correct-word activate)
  (let ((old-ispell-extra-args ispell-extra-args))
    (ispell-kill-ispell t)
    ;; use emacs original arguments
    (setq ispell-extra-args (flyspell-detect-ispell-args))
    ad-do-it
    ;; restore our own ispell arguments
    (setq ispell-extra-args old-ispell-extra-args)
    (ispell-kill-ispell t)
    ))


;; Register keybindings
(key-chord-define evil-normal-state-map "mr" 'point-to-register) ;;Make the register
(key-chord-define evil-normal-state-map "gr" 'jump-to-register) ;; Go to the register


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
 '(TeX-view-program-list
   (quote
    (("" "Name = Evince Command evince --page-index=%(outpage)"))))
 '(TeX-view-program-selection
   (quote
    (((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Evince")
     (output-html "xdg-open"))))
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "26614652a4b3515b4bbbb9828d71e206cc249b67c9142c06239ed3418eff95e2" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(eclimd-wait-for-process nil)
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(global-flycheck-mode t nil (flycheck))
 '(org-agenda-files
   (quote
    ("~/Dropbox/College/College Junior Spring/Stat : STA3032/HW/HW 4/HW4.org")))
 '(org-babel-load-languages
   (quote
    ((java . t)
     (emacs-lisp . t)
     (C . t)
     (plantuml . t))))
 '(org-plantuml-jar-path "~/.emacs.d/plantuml.jar")
 '(paren-completer--ignore-stringsp\? nil)
 '(paren-completer-print-message-if-empty nil)
 '(paren-completer-print-message-if-emptyp\? nil)
 '(quack-programs
   (quote
    ("scheme58" "bigloo" "csi" "csi -hygienic" "gosh" "gracket" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "mzscheme" "racket" "racket -il typed/racket" "rs" "scheme" "scheme48" "scsh" "sisc" "stklos" "sxi")))
 '(scheme-program-name "scheme48")
 '(semantic-idle-scheduler-idle-time 5.3)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(user-full-name "Matthew Bregg"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-5-face ((t (:foreground "magenta")))))



(fset 'stdifier
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([98 105 115 116 100 58 58 escape 119 119] 0 "%d")) arg)))



(require 'evil-anzu)
(global-anzu-mode)
;;Power Line
(add-to-list 'load-path "~/.emacs.d/powerline/")
(require 'powerline)
(powerline-evil-theme)

;;Auto-resize - Handle powerline issue
(advice-add 'auto-resize--set-font-height-size :after 'powerline-reset)


;; It's time, to make emacs my window manager!
;;; Begin EXWM config
(require 'exwm)
(require 'exwm-config)
(exwm-config-default)
(exwm-input-set-key (kbd "s-q")
                    (call-interactively #'exwm-input-grab-keyboard))

(exwm-input-set-simulation-keys
 '(([?\C-s] . ?\C-f)))
(add-hook 'exwm-manage-finish-hook
          (lambda ()
            (when (and exwm-class-name
                       (string= exwm-class-name "Gnome-terminal"))
              (exwm-input-set-local-simulation-keys '(([?\C-c ?\C-c] . ?\C-c))))))
(add-hook 'exwm-manage-finish-hook
          (lambda ()
            (when (and exwm-class-name
                       (string= exwm-class-name "Firefox"))
              (exwm-input-set-local-simulation-keys '(([?\C-w] . ?\C-w) ([?\C-s] . ?\C-f) ([?\C-r] . ?\C-g) ([?\C-h] . ?\C-h))))))

;;https://www.reddit.com/r/unixporn/comments/3lp961/exwm_so_emacs_is_now_my_window_manager/
(display-time-mode 1)
;;https://www.reddit.com/r/emacs/comments/5zb7yo/package_of_the_day_exwmx_another_window_manager/
;;https://emacs.stackexchange.com/questions/33326/how-do-i-cut-and-paste-effectively-between-applications-while-using-exwm

(defun fhd/exwm-input-line-mode ()
  "Set exwm window to line-mode and show mode line"
  (call-interactively #'exwm-input-grab-keyboard))

(defun fhd/exwm-input-char-mode ()
  "Set exwm window to char-mode and hide mode line"
  (call-interactively #'exwm-input-release-keyboard))

(defun fhd/exwm-input-toggle-mode ()
  "Toggle between line- and char-mode"
  (interactive)
  (with-current-buffer (window-buffer)
    (when (eq major-mode 'exwm-mode)
      (if (equal (second (second mode-line-process)) "line")
          (fhd/exwm-input-char-mode)
        (fhd/exwm-input-line-mode)))))
(exwm-input-set-key (kbd "s-i") #'fhd/exwm-input-toggle-mode)

;; It makes sense to display the battery indicator in the side bar when using this.
(display-battery-mode 1)

;; EXWM windows start in emacs normal mode
;; Enable redeffing this to change hook behavior without fucking evil.
(defun evil-emacs-mode ()
  (evil-emacs-state)
  )
(add-hook 'exwm-mode-hook 'evil-emacs-mode)

(add-hook 'exwm-workspace-switch-hook 'auto-resize--resize-frame)

(defun start-gnome-screensaver ()
  (start-process-shell-command "gnome-screensaver" nil "gnome-screensaver"))
(add-hook 'exwm-init-hook 'start-gnome-screensaver)

(defun lock-computer()
  (interactive)
  (shell-command "gnome-screensaver-command -l")
  )
(defun suspend-computer()
  (interactive)
  (shell-command "systemctl suspend")
  )

;; Give the normal screen locking command.
(global-set-key "\C-\M-l" 'suspend-computer)

(defun set-screen-brightness(brightness)
  ;; Set the screen brightness, enter a number 0.0-100.0
  ;; Careful setting below .2, will blank screen.
  (interactive "nEnter the number of the desired screen brightness (0-100): ")
  (shell-command
   (concat
    "/usr/sbin/set-brightness "
    (number-to-string (round (* (/ 850.0 100.0) brightness))))
   "*Messages*")
  )
;; Set brightness is a bash script
;; tee /sys/class/backlight/intel_backlight/brightness <<< $1
;; Need to give self write permission to brightness!
;; Should be harmless to let anyone change this!

;; End exwm config. If un exwming, remove this all as one chunk!


(provide '.emacs)
;;; .emacs ends here


(fset 'org-give-hat
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([105 36 92 104 97 116 123 escape 119 97 125 36 escape] 0 "%d")) arg)))


