syntax match timeclockComment "^#.*$"
syntax match timeclockTypeIn "^i" nextgroup=timeclockTimestamp skipwhite
syntax match timeclockTypeOut "^o" nextgroup=timeclockTimestamp skipwhite
syntax match timeclockTimestamp "\d\{4\}-\d\{2\}-\d\{2\} \d\{2\}:\d\{2\}:\d\{2\}" contained nextgroup=timeclockDescription skipwhite
syntax match timeclockDescription ".*" contained

highlight default link timeclockComment Comment
highlight default link timeclockTypeIn Type
highlight default link timeclockTypeOut Type
highlight default link timeclockTimestamp Number
highlight default link timeclockDescription Identifier
