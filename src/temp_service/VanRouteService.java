package temp_service;

import com.airpremia.cloud.payment.domain.dto.VanRouteDto;
import com.airpremia.cloud.payment.entity.VanRoute;
import com.airpremia.cloud.payment.entity.VanRouteRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.*;

@AllArgsConstructor
@Service
public class VanRouteService {

//    private Logger logger = LoggerFactory.getLogger(VanRouteService.class);

    public VanRouteRepository vanRouteRepository;

    public static List<VanRouteDto> vanRouteDtoList;

    @Transactional
    public void initVanList() {
        List<VanRoute> vanRouteList = vanRouteRepository.findAll();

        System.out.println("vanRouteRepository.findAll() =======" + vanRouteRepository.findAll());

        vanRouteDtoList = new ArrayList<>();

        for ( VanRoute vanRouteEntity : vanRouteList) {
            VanRouteDto vanRouteDto = VanRouteDto.builder()
                    .van_code(vanRouteEntity.getVan_code())
                    .chanel(vanRouteEntity.getChanel())
                    .weight(vanRouteEntity.getWeight())
                    .build();

            vanRouteDtoList.add(vanRouteDto);
        }
    }

    public String getRandomVanCode(String param_chanel) {

        // chanel 적용 필요
        Map<String, Integer> array_ratio_per_van = new HashMap<String, Integer>();
        for(int i = 0; i < vanRouteDtoList.size(); i++){
            String van_code = vanRouteDtoList.get(i).getVan_code();
            String chanel = vanRouteDtoList.get(i).getChanel();
            int weight = Integer.valueOf(vanRouteDtoList.get(i).getWeight());
            if(chanel.equals(param_chanel)){
                array_ratio_per_van.put(van_code, weight);
            }else{
                return "";
            }
        }

        return weighted_random(array_ratio_per_van);
    }

    private static String weighted_random(Map<String, Integer> array_ratio_per_van) {

        Random random = new Random();
        int total = random.nextInt(sum_array(array_ratio_per_van));
        for(String key : array_ratio_per_van.keySet()){

            total -= array_ratio_per_van.get(key);
            if(total<1) return key;

        }
        return "";
    }

    private static int sum_array(Map<String,Integer> array_int_per_van){

        int total = 0;
        for(String key : array_int_per_van.keySet()){
            total += array_int_per_van.get(key);
        }
        return total;
    }

}
