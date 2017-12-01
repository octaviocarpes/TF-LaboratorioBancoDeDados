$source = "$PSScriptRoot\disciplinas_dump"
$target = "$PSScriptRoot\disciplinas"
$csvDelimiter = ";"
$disciplinas = "
administracao-de-empresas
arquitetura-urbanismo
bacharelado-em-direito
biomedicina
ciencia-da-computacao
ciencias-aeronauticas
ciencias-contabeis-controladoria-e-tributos
enfermagem
engenharia-civil
engenharia-de-computacao
engenharia-de-producao
engenharia-de-software
engenharia-eletrica
engenharia-mecanica
engenharia-quimica
farmacia
filosofia
historia
medicina
odontologia
psicologia
".Split("`n") | % {$_.Replace("`r", "")} | ? {$_}

if(!(Test-Path $target)) {
    New-Item $target -ItemType Directory -ErrorAction Stop | Out-Null
}

Get-ChildItem $source | ? {$disciplinas -contains $_.BaseName} | % {
    Import-Csv $_.FullName -Delimiter $csvDelimiter | Select-Object @{n="nivel"; e={$_.SEM}},
                                                          @{n="nome"; e={$_.Disciplina}},
                                                          @{n="creditos"; e={[Convert]::ToInt32($_.CH / 15)}},
                                                          @{n="carga_horaria"; e={$_.CH}} | Export-Csv -NoTypeInformation -Encoding Default -Delimiter $csvDelimiter -Path "$($target)\$($_.Name)"
}