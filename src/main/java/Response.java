import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.util.ArrayList;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class Response {
    private String id;
    private String title;

    private ArrayList<Attachments> attachments;
}

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
class Attachments{
    private String name;
    private String contentType;
    private long size;
    private byte[] content;

}
