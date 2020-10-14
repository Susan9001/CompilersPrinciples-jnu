import java.io.IOException;
import java.security.MessageDigest;

// qingxuan kuang

public class Authentication {
    private static String mystery(String in) {
        String out = "";
        for (int i = in.length() - 1; i >= 0; i = i - 1) {
            out = out + in.charAt(i); // plus sign means concatenation
        }
        return out;
    }
    
    public static boolean level1Authen(String username, String password) {
        if (password.length() > 0 && password.equals(mystery(username))) {
            return true;
        } else {
            return false;
        }
    }
    
    public static boolean level2Authen(String username, String password) {
        int mysteryNumber = username.hashCode() % Level2.passwords.length;
        mysteryNumber = mysteryNumber + Level2.passwords.length;
        mysteryNumber = mysteryNumber % Level2.passwords.length;

        String correctPassword = Level2.passwords[mysteryNumber];
        if (password.equals(correctPassword)) {
            return true;
        } else {
            return false;
        }
    }
    
    /**
     * This function returns an MD5 hash code of the given password.
     * STUDENTS DO NOT NEED TO UNDERSTAND THE CODE OF THIS FUNCTION.
     * STUDENTS SHOULD NOTICE THAT MD5 IS A WELL-KNOWN HASH FUNCTION.
     */
    private static String MD5OfString(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(password.getBytes());
            byte[] digest = md.digest();
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < digest.length; i = i + 1) {
                String hexString = Integer.toHexString(digest[i] & 0xff);
                if (hexString.length() < 2) {
                    hexString = "0" + hexString;
                }
                sb.append(hexString);
            }
            return sb.toString();
        } catch (Exception e) {
            return "";
        }
    }
    
    public static boolean level3Authen(String username, String password) {
        int mysteryNumber = username.hashCode() % Level3.passwordMD5s.length;
        mysteryNumber = mysteryNumber + Level3.passwordMD5s.length;
        mysteryNumber = mysteryNumber % Level3.passwordMD5s.length;
        
        String correctPasswordMD5 = Level3.passwordMD5s[mysteryNumber];
        String enteredPasswordMD5 = MD5OfString(password);
        System.out.println("L3: You entered " + password + " and its MD5 is " + enteredPasswordMD5);
        if (enteredPasswordMD5.equals(correctPasswordMD5)) {
            return true;
        } else {
//        	System.out.print("Brute Force Decrypt?(Y/N):");
//        	try {
//				char ch = (char) System.in.read();
//				if (ch == 'Y' || ch == 'y') {
//					String possiblePassword = decryptMD5_ch(correctPasswordMD5, 7);
//					System.out.println("result: " + possiblePassword);
//				}
//        	} catch(IOException e) {
//        	}
            return false;
        }
    }

    /**
     * brute force of MD5 for the password
     * @param MD5Hash
     * @param n: the maximine length of target password
     * @return password
     */
    private static String decryptMD5_ch(String MD5Hash, int n) {
    	String password = "";
    	password = helpDecryptMD5_ch(MD5Hash, password, n);
    	return password;
    }
    
    private static String helpDecryptMD5_ch(String MD5Hash, String password, int n) {
		String passwordMD5 = MD5OfString(password);
		System.out.println("password: " + password);
		System.out.println("MD5: " + passwordMD5);
		if (passwordMD5.equals(MD5Hash)) {
			return password;
		}
		if (n <= 0) {
			return "";
		}
		int len = password.length(); 
		for (char ch = 'a'; ch <= 'z'; ch++) {
			password += String.valueOf(ch);
			String resPassword = helpDecryptMD5_ch(MD5Hash, password, n - 1);
			if (!resPassword.isEmpty()) {
				return resPassword;
			}
			password = password.substring(0, len);
		}
		return "";
    }
    
    /**
     * This function returns a mysterious hash code of the given password.
     * STUDENTS DO NOT NEED TO UNDERSTAND THE CODE OF THIS FUNCTION.
     */
    private static String mysteriousHashOfString(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(password.getBytes());
            byte[] digest = md.digest();
            byte mystery = 0;
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < digest.length; i = i + 1) {
                mystery = (byte) (digest[i] ^ mystery);
                String hexString = Integer.toHexString(mystery & 0xff);
                if (hexString.length() < 2) {
                    hexString = "0" + hexString;
                }
                sb.append(hexString);
            }
            return sb.toString();
        } catch (Exception e) {
            return "";
        }
    }
    
    public static boolean level4Authen(String username, String password) {
        int mysteryNumber = username.hashCode() % Level4.passwordHashs.length;
        mysteryNumber = mysteryNumber + Level4.passwordHashs.length;
        mysteryNumber = mysteryNumber % Level4.passwordHashs.length;
        
        String correctPasswordHash = Level4.passwordHashs[mysteryNumber];
        String enteredPasswordHash = mysteriousHashOfString(password);
        System.out.println("L4: You entered " + password + " and its hash code is " + enteredPasswordHash);
        if (enteredPasswordHash.equals(correctPasswordHash)) {
            return true;
        } else {
            return false;
        }
    }
}
