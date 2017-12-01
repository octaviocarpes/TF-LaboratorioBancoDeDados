$dir = "$PSScriptRoot\disciplinas"

$all = @()
foreach($file in dir $dir) {
    $csv = Import-Csv -Delimiter ";" -Path $file.FullName -Encoding Default
    $csv | % {
        $all += $_ | Select-Object *, @{n="curso"; e={$file.BaseName}}
    }
}
$all = $all | sort nome

$disciplinasList = $all | Select-Object nome, creditos, carga_horaria -Unique | Sort-Object nome -Unique

$sql = @()
foreach($item in $disciplinasList) {
    $cursos = @($all | ? {$_.nome -eq $item.nome})
    $sql += "INSERT INTO Disciplina(`'nome`', `'creditos`', `'carga_horaria`') VALUES(`'$($item.nome)`', `'$($item.creditos)`', `'$($item.carga_horaria)`');"
    $cursos | % {
        $sql += "INSERT INTO Curso_Disciplina(`'nivel`', `'disciplina_id`', `'curso_id`') VALUES (`'$($_.nivel)`', DISCIPLINA_ID_SEQ.CURRVAL, `'$($_.curso)`');"
    }
}
$sql