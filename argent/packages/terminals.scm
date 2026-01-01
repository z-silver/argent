(define-module (argent packages terminals)
  #:use-module (gnu packages terminals)
  #:use-module (guix gexp)
  #:use-module (guix download)
  #:use-module (guix packages)
  #:use-module ((guix licenses)
                #:prefix license:))

(define-public sakura-argent
  (package
    (inherit sakura)
    (name "sakura-argent")
    (source
     (origin
       (inherit (package-source sakura))
       (patches (list (local-file "../patches/sakura-argent.patch")))))))
