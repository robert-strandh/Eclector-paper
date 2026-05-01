(setf *default-pathname-defaults* #P"~/Projects/\\[2026\\]paper-els-eclector/benchmark/")

(unless (probe-file "/tmp/ecl-test/bin/ecl")
  (unless (probe-file "/tmp/ecl/configure")
    (uiop:run-program '("/usr/bin/git"
                        "clone"
                        "https://gitlab.common-lisp.net/ecl/ecl")
                      :directory "/tmp/"))
  (uiop:run-program '("/usr/bin/git"
                      "checkout" "3d83b007947590136278b4af2e19b3912873f21d")
                    :output    *standard-output*
                    :error     *error-output*
                    :directory "/tmp/ecl/")
  (uiop:run-program '("/tmp/ecl/configure"
                      "--prefix" "/tmp/ecl-test")
                    :output    *standard-output*
                    :error     *error-output*
                    :directory "/tmp/ecl/")
  (uiop:run-program '("/usr/bin/make" "-j" "2" "install")
                    :output    *standard-output*
                    :error     *error-output*
                    :directory "/tmp/ecl/"))

(uiop:run-program
 '("/usr/bin/sbcl"
   "--noinform"
   "--load" "/home/jmoringe/.local/share/common-lisp/quicklisp/setup.lisp"
   "--script" "run.lisp")
 :output    *standard-output*
 :error     *error-output*
 :directory *default-pathname-defaults*)

(uiop:run-program
 '("/home/jmoringe/opt/ccl/lx86cl64"
   "-b" "-Q"
   "-l" "/home/jmoringe/.local/share/common-lisp/quicklisp/setup.lisp"
   "-l" "run.lisp" )
 :output    *standard-output*
 :error     *error-output*
 :directory *default-pathname-defaults*)

(uiop:run-program
 '("/tmp/ecl-test/bin/ecl"
   "-q"
   "--load" "/home/jmoringe/.local/share/common-lisp/quicklisp/setup.lisp"
   "--load" "run.lisp"
   "--eval" "(quit)")
 :output    *standard-output*
 :error     *error-output*
 :directory *default-pathname-defaults*)
