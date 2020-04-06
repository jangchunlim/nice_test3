package temp_entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Data
@Embeddable
public class VanRouteID implements Serializable {

    @Column
    private String van_code;

    @Column
    private String chanel;
}
