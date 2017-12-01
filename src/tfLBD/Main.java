import java.sql.*;
import java.util.*;
public class Main {
	public static void main(String[] args){
		
		MyConnection minhaconexao = new MyConnection();
		
		int option = 0;
		boolean trigger = true;
		while(trigger){
			System.out.println("Selecione uma opção: ");
			System.out.println("1 - para a questão 1");
			Scanner sc = new Scanner(System.in);
			option = sc.nextInt();
			switch(option){
			case 1:
				minhaconexao.selectJoinQuestao1();
				break;
			}
		}
		
		
	}
}
