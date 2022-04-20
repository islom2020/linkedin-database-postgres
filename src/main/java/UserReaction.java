import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.UUID;

@Data
public class UserReaction {

    @JsonProperty("user_id")
    UUID userId;
    int reaction_type;
    @JsonProperty("user_avatar")
    byte[] avatar;
    @JsonProperty("i_about")
    String about;
    @JsonProperty("user_name")
    String username;

}
