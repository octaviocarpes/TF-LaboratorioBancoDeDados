SELECT m.numero as matricula, a.nome, a.genero, a.data_nasc, a.email, a.endereco, c.nome as cidade, e.nome as estado
FROM Aluno a
INNER JOIN Matricula m ON a.Matricula_numero = m.numero
INNER JOIN Cidade c ON a.Cidade_id = c.id
INNER JOIN Estado e ON c.Estado_uf = e.uf
INNER JOIN Semestre s ON a.Matricula_numero = s.Aluno_Matricula_numero
INNER JOIN Semestre_Turma st ON s.id = st.Semestre_id
INNER JOIN Turma t ON st.turma_id = t.id
WHERE t.id = id
ORDER BY a.nome;