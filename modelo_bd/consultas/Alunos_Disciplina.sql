SELECT m.numero, a.nome, a.genero, a.data_nasc, a.email, a.endereco, c.nome, e.nome
FROM Aluno a
INNER JOIN Matricula m ON a.Matricula_numero = m.numero
INNER JOIN Cidade c ON a.Cidade_id = c.id
INNER JOIN Estado e ON c.Estado_uf = e.uf
INNER JOIN Semestre s ON a.Matricula_numero = s.Aluno_Matricula_numero
INNER JOIN Semestre_Disciplina sd ON s.id = sd.Semestre_id
INNER JOIN Disciplina d ON sd.turma_id = d.id
WHERE d.id = id
ORDER BY a.nome;