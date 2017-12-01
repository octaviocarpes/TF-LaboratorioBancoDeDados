SELECT d.nome as disciplina, d.creditos, d.carga_horaria, cs.nome as curso
FROM Disciplina d
INNER JOIN Curso_Disciplina cd ON d.id = cd.Disciplina_id
INNER JOIN Curso cs ON cd.Curso_id = cs.id
ORDER BY curso, disciplina;