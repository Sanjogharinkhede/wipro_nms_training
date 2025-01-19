echo "enter file"
read source
if [ -s $source ];then 
	echo "File Present"
	if [ ! -r $source ]; then
		echo "Readable"
	exit
        fi
else
	echo "No File"
	exit
fi
