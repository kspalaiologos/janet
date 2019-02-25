(defmacro printf [& xs] ['print ['string/format (splice xs)]])

(defn matrix [nrow ncol] {:nrow nrow :ncol ncol :array (tarray/new :float64 (* nrow ncol))})

(defn matrix/row [mat i]
  (def {:nrow nrow :ncol ncol :array array} mat)
  (tarray/new :float64 ncol 1 (* i ncol)  array))

(defn matrix/column [mat j]
  (def {:nrow nrow :ncol ncol :array array} mat)
  (tarray/new :float64 nrow ncol j array))

(defn matrix/set [mat i j value]
  (def {:nrow nrow :ncol ncol :array array} mat)
  (set (array (+ (* i ncol) j)) value))

(defn matrix/get [mat i j value]
  (def {:nrow nrow :ncol ncol :array array} mat)
  (array (+ (* i ncol) j)))


# other variants to test rows and cols views

(defn matrix/set* [mat i j value]
  (set ((matrix/row mat i) j) value))

(defn matrix/set** [mat i j value]
  (set ((matrix/column mat j) i) value))


(defn matrix/get* [mat i j value]
  ((matrix/row mat i) j))

(defn matrix/get** [mat i j value]
  ((matrix/column j) i))


(defn tarray/print [array]
  (def size (tarray/length array))
  (def buf @"")
  (buffer/format buf "[%2i]" size)
  (for i 0 size
       (buffer/format buf " %+6.3f " (array i)))
  (print buf))
       
(defn matrix/print [mat]
  (def {:nrow nrow :ncol ncol :array tarray} mat)
  (printf "matrix %iX%i %p" nrow ncol tarray)
  (for i 0 nrow
       (tarray/print (matrix/row mat i))))


(def nr 5)
(def nc 4)
(def A (matrix nr nc))

(loop (i :range (0 nr) j :range (0 nc)) 
      (matrix/set A i j i))
(matrix/print A)

(loop (i :range (0 nr) j :range (0 nc)) 
      (matrix/set* A i j i))
(matrix/print A)

(loop (i :range (0 nr) j :range (0 nc)) 
      (matrix/set** A i j i))
(matrix/print A)

(print "tarray")
(tarray/print (A :array))

(printf "properties:\n%p" (tarray/properties (A :array)))

(printf "row properties:\n%p" (tarray/properties (matrix/row A 1)))


# test marshalling

(def a (tarray/new :float64 20))
(set (a 0) math/pi)
(set (a 1) 1234)

(def b (unmarshal (marshal a)))
(printf "%p" (tarray/properties b))
(print (b 0))
(print (b 1))



