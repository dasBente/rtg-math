;;;; rtg-math.asd

(asdf:defsystem #:rtg-math
  :description "A selection of the math routines most commonly needed for realtime graphics in lisp"
  :author "Chris Bagley <techsnuffle@gmail.com>"
  :license "BSD 2 Clause"
  :serial t
  :depends-on (:alexandria :glsl-symbols)
  :components ((:file "package")
               (:file "utils")
               (:file "deftypes")
               (:file "base-maths")
               (:file "vectors/base-vectors")
               (:file "vectors/vector2/non-consing")
               (:file "vectors/vector2/consing")
               (:file "vectors/vector3/non-consing")
               (:file "vectors/vector3/consing")
               (:file "vectors/vector4/non-consing")
               (:file "vectors/vector4/consing")
               (:file "vectors/vectors")
               (:file "matrices/matrix3/common")
               (:file "matrices/matrix3/non-consing")
               (:file "matrices/matrix3/consing")
               (:file "matrices/matrix4/common")
               (:file "matrices/matrix4/non-consing")
               (:file "matrices/matrix4/consing")
               (:file "matrices/base-matrices")
               (:file "matrices/matrices")
               (:file "quaternions/common")
               (:file "quaternions/non-consing")
               (:file "quaternions/consing")
               (:file "projection/camera")
               (:file "polar-coords/polar")
               (:file "spherical-coords/spherical")
               (:file "regions/line3/consing")
               (:file "regions/ray3/consing")
               (:file "regions/line-segment3/consing")
               (:file "regions/aab/common")
               (:file "regions/aab/non-consing")
               (:file "regions/aab/consing")
               (:file "regions/regions")))
