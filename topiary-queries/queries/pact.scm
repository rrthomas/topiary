; All named nodes can be interleaved by empty lines
(_) @allow_blank_line_before

;; Comments
(comment) @prepend_space @append_hardline

;; Scalar literals
[
  (atom)
  (boolean)
  (decimal)
  (integer)
  (reference)
  (string)
  (symbol)

  ; TODO doc_string is just an alias of string; do we need this?
  (doc_string)
] @leaf

;; Collection literals

; NOTE We opt for Algol-style formatting over collections, rather than
; Lisp-style, when multilined. That is, something like:
;
;   [             {                   {
;     foo,          foo: "bar"          foo := "bar",
;     bar,        }                     quux := "baz"
;     quux                            }
;   ]

(list
  "[" @append_empty_softline @append_indent_start
  "]" @prepend_empty_softline @prepend_indent_end
)

(list
  "," @append_spaced_softline
)

(object
  "{" @append_empty_softline @append_indent_start
  "}" @prepend_empty_softline @prepend_indent_end
)

(object
  "," @append_spaced_softline
)

(object
  (pair
    ":" @prepand_antispace @append_spaced_softline
  )
)

(object
  (bind_pair
    ":=" @prepand_space @append_spaced_softline
  )
)



;; ; TODO
;; [
;;   (def_identifier)
;;   (doc_string)
;;   (module_governance)
;;   (module_identifier)
;;   (reference)
;;   (string)
;;   (symbol)
;; ] @prepend_space @append_space
;;
;; [
;;   (interface)
;;   (module)
;;   (namespace)
;;   (s_expression)
;;   (use)
;; ] @append_hardline
;;
;; ; Remove spaces following opening/preceding closing parens in all sexprs
;; (
;;   "(" @append_antispace
;;   ")" @prepend_antispace
;; )
;;
;; (
;;   "[" @append_antispace
;;   "]" @prepend_antispace
;; )
;;
;; ; Remove spaces before type specification
;; (
;;   ":" @prepend_antispace
;;   .
;;   (type_identifier)
;; )
;;
;; ;; Indentation
;;
;; ; We opt for idiomatic Lisp indentation of sexprs: The indentation
;; ; block is opened after a context-specific atom in the sexpr (not
;; ; necessarily the head element); then the closing paren falls on the
;; ; last line of the sexpr, rather than having a line of its own.
;; ; Something like this:
;; ;
;; ;   (foo bar
;; ;      (quux xyzzy))
;; ;
;; ; Opposed to Algol-style formatting, which _is_ used in some contexts:
;; ;
;; ;   (
;; ;     foo bar
;; ;     (quux xyzzy)
;; ;   )
;;
;; ; Modules
;; ; Start the indentation block after the (module_governance) node
;; (module
;;   (module_governance) @append_spaced_softline @append_indent_start
;;   ")" @append_indent_end
;; )
;;
;; ; S-Expressions
;; ; Start the indentation block after the head node
;; (s_expression
;;   (s_expression_head) @append_spaced_softline @append_indent_start
;;   ")" @append_indent_end
;; )
;;
;; ; Function definitions
;; ; Start the indentation block after the (optionally typed) identifier
;; (defun
;;   (def_identifier)
;;   (parameter_list) @prepend_spaced_softline @prepend_indent_start
;;   ")" @append_indent_end
;; )
;;
;; ; Parameter lists
;; ; Start the indentation block immediately, but use Algol-style
;; (parameter_list
;;   "(" @append_empty_softline @append_indent_start
;;   ")" @prepend_empty_softline @prepend_indent_end
;; )
;;
;; ; Lists
;; ; Start the indentation block immediately, but use Algol-style
;; (list
;;   "[" @append_empty_softline @append_indent_start
;;   "]" @prepend_empty_softline @prepend_indent_end
;; )
;;
;; (list "," @append_spaced_softline)
;;
;; ; Constant definitions
;; ; Start the indentation block after the value
;; (defconst
;;   (def_identifier)
;;   .
;;   (_) @append_spaced_softline @append_indent_start
;;   ")" @append_indent_end
;; )
;;
;; ;; Multiline sexprs
;; ; Each atom, after the variable number of leading nodes, for context,
;; ; should appear on their own line.
;;
;; ; NOTE / FIXME: Full-line and line-end comments cannot be easily
;; ; distinguished, as they are equal siblings...
;;
;; ; Modules
;; ; Context is up to and including the (module_governance) node
;; (module
;;   (module_governance)
;;   (_) @prepend_spaced_softline
;; )
;;
;; ; S-Expressions
;; ; Context is just the head node
;; (s_expression
;;   (s_expression_head)
;;   (_) @prepend_spaced_softline
;; )
;;
;; ; Parameter lists
;; ; Just a list (no context)
;; (parameter_list
;;   (parameter) @prepend_spaced_softline
;; )
;;
;; ; Function bodies
;; ; Each named node after the parameters, except the last, gets a new softline
;; (defun
;;   (parameter_list)
;;   (_) @append_spaced_softline
;;   .
;;   (_)
;; )
