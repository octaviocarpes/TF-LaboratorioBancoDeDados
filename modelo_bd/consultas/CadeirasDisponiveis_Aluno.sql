SELECT cs.nome as curso, d.nome as disciplina, cd.nivel FROM DISCIPLINA d
INNER JOIN CURSO_DISCIPLINA cd ON cd.DISCIPLINA_ID = d.id
INNER JOIN CURSO cs ON cd.curso_id = cs.id
INNER JOIN ALUNO a ON cs.id = a.curso_id
WHERE UPPER(a.nome) like 'NAME%' AND d.id NOT IN (
    SELECT d.id FROM Disciplina d
    INNER JOIN Avaliacao av ON d.id = av.DISCIPLINA_ID
    INNER JOIN Semestre s ON av.semestre_id = s.id
    WHERE s.atual = 0 AND UPPER(a.nome) like 'NAME%'
)
ORDER BY cd.nivel, d.nome;