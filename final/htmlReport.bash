#! /bin/bash
# Challenge-3
# Write a script that takes the report.txt
# and transform it into an html report
# have loops to write the html tags in the correct syntax
touch report.html
cat << EOF > report
<!DOCTYPE html>
<html>
<body>
<br>Access logs with IOC indicators: <br>
<table>
EOF

while read line; do
	echo "<tr>" # >> report.html
	for item in $line; do
		echo "<td>$item</td>" #>> report.html
	done
	echo "</tr>" #>> report.html
done
cat << EOF >> report.html
</table>
</body>
</html>
EOF

# it should be in the /var/ww/html/ dir
mv report.html /var/www/html/report.html
