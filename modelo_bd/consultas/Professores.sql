SELECT m.numero as matricula, p.nome, p.genero, p.data_nasc, p.email, p.endereco, c.nome as cidade, e.nome as estado
FROM Professor p
INNER JOIN Matricula m ON p.Matricula_numero = m.numero
INNER JOIN Cidade c ON p.Cidade_id = c.id
INNER JOIN Estado e ON c.Estado_uf = e.uf
ORDER BY p.nome;