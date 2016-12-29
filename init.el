;; REQUIREMENTS
;; - set an enviroment variable $PATSHOME
;; - put ats-mode.el & ats2-flycheck.el into your elisp dir
;; - install smart-compile & flycheck

(setenv "PATSHOME" (getenv "PATSHOME"))


(require 'ats-mode)
(setq auto-mode-alist
      (append '(("\\.dats$" . ats-mode))
              auto-mode-alist))

(add-hook 'ats-mode-hook
          '(lambda ()
             (require 'smart-compile)
             (setq smart-compile-alist
                   (append smart-compile-alist
                           '(("\\.dats$" .
                              "patscc %f -o %n -DATS_MEMALLOC_LIBC && ./%n"))))

             (require 'ats2-flycheck)
             (with-eval-after-load 'flycheck
               (flycheck-ats2-setup))
             (require 'flycheck)
             (flycheck-mode)))
