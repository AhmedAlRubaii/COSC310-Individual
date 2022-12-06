
import java.io.Serializable;
import java.util.UUID;

import javax.persistence.*;

@Entity
@Table(name = "User")
public class HUser implements Serializable {

    private static final long serialVersionID = 1L;

    @Id
    @Column(name = "userId", unique = true)
    private int userid;

    @Column(name = "first_name", nullable = false)
    private String first_name;

    @Column(name = "last_name", nullable = false)
    private String last_name;

    @Column(name = "key_uuid", nullable = false)
    private int kuuid;

    @Column(name = "password", nullable = false)
    private String password;

    public void setUserId(int userId){
        this.userid = userId;
    }

    public void setFirstName(String first_name){
        this.first_name = first_name;
    }

    public void setLastName(String last_name){
        this.last_name = last_name;
    }

    public void setKeyId(int kuuid){
        this.kuuid = kuuid;
    }

    public void setPassword(String password){
        this.password = password;
    }

    public int getUserId(){
        return userid;
    }

    public String getFirstName(){
        return first_name;
    }

    public String getLastName(){
        return last_name;
    }

    public int getkuuid(){
        return kuuid;
    }

    public String getPassword(){
        return password;
    }

  
}
