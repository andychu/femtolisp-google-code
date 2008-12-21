; uncomment for compatibility with CL
;(defun mapp (f l) (mapcar f l))
;(defmacro define (name &rest body)
;  (if (symbolp name)
;      (list 'setq name (car body))
;    (list 'defun (car name) (cdr name) (cons 'progn body))))

; dictionaries ----------------------------------------------------------------
(define (dict-new) ())

(define (dict-extend dl key value)
  (cond ((null dl)              (list (cons key value)))
        ((equal key (caar dl))  (cons (cons key value) (cdr dl)))
        (T (cons (car dl) (dict-extend (cdr dl) key value)))))

(define (dict-lookup dl key)
  (cond ((null dl)              ())
        ((equal key (caar dl))  (cdar dl))
        (T (dict-lookup (cdr dl) key))))

(define (dict-keys dl) (map (symbol-function 'car) dl))

; graphs ----------------------------------------------------------------------
(define (graph-empty) (dict-new))

(define (graph-connect g n1 n2)
  (dict-extend
   (dict-extend g n2 (cons n1 (dict-lookup g n2)))
   n1
   (cons n2 (dict-lookup g n1))))

(define (graph-adjacent? g n1 n2) (member n2 (dict-lookup g n1)))

(define (graph-neighbors g n) (dict-lookup g n))

(define (graph-nodes g) (dict-keys g))

(define (graph-add-node g n1) (dict-extend g n1 ()))

(define (graph-from-edges edge-list)
  (if (null edge-list)
      (graph-empty)
    (graph-connect (graph-from-edges (cdr edge-list))
                   (caar edge-list)
                   (cdar edge-list))))

; graph coloring --------------------------------------------------------------
(define (node-colorable? g coloring node-to-color color-of-node)
  (not (member
        color-of-node
        (map
         (lambda (n)
           (let ((color-pair (assoc n coloring)))
             (if (consp color-pair) (cdr color-pair) nil)))
         (graph-neighbors g node-to-color)))))

(define (try-each f lst)
  (if (null lst) nil
    (let ((ret (funcall f (car lst))))
      (if ret ret (try-each f (cdr lst))))))

(define (color-node g coloring colors uncolored-nodes color)
  (cond
   ((null uncolored-nodes) coloring)
   ((node-colorable? g coloring (car uncolored-nodes) color)
    (let ((new-coloring
           (cons (cons (car uncolored-nodes) color) coloring)))
      (try-each (lambda (c)
                  (color-node g new-coloring colors (cdr uncolored-nodes) c))
                colors)))))

(define (color-graph g colors)
  (if (null colors)
      (null (graph-nodes g))
    (color-node g () colors (graph-nodes g) (car colors))))

(define (color-pairs pairs colors)
  (color-graph (graph-from-edges pairs) colors))

; queens ----------------------------------------------------------------------
(defun can-attack (x y)
  (let ((x1 (mod x 5))
        (y1 (truncate (/ x 5)))
        (x2 (mod y 5))
        (y2 (truncate (/ y 5))))
    (or (= x1 x2) (= y1 y2) (= (abs (- y2 y1)) (abs (- x2 x1))))))

(defun generate-5x5-pairs ()
  (let ((result nil))
    (dotimes (x 25)
      (dotimes (y 25)
        (if (and (/= x y) (can-attack x y))
            (setq result (cons (cons x y) result)) nil)))
    result))