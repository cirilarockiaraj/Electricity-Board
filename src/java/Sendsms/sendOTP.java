package Sendsms;

import java.io.*;
import java.net.*;

public class sendOTP {

    public String sendSms(String msg, String num) {
        try {
            // Construct data
            String apiKey = "apikey=" + URLEncoder.encode("NDU1NjZlNGY0Yjc5NDE0NjRlNzk3MDcwNzg3MDUwNjg=", "UTF-8");
            String message = "&message=" + URLEncoder.encode(msg, "UTF-8");
            String sender = "&sender=" + URLEncoder.encode("TXTLCL", "UTF-8");
            String numbers = "&numbers=" + URLEncoder.encode(num, "UTF-8");

            // Send data
            String data = "https://api.textlocal.in/send/?" + apiKey + numbers + message + sender;
            URL url = new URL(data);
            URLConnection conn = url.openConnection();
            conn.setDoOutput(true);

            // Get the response
            BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line;
            String sResult = "";
            while ((line = rd.readLine()) != null) {
                // Process line...
                sResult = sResult + line + " ";
            }
            rd.close();

            return sResult;
        } catch (IOException e) {
            System.out.println("Error SMS " + e);
            return "Error " + e;
        }
    }
}
