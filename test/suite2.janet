# Copyright (c) 2018 Calvin Rose
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.

(import test.helper :prefix "" :exit true)
(start-suite 2)

# Buffer stuff
(defn buffer=
  [a b]
  (= (string a) (string b)))

(assert (buffer= @"abcd" @"abcd") "buffer equal 1")
(assert (buffer= @"abcd" (buffer "ab" "cd")) "buffer equal 2")
(assert (not= @"" @"") "buffer not equal 1")
(assert (not= @"abcd" @"abcd") "buffer not equal 2")

(defn buffer-factory
  []
  @"im am a buffer")

(assert (not= (buffer-factory) (buffer-factory)) "buffer instantiation")

(assert (= (length @"abcdef") 6) "buffer length")

# Looping idea
(def xs 
  (for [x :in '[-1 0 1], y :in '[-1 0 1] :when (not= x y 0)] (tuple x y)))
(def txs (apply tuple xs))

(assert (= txs '[[-1 -1] [-1 0] [-1 1] [0 -1] [0 1] [1 -1] [1 0] [1 1]]) "nested for")

# Check x:digits: works as symbol and not a hex number
(def x1 100)
(assert (= x1 100) "x1 as symbol")
(def X1 100)
(assert (= X1 100) "X1 as symbol")

(end-suite)

