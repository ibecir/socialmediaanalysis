package ba.ibu.edu.helper;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordConversion {

	public static final String hashPassword(String password) throws NoSuchAlgorithmException {

		MessageDigest convertPasswordToMd5Hash = MessageDigest.getInstance("MD5");
		convertPasswordToMd5Hash.update(password.getBytes());

		byte passwordInBytes[] = convertPasswordToMd5Hash.digest();

		StringBuffer hashedPassword = new StringBuffer();

		for (int i = 0; i < passwordInBytes.length; i++) {
			hashedPassword.append(Integer.toString((passwordInBytes[i] & 0xff) + 0x100, 16).substring(1));
		}
		System.out.println("Password is converted to ### " + hashedPassword.toString());
		return hashedPassword.toString();
	}
}
