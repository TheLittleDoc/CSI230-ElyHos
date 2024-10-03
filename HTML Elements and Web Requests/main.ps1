$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://localhost/ToBeScraped.html

# $scraped_page.Links | Select href,outerText
# $h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select outerText
# $h2s

$div1s = $scraped_page.ParsedHtml.body.getElementsByTagName("div") | 
    where { $_.getAttributeNode("class").Value -ilike "div-1" } |
    Select innerText
$div1s