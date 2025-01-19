calc(){
	echo "second arg: $2"
	a=$1
	b=$2
	echo "first arg: $a"
	res=$((a+b))
	echo $res
	return $((a*b))
}
r=$(calc 3 99)
l=$?
echo "Res: $r"
echo "Return: $l"
t=$(calc -11 3)
t2=$?
echo "t=$t , t2= $t2"
