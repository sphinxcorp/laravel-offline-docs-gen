#!/usr/bin/env sh 

CONFIGURED=1
if [ -z `which php` ]; then
	echo "git is not installed or not configured to be in your path, please refer to README.md to know howto install git"
	CONFIGURED=0
fi

if [ -z `which git` ]; then
	echo "git is not installed or not configured to be in your path, please refer to README.md to know howto install git"
	CONFIGURED=0
fi

if [ -z `which pandoc` ]; then
	echo "pandoc utility is not installed or not configured to be in your path, please refer to README.md to know howto install pandoc"
	CONFIGURED=0
fi

if [ $CONFIGURED -eq 0 ]; then
	exit 1
fi

OUT_FILE=$1
if [ -z $1 ]; then
	OUT_FILE=l4docs.pdf
fi
shift
PANDOC_ARGS="$*"

git submodule init && git submodule update
rm -rf build && mkdir build
INDEX=`cat docs/documentation.md | grep "/docs/" | sed -e "s#.*/##g" -e "s#)##g"`
DOC_FILES="cover.md"
PHP_EXEC=`which php`
for f in $INDEX; do
	DOC_FILE="$f.md"
	echo "processing $f"
	$PHP_EXEC preprocess.php "$DOC_FILE"
	DOC_FILES="$DOC_FILES build/$DOC_FILE"
done
echo "generating offline document"
pandoc $PANDOC_ARGS -s --data-dir=./templates/ --template=default -f markdown_phpextra -o $OUT_FILE $DOC_FILES
echo "cleaning up temporary files"
rm -rf build/
echo "done"
echo "created offline document is available in `pwd`/$OUT_FILE"
