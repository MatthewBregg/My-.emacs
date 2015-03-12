
;; allow for export=>beamer by placing

;; #+latex_class: beamer in org files
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
      \\usepackage[t1]{fontenc}\n
      \\usepackage{hyperref}\n
      \\usepackage{color}
      \\usepackage{listings}
      \\lstset{numbers=none,language=[iso]c++,tabsize=4,
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


(require 'tex-site)
(setq TeX-auto-save t)
(setq TeX-parse-self t)


 ;;(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook
      (lambda()
        (local-set-key [C-tab] 'TeX-complete-symbol)))




;; Enable RefTeX
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(setq reftex-plug-into-AUCTeX t)
 (setq TeX-PDF-mode t)
;;(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode

;Four latex macros
;;Macro to insert highlight and red text in latex
(fset 'latex-red-text
   [?\\ ?c ?o ?l ?o ?r ?\{ ?r ?e ?d ?\} ?  ?  ?\{ backspace ?\\ ?c ?o ?l ?o ?r ?\{ ?b ?l ?a ?c ?k ?\}])


;;Macro for latex list
(fset 'latex-list
   [?\\ ?b ?e ?g ?i ?n ?\{ ?l ?i ?s ?t ?\} ?\{ ?\} backspace ?* ?\} ?\{ ?\} return ?\\ ?i ?t ?e ?m return ?\\ ?e ?n ?d ?\{ ?l ?i ?s ?t ?\} return])



;latex mla function
(defun latexmla ()
"Insert latexmlastyle at cursor point."
(interactive)
(insert-file-contents "~/Dropbox/College/latex/MLA.tex")
 )


;Latex italics macro
(fset 'latexitalics
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([123 92 116 101 120 116 105 116 32 125 escape 105] 0 "%d")) arg)))

(add-hook 'LaTeX-mode-hook
          (lambda () (local-set-key (kbd "C-x i") 'latexitalics)))

