
package temp_domain.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@ToString
@Getter
@JsonInclude(JsonInclude.Include.NON_NULL)
public class VanRouteDto {

    @JsonProperty("seq_No") private int seq_No;
    @JsonProperty("van_code") private String van_code;
    @JsonProperty("chanel") private String chanel;
    @JsonProperty("weight") private int weight;

    @Builder
    public VanRouteDto(String van_code, String chanel, int weight){
        this.seq_No = seq_No;
        this.van_code = van_code;
        this.chanel = chanel;
        this.weight = weight;

    }
}


/*

@Data
@Entity
public class VanRouteDto_temp {
    @EmbeddedId
    private VanRouteID vanRouteID;
    private String weight;

}
*/
