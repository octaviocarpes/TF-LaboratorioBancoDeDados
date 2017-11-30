SELECT cr.id, cd.nome, cd.nivel, d.nome, d.creditos, d.carga_horaria
FROM Curriculo cr
INNER JOIN Curriculo_Disciplina cd ON cr.id = cd.Curriculo_id
INNER JOIN Disciplina d ON cd.Disciplina_id = d.id
INNER JOIN Curso cs ON c.Curso_id = cs.id;