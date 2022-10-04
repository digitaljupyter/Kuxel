(require "kuxel-repl")

(set prompt "# ")

(require "usr/dshrc.asd")

; Simple find function
(defun find (lis, item)
  (set found -1)
  (set i 1)
  (each lis (case (= @ item)
    (set found i)
    (set i (+ i 1))))
  
  (return found))

(defun has (list, item)
  (return (not (find list item) -1)))

; begin <ps1> <path (or list of paths)>
(begin prompt "./usr/bin")
