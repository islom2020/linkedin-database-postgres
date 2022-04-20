import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.SneakyThrows;
import org.telegram.telegrambots.bots.TelegramLongPollingBot;
import org.telegram.telegrambots.meta.api.methods.send.SendPhoto;
import org.telegram.telegrambots.meta.api.objects.InputFile;
import org.telegram.telegrambots.meta.api.objects.Update;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;
import java.sql.*;
import java.util.Arrays;
import java.util.Base64;

public class MyBot extends TelegramLongPollingBot {


    @Override
    public String getBotUsername() {
        return "@JavaPDP_BOT";
    }

    @Override
    public String getBotToken() {
        return "5035972181:AAHiQxWL0D2mUDuqMX8xy59Ndw9C8KmG598";
    }

    @SneakyThrows
    @Override
    public void onUpdateReceived(Update update) {
        if (update.hasMessage()){
            String text = update.getMessage().getText();
            if (text.equals("/start")){

                File file = new File("C:\\Users\\User\\Desktop\\aaaaaaaaaabb.txt");
                file.createNewFile();
                FileOutputStream fileOutputStream = new FileOutputStream(file);
                fileOutputStream.write(getContent());
                fileOutputStream.close();

//                SendPhoto sendPhoto = new SendPhoto();
//                sendPhoto.setCaption("Farrux");
//                sendPhoto.setChatId(update.getMessage().getChatId().toString());
//                InputFile inputFile = new InputFile(new ByteArrayInputStream(getContent()),"aaa");
//                sendPhoto.setPhoto(inputFile);
//
////                ByteArrayInputStream bis = new ByteArrayInputStream(getContent());
////                BufferedImage bImage2 = ImageIO.read(bis);
////                ImageIO.write(bImage2, "jpg", new File("output.jpg") );
//                execute(sendPhoto);
            }
        }
    }

    private static byte[] getContent() throws SQLException, JsonProcessingException {
        Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/linkedin","postgres","1");
        PreparedStatement preparedStatement = connection.prepareStatement("select * from attachment_content where id = (?)::uuid");
        preparedStatement.setString(1,"c7cc51a0-6ce3-409e-9d98-944db65b615b");
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();
        resultSet.getBytes("content");



//        ObjectMapper objectMapper = new ObjectMapper();
//        Response[] responses = objectMapper.readValue(resultSet.getString(1), Response[].class);

        connection.close();
//        return responses[0].getAttachments().get(0).getContent();
        byte[] res = resultSet.getBytes("content");
        return res;
    }
}
