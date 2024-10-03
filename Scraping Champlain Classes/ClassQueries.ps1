function Get-TranslatedDays($days_string) {
    $days = @()
    if($days_string -ilike "M*")       { $days += "Monday" }
    if($days_string -ilike "*T$*") { $days += "Tuesday" }
    if($days_string -ilike "*W*")      { $days += "Wednesday" }
    if($days_string -ilike "*TH*")     { $days += "Thursday" }
    if($days_string -ilike "*F")       { $days += "Friday" }
    if($days_string -ilike "TBA")      { $days += "TBA"}
    return $days
}

function Get-ChamplainClasses() {
    $page = Invoke-WebRequest -TimeoutSec 2 http://localhost/Courses.html

    $tr_elements = $page.ParsedHtml.body.getElementsByTagName("tr")
    $class_table = @()
    for( $i = 1; $i -lt $tr_elements.length; $i++) {
        $td_elements = $tr_elements[$i].getElementsByTagName("td")
        $times = @()
        if($td_elements[4].innerText -notlike "TBA") {
            $times = $td_elements[5].innerText.Split("-")
        } else {
            $times += ""
            $times += ""
        }
        $days = Get-TranslatedDays($td_elements[4].innerText)
        if($td_elements[6].innerText -ilike "*/*") {
            $td_elements[6].innerText = ""
        }

        $this_class = [pscustomobject]@{
            "Class Code" = $td_elements[0].innerText;
            "Title"      = $td_elements[1].innerText;
            "Days"       = $days
            "Time Start" = $times[0];
            "Time End"   = $times[1];
            "Instructor" = $td_elements[6].innerText;
            "Location"   = $td_elements[9].innerText;
        }
        $class_table += $this_class
    }
    return $class_table 
}

