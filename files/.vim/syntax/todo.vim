" VIM syntax file
" Language: Todo
" Maintainer: sparticvs
" Latest Revision: 21 June 2012

" -- Example of usage --
" [_] Some generic task
" [!] High priority task
" [N] Now priority task
" [T] Tomorrow priority task
" [X] Completed task

" Don't do anything if the syntax is already set to this.
if exists("b:current_syntax")
  finish
endif

syn match tomorrowState "^\[T\]"
syn match nowState "^\[N\]"
syn match holdState "^\[H\]"
syn match doneState "^\[X\] .*$"
syn match importantState "^\[!\]"
syn match emptyState "^\[_\] "
syn match newState "^\[_\]"

hi def link tomorrowState   Type
hi def link nowState        Todo
hi def link holdState       Statement
hi def link doneState       Comment
hi def link importantState  Error
hi def link emptyState      String
hi def link newState        Delimiter
hi def link digits          Underlined

syn sync linebreaks=1

let b:current_syntax = "todo"
