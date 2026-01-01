(define-module (argent packages xdisorg)
  #:use-module (gnu packages image)
  #:use-module (gnu packages xorg)
  #:use-module (guix build-system gnu)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix utils)
  #:use-module ((guix licenses)
                #:prefix license:))

(define-public quadro
  (let ((commit "c31f10a5dfa4f3e2858fadc90b75c3f5f4e4b0a6")
        (revision "0"))
    (package
      (name "quadro")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/thalting/quadro")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0i7r3hisvxw0xq8zma5jigryhwxn4pc1vxmdm5g4rvk68hmav5kx"))))
      (build-system gnu-build-system)
      (inputs (list libx11 libpng))
      (arguments
       `(#:tests? #f
         #:make-flags (list (string-append "CC="
                                           ,(cc-for-target))
                            (string-append "PREFIX=" %output))
         #:phases (modify-phases %standard-phases
                    (delete 'configure))))
      (home-page "https://github.com/thalting/quadro")
      (synopsis "Screenshot tool for X11")
      (description "A suckless-style screenshot tool for X11.")
      (license license:unlicense))))
