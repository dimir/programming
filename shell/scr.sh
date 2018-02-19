#!/bin/bash -e

filename=$1

[ -z "$filename" ] && echo "usage: $0 <filename>; will be saved as /tmp/<filename>.png" && exit 1

activeWinLine=$(xprop -root | grep "_NET_ACTIVE_WINDOW(WINDOW)")
activeWinId=${activeWinLine:40}
import -window "$activeWinId" /tmp/$filename.png
