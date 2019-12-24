#!/bin/bash

scale="2"

argv=("$0" "$@")
file=${argv[$#]}
params="${argv[@]:1:$#-1}"

size=$(identify $file | grep -Po "[0-9]+x[0-9]+" | head -1)
newsize=$(python -c "x = '$size'; print('x'.join([str(int(i)*${scale}) for i in x.split('x')]))")
cat "$file" | mkbitmap -s 1 | convert -scale "${newsize}" - - | potrace -a 0 -r $((scale * 72)) ${params/-r 72/}
