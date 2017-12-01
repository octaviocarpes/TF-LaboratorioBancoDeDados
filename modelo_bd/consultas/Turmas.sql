SELECT t.numero, d.nome, cs.nome
FROM Turma t
INNER JOIN Disciplina_Turma dt ON t.id = dt.Turma_id
INNER JOIN Disciplina d ON dt.Disciplina_id = d.id
INNER JOIN Curso_Disciplina cd ON d.id = cd.Disciplina_id
INNER JOIN Curso cs ON cd.Curso_id = cs.id
ORDER BY t.numero;