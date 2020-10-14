import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

// TODO: change admin's pssword to P@ssw0rd

public class Sample
{
	private static Connection connection = null;
	
	/**
	 * Exit the program with an error flag 1 if we can't setup.
	 */
	private static void setupConnection() {
		try {
			if (connection == null) {
				connection = DriverManager.getConnection("jdbc:sqlite:sample.db");
				connection.setAutoCommit(false);
			}
		} catch (SQLException e) {
			System.err.println("Can't obtain the database connection.");
			System.exit(1);
		}
	}
	
	private static void initializeUsersTable() {
		
		try {
			Statement stmt = connection.createStatement();
			stmt.executeUpdate("CREATE TABLE Users (Username VARCHAR(8), Password VARCHAR(255), PRIMARY KEY (Username))");
			stmt.executeUpdate("INSERT INTO Users VALUES ('Adam', 'smith12')");
			stmt.executeUpdate("INSERT INTO Users VALUES ('Conan', 'doyle46')");
			stmt.executeUpdate("INSERT INTO Users VALUES ('Benjamin', 'franklin565')");
			stmt.executeUpdate("INSERT INTO Users VALUES ('Doris', 'day2014')");
			stmt.executeUpdate("INSERT INTO Users VALUES ('Ernest', 'hemingway555')");
			stmt.executeUpdate("INSERT INTO Users VALUES ('admin', 's3cur3D p455w0rD')");
			connection.commit();
		} catch (SQLException e) {
			// Most likely because the table Users already exists.
		}
	}
	
	/**
	 * 
	 * @param username
	 * @param password
	 * @return  true if the username/password matches. false otherwise
	 */
	private static boolean login(String username, String password) {
		try {
			Statement stmt = connection.createStatement();
			String queryString =
					"SELECT Username FROM Users WHERE Username = '" + username +
					"' AND Password = '" + password + "'";
			ResultSet rs = stmt.executeQuery(queryString);
			connection.commit();
			if (rs.next()) // There is some matching user in Users table
				return true;
			else
				return false;
		} catch (SQLException e) {
			return false;
		}
	}
	
	/**
	 * 
	 * @param username
	 * @param password
	 * @return  true if the username/password matches. false otherwise
	 */
	private static boolean improvedLogin(String username, String password) {
		try {
			Statement stmt = connection.createStatement();
			String queryString =
					"SELECT Username FROM Users WHERE Username = ? AND Password = ?";
			PreparedStatement prepStmt = connection.prepareStatement(queryString);
			prepStmt.setString(1,  username);
			prepStmt.setString(2,  password);
			ResultSet rs = prepStmt.executeQuery();
			connection.commit();
			if (rs.next()) // There is some matching user in Users table
				return true;
			else
				return false;
		} catch (SQLException e) {
			return false;
		}
	}
	
	/**
	 * 
	 * @param username
	 * @param password
	 * @return number of users registered.
	 */
	private static int register(String username, String password) {
		try {
			Statement stmt = connection.createStatement();
			String updateString =
					"INSERT INTO Users VALUES('" + username +
					"', '" + password + "')";
			System.out.println(updateString);
			int retVal = stmt.executeUpdate(updateString);
			connection.commit();
			return retVal;
		} catch (SQLException e) {
			return 0;
		}
	}
	
	public static void main(String[] args) throws ClassNotFoundException
	{
		// load the sqlite-JDBC driver using the current class loader
		Class.forName("org.sqlite.JDBC");
		Scanner stdin = new Scanner(System.in);

		try {
			// create a database connection
			setupConnection();
			boolean exit_chosen = false;
			do {
				System.out.println("Enter 1 to Register");
				System.out.println("Enter 2 to Login");
				System.out.println("Enter 0 to Exit");
				System.out.println("    Please enter your choice");
				String cmd = stdin.nextLine();
				if (cmd.equals("1")) {
					System.out.println("Please enter your username");
					String username = stdin.nextLine();
					System.out.println("Please enter your password");
					String password = stdin.nextLine();
					if (register(username, password) != 0)
						System.out.println("Successfully register!");
					else
						System.out.println("Something went wrong. Probably existing username.");
				} else if (cmd.equals("2")) {
					System.out.println("Please enter your username");
					String username = stdin.nextLine();
					System.out.println("Please enter your password");
					String password = stdin.nextLine();
					if (login(username, password)) {
						System.out.println("Successfully login!");
						exit_chosen = true;
					}
					else
						System.out.println("Wrong username/password combo!");
				} else if (cmd.equals("0")) {
					exit_chosen = true;
				}
			} while (!exit_chosen);
		} finally {
			try {
				if (connection != null)
					connection.close();
				stdin.close();
			} catch(SQLException e) {
				// connection close failed.
				System.err.println(e);
			}
		}
		System.out.println("Bye!");
	}
}
