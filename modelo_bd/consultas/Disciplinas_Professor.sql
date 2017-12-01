SELECT d.nome, d.creditos, d.carga_horaria, p.nome
FROM Disciplina
INNER JOIN Disciplina_Professor dp ON d.id = dp.Disciplina_id
INNER JOIN Professor p ON dp.Professor_Matricula_Numero = p.Matricula_numero
WHERE dp.Professor_Matricula_Numero = Matricula_numero
ORDER BY p.nome;