package temp_domain.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@ToString
@Getter
@JsonInclude(JsonInclude.Include.NON_NULL)
public class VanInfoDto {

    @JsonProperty("van_code") private String van_code;
    @JsonProperty("authentication_rul") private String authentication_rul;
    @JsonProperty("authorization_url") private String authorization_url;
    @JsonProperty("refund_url") private String refund_url;


    @Builder
    public VanInfoDto(String van_code, String weight, String authentication_rul, String authorization_url, String refund_url){
        this.van_code = van_code;
        this.authentication_rul = authentication_rul;
        this.authorization_url = authorization_url;
        this.refund_url = refund_url;

    }
}
