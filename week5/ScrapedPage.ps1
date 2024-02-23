#clear the screen
clear

$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.21/ToBeScraped.html
# Get a count of the links in the page
#$scraped_page.Links.Count

# Display the links as HTML Element
#$scraped_page.Links

# Display only the URL and its text
#$scraped_page.Links | select outerText, href

#Get outer text of every element tag h2
#$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | select outerText
#$h2s

# Print innerText of every div element that has the class as "div-1"
$divs1 = $scraped_page.ParsedHtml.body.getElementsByTagName("div") | where { `
$_.getAttributeNode("class").Value -ilike "*div-1*"} | select innerText
$divs1