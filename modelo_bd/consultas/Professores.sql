SELECT m.numero, p.nome, p.genero, p.data_nasc, p.email, p.endereco, c.nome, e.nome
FROM Professor p
INNER JOIN Matricula m ON a.Matricula_numero = m.numero
INNER JOIN Cidade c ON a.Cidade_id = c.id
INNER JOIN Estado e ON c.Estado_uf = e.uf
ORDER BY p.nome;