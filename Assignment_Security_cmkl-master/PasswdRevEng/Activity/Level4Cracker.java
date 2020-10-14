public class Level4Cracker {
    
    /**
     * This function simulate typing in username and level4 password.
     * It then returns whether the username/password is correct or not.
     * STUDENT CAN USE THIS FUNCTION IN ANY WAYS THEY WANT.
     * @param username
     * @param password Level 4 password
     * @return whether the username/password is correct or not
     */
    public static boolean tryOnce(String username, String password) {
        LoginWindow.instance.usernameField.setText(username);
        LoginWindow.instance.level4Field.setText(password);
        LoginWindow.instance.level4Button.doClick();
        return LoginWindow.instance.level4CheckBox.isSelected();
    }
    
    public static void main(String args[]) {
        LoginWindow.run(); // STUDENT SHOULD NOT DELETE THIS LINE
        
        //TODO: STUDENT MAY MODIFY (EXPAND) THE CODE BELOW TO PERFORM BRUTE-FORCE SEARCH FOR 
        //      LEVEL4 PASSWORD PIN THAT CORRESPONDS TO THE STUDENT'S USERNAME
        
        String username = "qingxuan";
        int PIN = decryptLevel4(username);
        tryOnce(username, Integer.toString(PIN));
    }
    
    public static int decryptLevel4(String username) {
    	for (int PIN = 1000; PIN <10000; PIN++) {
    		if (Authentication.level4Authen(username, Integer.toString(PIN))) {
    			System.out.println("username: " + username);
    			System.out.println("PIN: " + PIN);
    			return PIN;
    		}
    	}
    	return -1;
    }
}











