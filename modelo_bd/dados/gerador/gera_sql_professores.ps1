$sql = @();
Import-Csv "$PSScriptRoot\professores.csv" -Delimiter ";" -Encoding Default | % {
    $_ | Select-Object nome, genero, endereco, email,
                       @{n="cidade_id"; e={Get-Random -Minimum 1 -Maximum 500}},
                       @{n="data_nasc"; e={Get-Date (Get-Random -Minimum (Get-Date "1/1/1980").Ticks -Maximum (Get-Date "1/1/1999").Ticks) -Format "dd/MM/yyyy"}}
} | % {
    $sql += "INSERT INTO matricula values(null);"
    $sql += "INSERT INTO PROFESSOR(matricula_numero, nome, genero, endereco, email, cidade_id, data_nasc) VALUES(matricula_numero_seq.currval, `'$($_.nome)`', `'$($_.genero)`', `'$($_.endereco)`', `'$($_.email)`', `'$($_.cidade_id)`', `TO_DATE('$($_.data_nasc)`', `'DD/MM/YYYY`'));"
}
$sql