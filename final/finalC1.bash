#! /bin/bash
# Challenge-1
# Write a script the obtains IOC from the given web page,
# Save it to IOC.txt

# access the web page, scrape the phrases
link="10.0.17.5/IOC.html"

page=$(curl -sL "$link")

output=$(echo "$page" | xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template --match "//html//body//table/tr[position() > 2]" -v "td[1]" -n)
#xmlstar.sourceforget.net/doc.UG/xmlstarlet-ug.html

#save them to the IOC.txt file, use touch
echo "$output" | sed 's/<\/tr>/\n/g' | \
		 sed -e 's/<tr>//g' | \
		 sed -e 's/<td>//g' | \
		 sed -e 's/<\/td>/;/g' | \
		 sed -e 's/<th>//g' | \
		 sed -e 's/<\/th>/;/g' | \
		 sed 's/&#13;//g' | \
		 sed '/^\s*$/d' > IOC.txt

