SELECT m.numero, p.nome, p.genero, p.data_nasc, p.email, p.endereco, c.nome, e.nome, d.nome
FROM Professor p
INNER JOIN Matricula m ON a.Matricula_numero = m.numero
INNER JOIN Cidade c ON a.Cidade_id = c.id
INNER JOIN Estado e ON c.Estado_uf = e.uf
INNER JOIN Disciplina_Professor dp ON p.Matricula_numero = dp.Professor_Matricula_numero
INNER JOIN Disciplina d ON dp.Disciplina_id = d.id
WHERE d.id = id
ORDER BY p.nome;
