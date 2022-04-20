import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import model.PostGet;
import model.PostGetItem;

import java.lang.reflect.Type;
import java.sql.*;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

public class DataService {


    public static PostGet getPostByUserId(String userId)  {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/linkedin","postgres","1");
            PreparedStatement preparedStatement = connection.prepareStatement("select * from get_user_posts(?) res");
            preparedStatement.setString(1,userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if(resultSet.next()) {
                String res = resultSet.getString("res");
                Gson gson=new Gson();
                Type typeToken=  new TypeToken<List<PostGetItem>>(){}.getType();
                List<PostGetItem> fromJson = gson.fromJson(res, typeToken);
                System.out.println(fromJson);
                return null;
            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        return null;
    }
}
