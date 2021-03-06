SELECT m.numero as matricula, p.nome as professor, p.genero, p.data_nasc, p.email, p.endereco, c.nome as cidade, e.nome as estado, d.nome as disciplina
FROM Professor p
INNER JOIN Matricula m ON p.Matricula_numero = m.numero
INNER JOIN Cidade c ON p.Cidade_id = c.id
INNER JOIN Estado e ON c.Estado_uf = e.uf
INNER JOIN Disciplina_Professor dp ON p.Matricula_numero = dp.Professor_Matricula_numero
INNER JOIN Disciplina d ON dp.Disciplina_id = d.id
WHERE d.id = id
ORDER BY p.nome;
