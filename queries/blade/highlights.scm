(directive) @tag
(directive_start) @tag
(directive_end) @tag
(comment) @comment
; ((parameter) @include (#set! "priority" 110))
((php_only) @include (#set! "priority" 110))
((bracket_start) @tag (#set! "priority" 120))
((bracket_end) @tag (#set! "priority" 120))
(keyword) @function
