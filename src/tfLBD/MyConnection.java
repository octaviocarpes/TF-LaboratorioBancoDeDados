package tfLBD;

import java.sql.*;
public class MyConnection {
	private Connection myConnection;
	
	public MyConnection(){
		try {
			myConnection = DriverManager.getConnection("jdbc:oracle:thin:@//camburi.pucrs.br:1521/facin11g","BD202108","kbda8456");
			System.out.println("Conected to the Database!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	
	
	public void selectJoinQuestao1() {
		try {
			PreparedStatement stmt = myConnection.prepareStatement(
					"SELECT m.numero, a.nome, a.genero, a.data_nasc, a.email, a.endereco, c.nome, e.nome"
							+ " FROM Aluno a"
							+ "INNER JOIN Matricula m ON a.Matricula_numero = m.numero"
							+ "INNER JOIN Cidade c ON a.Cidade_id = c.id"
							+ "INNER JOIN Estado e ON c.Estado_uf = e.uf"
							+ "INNER JOIN Curso cs ON a.Curso_id = cs.id"
							+ "WHERE cs.id = id"
							+ "ORDER BY a.nome;");

			ResultSet resultSet = stmt.executeQuery();

			while (resultSet.next()) {
				System.out.println(resultSet.getString(0) + " - " + resultSet.getString(1));
			}


		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

		public void select_Alunos_Disciplina(){
			try {
				PreparedStatement stmt = myConnection.prepareStatement("" +
						"SELECT m.numero as matricula, a.nome as nome, a.genero, a.data_nasc, a.email, a.endereco, c.nome as cidade, e.nome as estado\n" +
						"FROM Aluno a\n" +
						"INNER JOIN Matricula m ON a.Matricula_numero = m.numero\n" +
						"INNER JOIN Cidade c ON a.Cidade_id = c.id\n" +
						"INNER JOIN Estado e ON c.Estado_uf = e.uf\n" +
						"INNER JOIN Semestre s ON a.Matricula_numero = s.Aluno_Matricula_numero\n" +
						"INNER JOIN Semestre_Disciplina sd ON s.id = sd.Semestre_id\n" +
						"INNER JOIN Disciplina d ON sd.turma_id = d.id\n" +
						"WHERE d.id = id\n" +
						"ORDER BY a.nome;");

				ResultSet resultSet = stmt.executeQuery();

				while(resultSet.next()){
					System.out.println(resultSet.getString(0) +" - "+ resultSet.getString(1) );
				}


			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}


	public void select_AlunosSemestre(){
		try {
			PreparedStatement stmt = myConnection.prepareStatement("" +
					"SELECT m.numero as matricula, a.nome, a.genero, a.data_nasc, a.email, a.endereco, c.nome as cidade, e.nome as estado, cs.nome as curso, s.trancado\n" +
					"FROM Aluno a\n" +
					"INNER JOIN Matricula m ON a.Matricula_numero = m.numero\n" +
					"INNER JOIN Cidade c ON a.Cidade_id = c.id\n" +
					"INNER JOIN Estado e ON c.Estado_uf = e.uf\n" +
					"INNER JOIN Curso cs ON a.Curso_id = cs.id\n" +
					"INNER JOIN Semestre s ON a.Matricula_numero = s.Aluno_Matricula_numero\n" +
					"WHERE s.periodo = periodo\n" +
					"ORDER BY a.nome;");

			ResultSet resultSet = stmt.executeQuery();

			while(resultSet.next()){
				System.out.println(resultSet.getString(0) +" - "+ resultSet.getString(1) );
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void select_Alunos_SemestreAtural(){
		try {
			PreparedStatement stmt = myConnection.prepareStatement("" +
					"SELECT m.numero as matricula, a.nome, a.genero, a.data_nasc, a.email, a.endereco, c.nome as cidade, e.nome as estado, cs.nome as curso\n" +
					"FROM Aluno a\n" +
					"INNER JOIN Matricula m ON a.Matricula_numero = m.numero\n" +
					"INNER JOIN Cidade c ON a.Cidade_id = c.id\n" +
					"INNER JOIN Estado e ON c.Estado_uf = e.uf\n" +
					"INNER JOIN Curso cs ON a.Curso_id = cs.id\n" +
					"INNER JOIN Semestre s ON a.Matricula_numero = s.Aluno_Matricula_numero\n" +
					"WHERE s.atual = 1\n" +
					"ORDER BY a.nome;");

			ResultSet resultSet = stmt.executeQuery();

			while(resultSet.next()){
				System.out.println(resultSet.getString(0) +" - "+ resultSet.getString(1) );
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void select_Alunos_Turma(){
		try {
			PreparedStatement stmt = myConnection.prepareStatement("" +
					"SELECT m.numero as matricula, a.nome, a.genero, a.data_nasc, a.email, a.endereco, c.nome as cidade, e.nome as estado\n" +
					"FROM Aluno a\n" +
					"INNER JOIN Matricula m ON a.Matricula_numero = m.numero\n" +
					"INNER JOIN Cidade c ON a.Cidade_id = c.id\n" +
					"INNER JOIN Estado e ON c.Estado_uf = e.uf\n" +
					"INNER JOIN Semestre s ON a.Matricula_numero = s.Aluno_Matricula_numero\n" +
					"INNER JOIN Semestre_Turma st ON s.id = st.Semestre_id\n" +
					"INNER JOIN Turma t ON st.turma_id = t.id\n" +
					"WHERE t.id = id\n" +
					"ORDER BY a.nome;");

			ResultSet resultSet = stmt.executeQuery();

			while(resultSet.next()){
				System.out.println(resultSet.getString(0) +" - "+ resultSet.getString(1) );
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void select_CadeirasDisponiveis_Aluno(){
		try {
			PreparedStatement stmt = myConnection.prepareStatement("" +
					"SELECT cs.nome as curso, d.nome as disciplina, cd.nivel FROM DISCIPLINA d\n" +
					"INNER JOIN CURSO_DISCIPLINA cd ON cd.DISCIPLINA_ID = d.id\n" +
					"INNER JOIN CURSO cs ON cd.curso_id = cs.id\n" +
					"INNER JOIN ALUNO a ON cs.id = a.curso_id\n" +
					"WHERE UPPER(a.nome) like 'NAME%' AND d.id NOT IN (\n" +
					"    SELECT d.id FROM Disciplina d\n" +
					"    INNER JOIN Avaliacao av ON d.id = av.DISCIPLINA_ID\n" +
					"    INNER JOIN Semestre s ON av.semestre_id = s.id\n" +
					"    WHERE s.atual = 0 AND UPPER(a.nome) like 'NAME%'\n" +
					")\n" +
					"ORDER BY cd.nivel, d.nome;");

			ResultSet resultSet = stmt.executeQuery();

			while(resultSet.next()){
				System.out.println(resultSet.getString(0) +" - "+ resultSet.getString(1) );
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	
	public void closeConnection(){
		try {
			myConnection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
