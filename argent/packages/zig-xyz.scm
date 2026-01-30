(define-module (argent packages zig-xyz)
  #:use-module (gnu packages zig)
  #:use-module (guix build-system zig)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (guix packages))

(define-public zig-datetime
  (package
    (name "zig-datetime")
    (version "0.15.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             ;; temporarily use non-canonical repository until PR is merged
             (url "https://github.com/z-silver/datetime")
             (commit "1c8b1c17182db35f69324acfea94f6ed8143bbbe")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1vbd5xql3p8rhi0pq5qbm4gy2hgb9rrdhqp4h7s27rdyhcq6ijpa"))))
    (build-system zig-build-system)
    (arguments
     (list
      #:zig zig-0.15
      #:skip-build? #t))
    (synopsis "Generic Date, Time, and DateTime library.")
    (description "Generic Date, Time, and DateTime library.")
    (home-page "https://github.com/clickingbuttons/datetime")
    (license license:expat)))

(define-public timez
  (let ((version "0.0.3")
        (commit "646e3002ce4afc913fb5996e7d89056c88cd660a")
        (revision "0"))
    (package
      (name "timez")
      (version (git-version version revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/z-silver/timez")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "193cacmf1f3k2vrmikskin2rc3lzxmmnb898pk0m43vcls7qj76x"))))
      (build-system zig-build-system)
      (arguments
       (list
        #:zig zig-0.15
        #:install-source? #f
        #:zig-release-type "small"))
      (inputs (list zig-datetime))
      (synopsis "Work time reporting tool")
      (description
       "A tool to help generate work time reports at the end of the month.")
      (home-page "https://github.com/z-silver/timez")
      (license license:unlicense))))

(define-public poop
  (let ((commit "67ab6632c53af751a4d9cfb214ff67ef55fd1ceb")
        (revision "1"))
    (package
      (name "poop")
      (version (git-version "0.5.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/andrewrk/poop")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0lgcgks8pd92f9gm913rjviaipx3iqsylb9f7r1xjp5axgi676vz"))))
      (build-system zig-build-system)
      (arguments
       (list
        #:zig zig-0.15
        #:install-source? #f
        #:zig-release-type "fast"
        #:zig-build-flags ''("-Dstrip")
        #:phases
        #~(modify-phases %standard-phases
            (delete 'check))))
      (synopsis "Performance Optimizer Observation Platform")
      (description
       "This command line tool uses Linux's perf_event_open functionality
to compare the performance of multiple commands with a colorful terminal user
interface.")
      (home-page "https://github.com/andrewrk/poop")
      (license license:expat))))

(define-public zig-xitdb
  (let ((commit "43d88506d847237a6c9c5dc4466971f23cfefe03")
        (revision "0"))
    (package
      (name "zig-xitdb")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/radarroark/xitdb")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0zz64pz260f50fwgmzvgx8d828dpgl92v20y8pb5ij4p7n9czzz8"))))
      (build-system zig-build-system)
      (arguments
       (list
        #:zig zig-0.15
        #:skip-build? #t))
      (synopsis "Immutable database for Zig")
      (description
       "xitdb is an immutable database written in Zig.

Each transaction efficiently creates a new \"copy\" of the database, and past
copies can still be read from.  It supports writing to a file as well as purely
in-memory use.  No query engine of any kind.  You just write data structures
(primarily an ArrayList and HashMap) that can be nested arbitrarily.  No
dependencies besides the Zig standard library (requires version 0.15.1).")
      (home-page "https://github.com/radarroark/xitdb")
      (license license:expat))))

(define-public zig-xitui
  (let ((commit "3fb562d72a766eb1c34fb47f8279de663b86c184")
        (revision "0"))
    (package
      (name "zig-xitui")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/radarroark/xitui")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "10z3hgcrkvdw6ssraldc0l0fnrcybvr35zmdqlfbifqk1swl2j0d"))))
      (build-system zig-build-system)
      (arguments
       (list
        #:zig zig-0.15
        #:skip-build? #t))
      (synopsis "TUI library for Zig")
      (description
       "xitui is a library for making TUIs in Zig (requires version 0.15.1).

Includes a widget and focus system.  Widgets are put in a union type defined
by the user, rather than using dynamic dispatch.  Supports Windows, MacOS and
Linux.")
      (home-page "https://github.com/radarroark/xitui")
      (license license:expat))))

(define-public xit
  (let ((commit "1125172dae0340a91e6ee7f0f83f0ce29679c702")
        (revision "0"))
    (package
      (name "xit")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/radarroark/xit")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "14gb2i8g5dxw16433vhpmfyrvzmw17a8jpn000dp3lh5yms2kjxi"))))
      (build-system zig-build-system)
      (arguments
       (list
        #:zig zig-0.15
        #:zig-release-type "safe"
        #:install-source? #f))
      (inputs (list zig-xitdb zig-xitui))
      (synopsis "Git alternative written in Zig")
      (description
       "Xit is a new version control system.  It's pronounced like \"zit\".")
      (home-page "https://github.com/radarroark/xitui")
      (license license:expat))))
