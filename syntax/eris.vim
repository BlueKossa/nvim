if exists("b:current_syntax")
  finish
endif

set iskeyword=a-z,A-Z,1-9,*,_,!,@

" Language keywords
syntax keyword erisKeywords if else struct return break loop foreign ha8


" Symbols
syntax match erisSymbols "\v\::"
syntax match erisSymbols "\v\."
syntax match erisSymbols "\v\,"
syntax match erisSymbols "\v\("
syntax match erisSymbols "\v\)"
syntax match erisSymbols "\v\{"
syntax match erisSymbols "\v\}"
syntax match erisSymbols "\v\="
syntax match erisSymbols "\v\+"
syntax match erisSymbols "\v\-"
syntax match erisSymbols "\v\*"
syntax match erisSymbols "\v\/"
syntax match erisSymbols "\v\%"
syntax match erisSymbols "\v\&"


syntax region erisNumber start=/\s\d/ skip=/\d/ end=/\s/


" String literals
syntax region erisString start=/\v"/ skip=/\v\\./ end=/\v"/ contains=erisEscapes

" Escape literals \n, \r, ....
syntax match erisEscapes display contained "\\[nr\"']"


syntax match erisStruct /\u\w\+\s\::/he=e-2

syntax match erisFunction /\l\w\+\s\::/he=e-2

" Type names the compiler recognizes
syntax keyword erisTypeNames bool
syntax match erisTypeNames "i8\|i\d\d"
syntax match erisTypeNames "u8\|u\d\d"
syntax match erisTypeNames "f\d\d"
" Set highlights
highlight default link erisKeywords Keyword
highlight default link erisSymbols Operator
highlight default link erisString String
highlight default link erisNumber Number
highlight default link erisTypeNames Type
highlight default link erisEscapes SpecialChar
highlight default link erisFunction Function
highlight default link erisFunction Underlined

highlight default link erisStruct Structure 

let b:current_syntax = "eris"

