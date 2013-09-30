#!/usr/bin/env sh 

OUT_FILE=$1
if [ -z $1 ]; then
	OUT_FILE=l4docs.pdf
fi
shift
PANDOC_ARGS="$*"

git submodule init && git submodule update
rm -rf build && mkdir build
INDEX=`cat docs/documentation.md | grep "/docs/" | sed -e "s#.*/##g" -e "s#)##g"`
DOC_FILES=""
PHP_EXEC=`which php`
for f in $INDEX; do
	DOC_FILE="$f.md"
	echo "processing $f"
	$PHP_EXEC preprocess.php "$DOC_FILE"
	DOC_FILES="$DOC_FILES build/$DOC_FILE"
done
echo "generating $OUT_FILE"
pandoc $PANDOC_ARGS -s --data-dir=./templates/ --template=default -f markdown_phpextra -o $OUT_FILE $DOC_FILES
echo "cleaning up temporary files"
rm -rf build/
echo "done"
