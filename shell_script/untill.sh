
num1=0
until [ $num1 -gt 10 ];
	do
	  # ps -a
	  num1=` expr $num1 + 1 `;
	  echo $num1
	  done
