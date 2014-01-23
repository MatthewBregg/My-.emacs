;Load path
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3.1")
;;Enable line numbers
(global-linum-mode 1)

;Background
(set-background-color "white")
; Disable the splash screen
(setq inhibit-splash-screen t)
;; Set window title to be full file path
(setq frame-title-format '("Emacs @ " system-name ": %b %+%+ %f"))
; Add marmalade repo 
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
; sheme enviroment
(require 'quack)
;Org mode stuff
(require 'org-install)
(setq org-startup-indented t)
;;(setq org-hide-leading-stars t)
(setq org-src-fontify-natively t)
(setq org-odd-level-only nil) 
;Emacs customizations 
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
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
;Evil
(require 'evil)
    (evil-mode 1)
(setq evil-default-cursor t)

;;Exit insert mode by pressing j and then j quickly
(require 'key-chord)

(setq key-chord-two-keys-delay 0.8)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)
;Set colors based on mode
                            
(load "~/Dropbox/emacs/colors.el")

;Auctex stuff
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(require 'tex-site)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
 (setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook
      (lambda()
        (local-set-key [C-tab] 'TeX-complete-symbol)))



;Flyspell and linewrap
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(add-hook 'text-mode-hook (lambda () (flyspell-mode 1)))

(add-hook 'tex-mode-hook 'turn-on-visual-line-mode)
(add-hook 'tex-mode-hook (lambda () (flyspell-mode 1)))
 (add-hook 'LaTeX-mode-hook 'visual-line-mode)
 (add-hook 'LaTeX-mode-hook 'flyspell-mode)
 (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

;Autocomplete and smartcompile
(require 'auto-complete)
 	

(require 'smart-compile)
(add-to-list 'smart-compile-alist '("\\.cpp$" . "g++ -O2 -Wall -o %n %f")) 



;; Enable RefTeX
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(setq reftex-plug-into-AUCTeX t)
 (setq TeX-PDF-mode t)
;;(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode



(require 'xml)



;;Macros
;;Macro to insert highlight and red text in latex
(fset 'latex-red-text
   [?\\ ?c ?o ?l ?o ?r ?\{ ?r ?e ?d ?\} ?  ?  ?\{ backspace ?\\ ?c ?o ?l ?o ?r ?\{ ?b ?l ?a ?c ?k ?\}])


;;Macro for latex list
(fset 'latex-list
   [?\\ ?b ?e ?g ?i ?n ?\{ ?l ?i ?s ?t ?\} ?\{ ?\} backspace ?* ?\} ?\{ ?\} return ?\\ ?i ?t ?e ?m return ?\\ ?e ?n ?d ?\{ ?l ?i ?s ?t ?\} return])




(require 'ido)
(ido-mode t)

;Change cursor color
   ;;(require 'cursor-chg)  ; Load the library
   
   ;;(change-cursor-mode 1) ; Turn on change for overwrite, read-only, and input mode


;; allow for export=>beamer by placing

;; #+LaTeX_CLASS: beamer in org files
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
  ;; beamer class, for presentations
 '("beamer"
     "\\documentclass[11pt]{beamer}\n
      \\mode<{{{beamermode}}}>\n
      \\usetheme{{{{beamertheme}}}}\n
      \\usecolortheme{{{{beamercolortheme}}}}\n
      \\beamertemplateballitem\n
      \\setbeameroption{show notes}
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{hyperref}\n
      \\usepackage{color}
      \\usepackage{listings}
      \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
  frame=single,
  basicstyle=\\small,
  showspaces=false,showstringspaces=false,
  showtabs=false,
  keywordstyle=\\color{blue}\\bfseries,
  commentstyle=\\color{red},
  }\n
      \\usepackage{verbatim}\n
      \\institute{{{{beamerinstitute}}}}\n          
       \\subject{{{{beamersubject}}}}\n"

     ("\\section{%s}" . "\\section*{%s}")
     
     ("\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}"
       "\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}")))

  ;; letter class, for formal letters

 (add-to-list 'org-export-latex-classes

  '("letter"
     "\\documentclass[11pt]{letter}\n
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{color}"
     
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))





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







;latex mla function
(defun latexmla ()
"Insert latexmlastyle at cursor point."
(interactive)
(insert-file-contents "~/Dropbox/College\  Freshmen/latex/MLA.tex")
 )





;; Lisp - Slime

(eval-after-load "slime"
  '(progn
     (setq slime-lisp-implementations
           '((sbcl ("/usr/bin/sbcl"))
             (ecl ("/usr/bin/ecl"))
             (clisp ("/usr/bin/clisp"))))
     (slime-setup '(
                    slime-asdf
                    slime-autodoc
                    slime-editing-commands
                    slime-fancy-inspector
                    slime-fontifying-fu
                    slime-fuzzy
                    slime-indentation
                    slime-mdot-fu
                    slime-package-fu
                    slime-references
                    slime-repl
                    slime-sbcl-exts
                    slime-scratch
                    slime-xref-browser
                    ))
     (slime-autodoc-mode)
     (setq slime-complete-symbol*-fancy t)
     (setq slime-complete-symbol-function
  'slime-fuzzy-complete-symbol)))

(require 'slime)
(add-hook 'slime-repl-mode-hook
          #'(lambda () 
              (setq autopair-dont-activate t)))




;; C code following this guide http://truongtx.me/2013/03/10/emacs-setting-up-perfect-environment-for-cc-programming/
(require 'cc-mode)



(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
(require 'autopair)
(autopair-global-mode -1)
(setq autopair-autowrap t)
(load-library "paren")
(require 'auto-complete-clang)
(define-key c++-mode-map (kbd "C-S-<return>") 'ac-complete-clang)
;; replace C-S-<return> with a key binding that you want

(require 'flymake)
;;check-syntax:
;;     gcc -o nul -S ${CHK_SOURCES}
;;Add above two lines to make file to enable flycheck
(require 'member-function)
(setq mf--source-file-extension "cpp")

;Latex italics macro
(fset 'latexitalics
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([123 92 116 101 120 116 105 116 32 125 escape 105] 0 "%d")) arg)))

(add-hook 'LaTeX-mode-hook
          (lambda () (local-set-key (kbd "C-x i") 'latexitalics)))




;;Kill buffer in evil with ,q
(define-key evil-normal-state-map ",q" 'kill-buffer) ; quit (current buffer; have to press RETURN)



;;Set org default directory
(setq org-directory "~/Dropbox")




;; Pretty parenthesis, usefull for Elisp, Clojure, Scheme, etc.
(rainbow-delimiters-mode)
(global-rainbow-delimiters-mode)


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



(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert %.
vi style of % jumping to matching brace."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-list (quote (("" "Name = Evince Command evince --page-index=%(outpage)"))))
 '(TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi") (output-pdf "Evince") (output-html "xdg-open"))))
 '(org-babel-load-languages (quote ((java . t) (emacs-lisp . t) (C . t))))
 '(quack-programs (quote ("mzscheme" "bigloo" "csi" "csi -hygienic" "gosh" "gracket" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "racket" "racket -il typed/racket" "rs" "scheme" "scheme48" "scsh" "sisc" "stklos" "sxi")))
 '(scheme-program-name "scheme48")
 '(user-full-name "Matthew Bregg"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

