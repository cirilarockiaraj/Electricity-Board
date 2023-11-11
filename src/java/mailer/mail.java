package mailer;
import java.util.Date;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class mail
{
    String host = "smtp.gmail.com";
    String port = "465";
    String username = "<your email>";
    String password = "<your password>";
    
    public boolean send(String toAddress, String subject, String message) throws AddressException, MessagingException {
        // sets SMTP server properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.transport.protocol", "smtp");
        properties.put("mail.user",username);
        properties.put("mail.password",password);

        // creates a new session with an authenticator
        Session ss = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });
        boolean flag=false;
        Message msg1 = prepareMessage(ss, username, toAddress, subject, message);
        try {
            Transport.send(msg1);
            flag=true;
        } catch (MessagingException e) {
            System.out.print("Mail Error : "+e);
        }
        return flag;
    }
    private static Message prepareMessage(Session ss, String username, String to, String subject, String message) {
        MimeMessage msg = new MimeMessage(ss);
        try {
            msg.setFrom(new InternetAddress(username));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            msg.setSubject(subject);
            msg.setSentDate(new Date());
            msg.setText(message);
        } catch (MessagingException e) {
        }
        return msg;
    }
}
