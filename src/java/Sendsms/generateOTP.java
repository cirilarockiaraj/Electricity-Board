package Sendsms;
import java.util.Random;

public class generateOTP {

    public String OTP() {
        String numbers = "1234567890";
        Random random = new Random();
        int length = 5;
        String otp="";

        for (int i = 0; i < length; i++) {
            otp += random.nextInt(numbers.length());
        }
        return otp;
    }
}
