
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

