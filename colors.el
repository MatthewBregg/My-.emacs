;;(require 'lexbind-mode) (add-hook 'emacs-lisp-mode-hook 'lexbind-mode)
(eval-when-compile (require 'cl))
(lexical-let ((default-color (cons (face-background 'mode-line)
                                   (face-foreground 'mode-line))))
  (add-hook 'post-command-hook
    (lambda ()
      (let ((color (cond ((minibufferp) default-color)
                         ((evil-insert-state-p) '("#3965ae" . "#ffffff"))
                         ((evil-emacs-state-p)  '("#af00d7" . "#ffffff"))
                         ((buffer-modified-p)   '("#ab0e4c" . "#ffffff"))
                         (t default-color))))
        (set-face-background 'mode-line (car color))
        (set-face-foreground 'mode-line (cdr color))
		
		))))

      
 
;(lexical-let ((default-color (cons (face-background 'mode-line)
;                                   (face-foreground 'mode-line))))
;  (add-hook 'post-command-hook
;    (lambda ()
;      (let ((color (cond ((minibufferp) default-color)
;                         ((evil-insert-state-p) '("#3965ae" . "#ffffff"))
;                         ((evil-emacs-state-p)  '("#ffffff" . "#ffffff"))
;                         ((buffer-modified-p)   '("#ab0e4c" . "#ffffff"))
;                         (t '("#ffffff")))))
;  
;		(set-cursor-color (car color))
;		))))

    
