(in-package :rtg-math.matrix4.destructive)

;;----------------------------------------------------------------

(defn set-components
    ((a single-float) (b single-float) (c single-float) (d single-float)
     (e single-float) (f single-float) (g single-float) (h single-float)
     (i single-float) (j single-float) (k single-float) (l single-float)
     (m single-float) (n single-float) (o single-float) (p single-float)
     (mat4-to-mutate mat4)) mat4
  "Make a 4x4 matrix. Data must be provided in row major order"
  (declare (optimize (speed 3) (safety 1) (debug 1)))
  ;; as you can see it is stored in column major order
  (setf (melm mat4-to-mutate 0 0) a)
  (setf (melm mat4-to-mutate 0 1) b)
  (setf (melm mat4-to-mutate 0 2) c)
  (setf (melm mat4-to-mutate 0 3) d)
  (setf (melm mat4-to-mutate 1 0) e)
  (setf (melm mat4-to-mutate 1 1) f)
  (setf (melm mat4-to-mutate 1 2) g)
  (setf (melm mat4-to-mutate 1 3) h)
  (setf (melm mat4-to-mutate 2 0) i)
  (setf (melm mat4-to-mutate 2 1) j)
  (setf (melm mat4-to-mutate 2 2) k)
  (setf (melm mat4-to-mutate 2 3) l)
  (setf (melm mat4-to-mutate 3 0) m)
  (setf (melm mat4-to-mutate 3 1) n)
  (setf (melm mat4-to-mutate 3 2) o)
  (setf (melm mat4-to-mutate 3 3) p)
  mat4-to-mutate)

;;----------------------------------------------------------------

(defn melm ((mat-a mat4) (row (integer 0 3)) (col (integer 0 3))) single-float
  "Provides access to data in the matrix by row
   and column number. The actual data is stored in a 1d list in
   column major order, but this abstraction means we only have
   to think in row major order which is how most mathematical
   texts and online tutorials choose to show matrices"
  (declare (optimize (speed 3) (safety 1) (debug 1)))
  (declare (mat4 mat-a)
           (type (integer 0 4) row col))
  (aref mat-a (cl:+ row (cl:* col 4))))

(defn (setf melm) ((value single-float)
                   (mat-a mat4) (row (integer 0 3)) (col (integer 0 3)))
    single-float
  "Provides access to data in the matrix by row
   and column number. The actual data is stored in a 1d list in
   column major order, but this abstraction means we only have
   to think in row major order which is how most mathematical
   texts and online tutorials choose to show matrices"
  (declare (optimize (speed 3) (safety 1) (debug 1)))
  (setf (aref mat-a (cl:+ row (cl:* col 4))) value))

(define-compiler-macro melm (mat-a row col)
  "Provide access to data in the matrix by row
   and column number. The actual data is stored in a 1d list in
   column major order, but this abstraction means we only have
   to think in row major order which is how most mathematical
   texts and online tutorials choose to show matrices"
  (cond ((and (typep row '(integer 0 3))
              (typep col '(integer 0 3)))
         `(aref ,mat-a ,(cl:+ row (cl:* col 4))))
        ((typep col '(integer 0 3))
         `(aref ,mat-a (cl:+ ,row ,(cl:* col 4))))
        (t `(aref ,mat-a (cl:+ ,row (cl:* ,col 4))))))

;;----------------------------------------------------------------

(defn %* ((mat-accum mat4) (to-multiply-mat mat4)) mat4
  "Multiplies 2 matrices and returns the result as a new
   matrix"
  (declare (optimize (speed 3) (safety 1) (debug 1)))
  (let ((a (cl:+ (cl:* (melm mat-accum 0 0) (melm to-multiply-mat 0 0))
                 (cl:* (melm mat-accum 0 1) (melm to-multiply-mat 1 0))
                 (cl:* (melm mat-accum 0 2) (melm to-multiply-mat 2 0))
                 (cl:* (melm mat-accum 0 3) (melm to-multiply-mat 3 0))))
        (b (cl:+ (cl:* (melm mat-accum 0 0) (melm to-multiply-mat 0 1))
                 (cl:* (melm mat-accum 0 1) (melm to-multiply-mat 1 1))
                 (cl:* (melm mat-accum 0 2) (melm to-multiply-mat 2 1))
                 (cl:* (melm mat-accum 0 3) (melm to-multiply-mat 3 1))))
        (c (cl:+ (cl:* (melm mat-accum 0 0) (melm to-multiply-mat 0 2))
                 (cl:* (melm mat-accum 0 1) (melm to-multiply-mat 1 2))
                 (cl:* (melm mat-accum 0 2) (melm to-multiply-mat 2 2))
                 (cl:* (melm mat-accum 0 3) (melm to-multiply-mat 3 2))))
        (d (cl:+ (cl:* (melm mat-accum 0 0) (melm to-multiply-mat 0 3))
                 (cl:* (melm mat-accum 0 1) (melm to-multiply-mat 1 3))
                 (cl:* (melm mat-accum 0 2) (melm to-multiply-mat 2 3))
                 (cl:* (melm mat-accum 0 3) (melm to-multiply-mat 3 3))))
        (e (cl:+ (cl:* (melm mat-accum 1 0) (melm to-multiply-mat 0 0))
                 (cl:* (melm mat-accum 1 1) (melm to-multiply-mat 1 0))
                 (cl:* (melm mat-accum 1 2) (melm to-multiply-mat 2 0))
                 (cl:* (melm mat-accum 1 3) (melm to-multiply-mat 3 0))))
        (f (cl:+ (cl:* (melm mat-accum 1 0) (melm to-multiply-mat 0 1))
                 (cl:* (melm mat-accum 1 1) (melm to-multiply-mat 1 1))
                 (cl:* (melm mat-accum 1 2) (melm to-multiply-mat 2 1))
                 (cl:* (melm mat-accum 1 3) (melm to-multiply-mat 3 1))))
        (g (cl:+ (cl:* (melm mat-accum 1 0) (melm to-multiply-mat 0 2))
                 (cl:* (melm mat-accum 1 1) (melm to-multiply-mat 1 2))
                 (cl:* (melm mat-accum 1 2) (melm to-multiply-mat 2 2))
                 (cl:* (melm mat-accum 1 3) (melm to-multiply-mat 3 2))))
        (h (cl:+ (cl:* (melm mat-accum 1 0) (melm to-multiply-mat 0 3))
                 (cl:* (melm mat-accum 1 1) (melm to-multiply-mat 1 3))
                 (cl:* (melm mat-accum 1 2) (melm to-multiply-mat 2 3))
                 (cl:* (melm mat-accum 1 3) (melm to-multiply-mat 3 3))))
        (i (cl:+ (cl:* (melm mat-accum 2 0) (melm to-multiply-mat 0 0))
                 (cl:* (melm mat-accum 2 1) (melm to-multiply-mat 1 0))
                 (cl:* (melm mat-accum 2 2) (melm to-multiply-mat 2 0))
                 (cl:* (melm mat-accum 2 3) (melm to-multiply-mat 3 0))))
        (j (cl:+ (cl:* (melm mat-accum 2 0) (melm to-multiply-mat 0 1))
                 (cl:* (melm mat-accum 2 1) (melm to-multiply-mat 1 1))
                 (cl:* (melm mat-accum 2 2) (melm to-multiply-mat 2 1))
                 (cl:* (melm mat-accum 2 3) (melm to-multiply-mat 3 1))))
        (k (cl:+ (cl:* (melm mat-accum 2 0) (melm to-multiply-mat 0 2))
                 (cl:* (melm mat-accum 2 1) (melm to-multiply-mat 1 2))
                 (cl:* (melm mat-accum 2 2) (melm to-multiply-mat 2 2))
                 (cl:* (melm mat-accum 2 3) (melm to-multiply-mat 3 2))))
        (l (cl:+ (cl:* (melm mat-accum 2 0) (melm to-multiply-mat 0 3))
                 (cl:* (melm mat-accum 2 1) (melm to-multiply-mat 1 3))
                 (cl:* (melm mat-accum 2 2) (melm to-multiply-mat 2 3))
                 (cl:* (melm mat-accum 2 3) (melm to-multiply-mat 3 3))))
        (m (cl:+ (cl:* (melm mat-accum 3 0) (melm to-multiply-mat 0 0))
                 (cl:* (melm mat-accum 3 1) (melm to-multiply-mat 1 0))
                 (cl:* (melm mat-accum 3 2) (melm to-multiply-mat 2 0))
                 (cl:* (melm mat-accum 3 3) (melm to-multiply-mat 3 0))))
        (n (cl:+ (cl:* (melm mat-accum 3 0) (melm to-multiply-mat 0 1))
                 (cl:* (melm mat-accum 3 1) (melm to-multiply-mat 1 1))
                 (cl:* (melm mat-accum 3 2) (melm to-multiply-mat 2 1))
                 (cl:* (melm mat-accum 3 3) (melm to-multiply-mat 3 1))))
        (o (cl:+ (cl:* (melm mat-accum 3 0) (melm to-multiply-mat 0 2))
                 (cl:* (melm mat-accum 3 1) (melm to-multiply-mat 1 2))
                 (cl:* (melm mat-accum 3 2) (melm to-multiply-mat 2 2))
                 (cl:* (melm mat-accum 3 3) (melm to-multiply-mat 3 2))))
        (p (cl:+ (cl:* (melm mat-accum 3 0) (melm to-multiply-mat 0 3))
                 (cl:* (melm mat-accum 3 1) (melm to-multiply-mat 1 3))
                 (cl:* (melm mat-accum 3 2) (melm to-multiply-mat 2 3))
                 (cl:* (melm mat-accum 3 3) (melm to-multiply-mat 3 3)))))
    (setf (melm mat-accum 0 0) a)
    (setf (melm mat-accum 0 1) b)
    (setf (melm mat-accum 0 2) c)
    (setf (melm mat-accum 0 3) d)
    (setf (melm mat-accum 1 0) e)
    (setf (melm mat-accum 1 1) f)
    (setf (melm mat-accum 1 2) g)
    (setf (melm mat-accum 1 3) h)
    (setf (melm mat-accum 2 0) i)
    (setf (melm mat-accum 2 1) j)
    (setf (melm mat-accum 2 2) k)
    (setf (melm mat-accum 2 3) l)
    (setf (melm mat-accum 3 0) m)
    (setf (melm mat-accum 3 1) n)
    (setf (melm mat-accum 3 2) o)
    (setf (melm mat-accum 3 3) p)
    mat-accum))

(defn * ((accum-mat mat4) &rest (mat4s mat4)) mat4
  "Add two matrices and returns the mutated matrix (accum-mat)"
  (declare (optimize (speed 3) (safety 1) (debug 1)))
  (reduce #'%* mat4s :initial-value accum-mat))

(define-compiler-macro * (&whole whole accum-mat &rest mat4s)
  (assert accum-mat)
  (case= (cl:length mat4s)
    (0 accum-mat)
    (1 `(%* ,accum-mat (first mat4s)))
    (otherwise whole)))

;;----------------------------------------------------------------
