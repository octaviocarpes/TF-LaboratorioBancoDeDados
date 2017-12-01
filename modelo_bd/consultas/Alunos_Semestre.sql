SELECT m.numero as matricula, a.nome, a.genero, a.data_nasc, a.email, a.endereco, c.nome as cidade, e.nome as estado, cs.nome as curso, s.trancado
FROM Aluno a
INNER JOIN Matricula m ON a.Matricula_numero = m.numero
INNER JOIN Cidade c ON a.Cidade_id = c.id
INNER JOIN Estado e ON c.Estado_uf = e.uf
INNER JOIN Curso cs ON a.Curso_id = cs.id
INNER JOIN Semestre s ON a.Matricula_numero = s.Aluno_Matricula_numero
WHERE s.periodo = periodo
ORDER BY a.nome;