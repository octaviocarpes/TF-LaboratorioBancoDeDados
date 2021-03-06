SELECT m.numero as matricula, a.nome, a.genero, a.data_nasc, a.email, a.endereco, c.nome as cidade, e.nome as estado, cs.nome as curso, s.periodo as Ultimo_Semestre
FROM Aluno a
INNER JOIN Matricula m ON a.Matricula_numero = m.numero
INNER JOIN Cidade c ON a.Cidade_id = c.id
INNER JOIN Estado e ON c.Estado_uf = e.uf
INNER JOIN Curso cs ON a.Curso_id = cs.id
INNER JOIN Semestre s ON a.Matricula_numero = s.Aluno_Matricula_numero
INNER JOIN Avaliacao al ON s.id = al.Semestre_id
INNER JOIN Disciplina d ON al.Disciplina_id = d.id
WHERE s.atual = 0 AND NOT EXISTS (
	SELECT d1.id
	FROM Disciplina d1
	INNER JOIN Curso_Disciplina cd1 ON d1.id = cd1.Disciplina_id
	INNER JOIN Curso c1 ON cd1.Curso_id = c1.id
	MINUS
	SELECT d2.id
	FROM Disciplina d2
	INNER JOIN Avaliacao al2 ON d2.id = al2.Semestre_id
	INNER JOIN Semestre s2 ON al2.Semestre_id = s2.id
	WHERE s2.Aluno_Matricula_numero = a.Matricula_Numero AND s2.trancado = 0
)
ORDER BY a.nome;