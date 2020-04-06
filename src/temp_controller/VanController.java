package temp_controller;

import com.airpremia.cloud.payment.ApPaymentApplication;
import com.airpremia.cloud.payment.service.VanRouteService;
import lombok.AllArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@AllArgsConstructor
@RestController
public class VanController {

    private final Logger logger = LoggerFactory.getLogger(ApPaymentApplication.class);

    private VanRouteService vanRouteService;

//    @PostMapping("/v1/vaninfo/init-route")
    @RequestMapping(value = "/v1/vaninfo/init-route", method= {RequestMethod.POST, RequestMethod.GET})
    public void initVanInfo(){
        vanRouteService.initVanList();
    }
}
