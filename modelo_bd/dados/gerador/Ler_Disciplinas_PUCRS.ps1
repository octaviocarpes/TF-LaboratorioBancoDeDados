$url = "http://www.pucrs.br/graduacao/"
$regex = "http[s]?:\/(\/(.*?))*?[\/]?$"
$csvDelimiter = ";"
$targetDir = "$PSScriptRoot\disciplinas_dump"

$links = @((Invoke-WebRequest $url).links | ? {$_.class -eq "more"} | % {$_.href})
for($i = 0; $i -lt $links.Count; $i++) {
    Write-Progress -Activity "Lendo dados" -Status "$($i+1) de $($links.Count)" -PercentComplete (($i+1) / $links.Count * 100) -CurrentOperation $links[$i]
    if($links[$i] -match $regex) {
        Invoke-WebRequest $links[$i] | % {$_.ParsedHtml.getElementsByTagName("div") | ? {$_.className -eq "conteudo"} | % {$_.getElementsByTagName("table")}} | % {
            $_.rows | % {($_.cells | % {$_.innerText}) -join $csvDelimiter} | Out-File "$($targetDir)\$($Matches[2]).csv"
        }
    }
}