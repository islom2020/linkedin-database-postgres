import lombok.Data;

@Data
public class Post {
    byte[] content;
    String content_type;
    String name;
    long size;
}
