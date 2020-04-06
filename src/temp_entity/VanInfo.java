package temp_entity;

import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.time.LocalDateTime;

@ToString
@Getter
@Entity
public class VanInfo {

    @Id
    private String van_code;
    private String van_name;
    private String authentication_rul;
    private String authorization_url;
    private String refund_url;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;



    @Builder
    public VanInfo VanInfoEntity(String van_code, String van_name, String weight, String authentication_rul, String authorization_url, String refund_url, LocalDateTime created_at, LocalDateTime updated_at){
        this.van_code = van_code;
        this.van_name = van_name;
        this.authentication_rul = authentication_rul;
        this.authorization_url = authorization_url;
        this.refund_url = refund_url;
        this.created_at = created_at;
        this.updated_at = updated_at;
        return this;
    }

}
