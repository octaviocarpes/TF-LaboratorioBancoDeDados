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
	
	
	public void selectJoinQuestao1(){
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
