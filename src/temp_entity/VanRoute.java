package temp_entity;


import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@ToString
@Getter
@Entity
public class VanRoute {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int seq_No;
    private String van_code;
    private String chanel;
    private int weight;

    @Builder
    public VanRoute VanRouteEntity(int seq_No, String van_code, String chanel, int weight){
        this.seq_No = seq_No;
        this.van_code = van_code;
        this.chanel = chanel;
        this.weight = weight;
        return this;
    }

}



/*import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;

@ToString
@Getter

public class VanRoute {
    @EmbeddedId
    private VanRouteID vanRouteID;
    @Column
    private int weight;

    @Builder
    public VanRoute VanRouteEntity(VanRouteID vanRouteId, int weight){
        this.vanRouteID = vanRouteId;
        this.weight = weight;
        return this;
    }
}*/

