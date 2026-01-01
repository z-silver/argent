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
  (let ((commit "5400d5efa52b461382960eb30ff033a838ff1d47")
        (revision "0"))
    (package
      (name "timez")
      (version (git-version "0.0.2" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/z-silver/timez")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1pmzb5i5906vgqipdqa078jz3d7w0f0d2pzgw6i4jwl60vs99ng1"))))
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
