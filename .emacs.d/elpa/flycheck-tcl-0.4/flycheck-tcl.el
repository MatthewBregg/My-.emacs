;;; flycheck-tcl.el --- A flycheck checker for Tcl using ActiveState's tclchecker

;; Copyright 2014 Niels Widger
;;
;; Author: Niels Widger
;; Version: 0.4
;; Package-Requires: ((flycheck "0.17"))

;;; Commentary:

;; Add a Tcl checker to Flycheck using ActiveState's tclchecker.

;;; Code:

(require 'flycheck)

(flycheck-def-option-var flycheck-tcl-tclchecker-use-packages nil tcl-tclchecker
  "A list of specific Tcl packages to check with `-use'.

The value of this variable is a list of strings, where each
string is a package name with an optional version number attached such as `Tcl' or `Tcl8.6'."
  :type '(repeat (string :tag "Package name (optionally with version)"))
  :safe #'flycheck-string-list-p
  :package-version '(flycheck . "0.17"))

(flycheck-define-checker tcl-tclchecker
  "A Tcl checker using ActiveState's tclchecker."
  :command ("tclchecker" "-quiet" "-W2" (option-list "-use" flycheck-tcl-tclchecker-use-packages) source)
  :error-patterns
  ((warning line-start (file-name) ":" line " (warn" (one-or-more (any alpha)) ") " (message) line-end)
   (error line-start (file-name) ":" line " (" (one-or-more (any alpha)) ") " (message) line-end))
  :modes tcl-mode)

(add-to-list 'flycheck-checkers 'tcl-tclchecker)

(provide 'flycheck-tcl)

;;; flycheck-tcl.el ends here
