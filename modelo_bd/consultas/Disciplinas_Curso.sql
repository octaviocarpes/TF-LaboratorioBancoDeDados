SELECT d.nome AS disciplina, d.creditos, d.carga_horaria
FROM Disciplina d
INNER JOIN Curso_Disciplina cd ON d.id = cd.Disciplina_id
INNER JOIN Curso cs ON cd.Curso_id = cs.id
WHERE cd.Curso_id = id
ORDER BY disciplina;