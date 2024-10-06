(define-module (argent packages idris)
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages chez)
  #:use-module (gnu packages idris)
  #:use-module (gnu packages multiprecision)
  #:use-module (ice-9 optargs))

(define-public idris2-boot
  (let ((commit "0fb1192cd30ec4747cbc727f26ddbfad515d1363")
        (revision "1"))
    (package
      (name "idris2-boot")
      (version (git-version "0.1.1" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/edwinb/Idris2-boot")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1f0b2mb7xahc4mrhbw8vp5b6iv3ci1z7yz7h12i8mnmy3nddpsfn"))))
      (build-system gnu-build-system)
      (native-inputs (list idris))
      (inputs (list chez-scheme mpc bash-minimal))
      (arguments
       (list
        #:test-target "test"
        ;; Tests fail to compile with the following error:
        ;; cc: rawSystem: posix_spawnp: does not exist (No such file or directory)
        #:tests? #f
        #:phases #~(modify-phases %standard-phases
                     (add-after 'patch-source-shebangs 'patch-more-source-shebangs
                       (lambda _
                         (substitute* "src/Compiler/Scheme/Chez.idr"
                           (("^(.*#!)/bin/sh(.*)$" _ prefix suffix)
                            (string-append prefix
                                           #$(file-append bash-minimal "/bin/sh")
                                           suffix)))))
                     (replace 'configure
                       (lambda _
                         (substitute* "config.mk"
                           (("^CC :=.*$")
                            (string-append "CC := "
                                           #$(cc-for-target))))))
                     (add-before 'build 'set-prefix
                       (lambda _
                         (setenv "PREFIX"
                                 #$output)))
                     (replace 'build
                       (lambda _
                         ;; Don't run the tests during the build step.
                         (invoke "make" "idris2boot" "libs" "install-support")))
                     (replace 'install
                       (lambda _
                         (invoke "make" "install-all"))))))
      (home-page "https://github.com/edwinb/Idris2-boot")
      (synopsis "Bootstrapping version of Idris 2, the successor to Idris")
      (description
       "This is the bootstrapping version of Idris 2, the successor
to Idris.  Its sole purpose is to build Idris 2 proper.  Most likely, you will
want to install that directly, unless you're following the bootstrapping path
from scratch.")
      (license license:bsd-3))))

(define* (make-idris2
          #:key version source-hash input-idris2
          (final? #f))
  (package
    (name (if final?
            "idris2"
            "idris2-bootstrap"))
    (version version)
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/idris-lang/Idris2")
              (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256 (base32 source-hash))))
    (build-system gnu-build-system)
    (native-inputs (list chez-scheme input-idris2))
    (inputs (cons* chez-scheme mpc (if final? '() (list bash-minimal))))
    (arguments
      (list
        #:test-target "test"
        #:tests? #f
        #:phases
        #~(modify-phases %standard-phases
            (delete 'bootstrap)
            (replace 'configure
              (lambda _
                (substitute* "Makefile"
                  (("TARGETDIR = build/exec")
                   "TARGETDIR = ${CURDIR}/build/exec")
                  (("^(.*IDRIS2=)\\S*(\\$\\{TARGET\\}.*)$" _ prefix suffix)
                   (string-append prefix suffix)))))
            #$@(if final?
                 '()
                 (list
                   #~(add-after 'patch-source-shebangs 'patch-more-source-shebangs
                       (lambda _
                         (define sh #$(file-append bash-minimal "/bin/sh"))
                         (substitute* "src/Compiler/Scheme/Chez.idr"
                           (("^(.*#!)/bin/sh(.*)$" _ prefix suffix)
                            (string-append prefix sh suffix)))
                         (substitute* "src/Compiler/Scheme/Racket.idr"
                           (("^(.*#!)/bin/sh(.*)$" _ prefix suffix)
                            (string-append prefix sh suffix)))))))
            (add-before 'build 'set-env-vars
              (lambda _
                (define chez-path #$(file-append chez-scheme "/bin/scheme"))
                #$(if (equal? input-idris2 idris2-boot)
                    #~(setenv "IDRIS2_BOOT" "idris2boot")
                    #~(begin))
                (setenv "PREFIX" #$output)
                (setenv "SCHEME" chez-path)
                (setenv "CHEZ" chez-path)
                (setenv "CC" #$(cc-for-target))))
            (replace 'build
              (lambda _
                (invoke "make" "all"))))))
    (home-page "https://www.idris-lang.org")
    (synopsis "Purely functional programming language with first class types")
    (description
     "Idris is a programming language designed to encourage
Type-Driven Development.

In type-driven development, types are tools for constructing programs.  We
treat the type as the plan for a program, and use the compiler and type
checker as our assistant, guiding us to a complete program that satisfies the
type.  The more expressive the type is that we give up front, the more
confidence we can have that the resulting program will be correct.

In Idris, types are first-class constructs in the langauge.  This means types
can be passed as arguments to functions, and returned from functions just like
any other value, such as numbers, strings, or lists.  This is a small but
powerful idea, enabling:
@itemize
@item
relationships to be expressed between values; for example, that two lists
have the same length.
@item
assumptions to be made explicit and checked by the compiler.  For
example, if you assume that a list is non-empty, Idris can ensure this
assumption always holds before the program is run.
@item
if desired, properties of program behaviour to be formally stated and
proven.
@end itemize")
    (license license:bsd-3)))

(define-public idris2-bootstrap-0.2.1
  (make-idris2
    #:version "0.2.1"
    #:source-hash "044slgl2pwvj939kz3z92n6l182plc5fzng1n4z4k6bg11msqq14"
    #:input-idris2 idris2-boot))

(define-public idris2-bootstrap-0.2.2
  (make-idris2
    #:version "0.2.2"
    #:source-hash "0krhpkakp9yar54c2gnj5w97j5iyw8gvjxiq7biachm1y07ai7y5"
    #:input-idris2 idris2-bootstrap-0.2.1))

(define-public idris2-bootstrap-0.3.0
  (make-idris2
    #:version "0.3.0"
    #:source-hash "0sa2lpb7n6xqfknwld9rzm4bnb6qcd0ja1n63cnc5v8wdzr8q7kh"
    #:input-idris2 idris2-bootstrap-0.2.2))

(define-public idris2-bootstrap-0.4.0
  (make-idris2
    #:version "0.4.0"
    #:source-hash "105jybjf5s0k6003qzfxchzsfcpsxip180bh3mdmi74d464d0h8g"
    #:input-idris2 idris2-bootstrap-0.3.0))

(define-public idris2-bootstrap-0.5.1
  (make-idris2
    #:version "0.5.1"
    #:source-hash "09k5fxnplp6fv3877ynz1lwq9zapxcxbvfvkn6g68yb0ivrff978"
    #:input-idris2 idris2-bootstrap-0.4.0))

(define-public idris2-bootstrap-0.6.0
  (make-idris2
    #:version "0.6.0"
    #:source-hash "0zphckjnq8j177y09nma66pd30rgqf3hjnhyyqsd44j8rlc00hzk"
    #:input-idris2 idris2-bootstrap-0.5.1))

(define-public idris2-bootstrap-0.7.0
  (make-idris2
    #:version "0.7.0"
    #:source-hash "0qxfwsm2gxjxwzni85jb5b4snvjf77knqs9bnd2bqznrfxgxw2sp"
    #:input-idris2 idris2-bootstrap-0.6.0))

(define-public idris2-0.7.0
  (make-idris2
    #:version "0.7.0"
    #:source-hash "0qxfwsm2gxjxwzni85jb5b4snvjf77knqs9bnd2bqznrfxgxw2sp"
    #:input-idris2 idris2-bootstrap-0.7.0
    #:final? #t))

(define-public idris2 idris2-0.7.0)
