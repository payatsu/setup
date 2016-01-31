; -*- emacs-lisp -*-

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)
(package-install 'company)
(package-install 'company-c-headers)
(package-install 'company-quickhelp)
(package-install 'company-irony)
(package-install 'irony)
(package-install 'yasnippet)
(package-install 'flycheck)
(package-install 'ggtags)

;emacs -Q --batch \
;--eval '(require '\''package)' \
;--eval '(add-to-list '\''package-archives '\''("melpa" . "https://melpa.org/packages/"))' \
;--eval '(package-initialize)' \
;--eval '(package-refresh-contents)' \
;--eval '(package-install '\''ggtags)' \
;--eval '(package-install '\''company)' \
;--eval '(package-install '\''company-quickhelp)' \
;--eval '(package-install '\''yasnippet)' \
;--eval '(package-install '\''irony)' \
;--eval '(package-install '\''flycheck)'
