SELECT m.numero as matricula, p.nome as professor, p.genero, p.data_nasc, p.email, p.endereco, c.nome as cidade, e.nome as estado, d.nome as disciplina, cs.nome as curso
FROM Professor p
INNER JOIN Matricula m ON p.Matricula_numero = m.numero
INNER JOIN Cidade c ON p.Cidade_id = c.id
INNER JOIN Estado e ON c.Estado_uf = e.uf
INNER JOIN Disciplina_Professor dp ON p.Matricula_numero = dp.Professor_Matricula_numero
INNER JOIN Disciplina d ON dp.Disciplina_id = d.id
INNER JOIN Curso_Disciplina cd ON d.id = cd.Disciplina_id
INNER JOIN Curso cs ON cd.Curso_id = cs.id
ORDER BY professor, curso, disciplina;