package edu.sm.controller;

import edu.sm.app.dto.Content;
import edu.sm.app.dto.Marker;
import edu.sm.app.dto.Search;
import edu.sm.app.service.MarkerService;
import edu.sm.app.dto.Order;
import java.util.List;
import edu.sm.app.service.OrderService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import java.util.HashMap; // HashMap을 사용하기 위해 추가
import java.util.Map;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@RestController
@RequiredArgsConstructor
@Slf4j
public class ChartRestController {

    private final OrderService orderService;

    @RequestMapping("/chart2_1")
    public Object chart2_1() throws Exception{
        JSONArray jsonArray = new JSONArray();
        String [] nation = {"Kor","Eng","Jap","Chn","Usa"};
        Random random = new Random();
        for (int i = 0; i < nation.length; i++) {
            JSONArray jsonArray1 = new JSONArray();
            jsonArray1.add(nation[i]);
            jsonArray1.add(random.nextInt(100)+1);
            jsonArray.add(jsonArray1);
        }

        return jsonArray;
    }

    @RequestMapping("/chart2_2")
    public Object chart2_2() throws Exception{
        JSONObject jsonObject = new JSONObject();
        String arr [] = {"0-9", "10-19", "20-29", "30-39", "40-49", "50-59", "60-69",
                "70-79", "80-89", "90+"};
        jsonObject.put("cate", arr);
        Random random = new Random();
        JSONArray jsonArray = new JSONArray();
        for (int i = 0; i< arr.length; i++){
            jsonArray.add(random.nextInt(100)+1);
        }
        jsonObject.put("data", jsonArray);
        return jsonObject;
    }

    @RequestMapping("/chart2_3")
    public Object chart2_3() throws Exception {
        // 1. JavaScript에 있던 원본 텍스트를 Java 변수에 저장합니다.
        String text = "메츠의 부진이 더 놀라운 이유는 이번 시즌 엄청난 돈을 썼을 뿐만 아니라 트레이드 데드 라인에도 가장 바쁘게 움직인 팀 중 하나였기 때문이다." +
                "지난 겨울 후안 소토를 7억 6,500만 달러(약 1조 664억 원)에 영입했던 메츠는 우승을 위해 클레이 홈즈, 션 머네야, 프랭키 몬타스 등 선발진도 대거 보강했다. 여름에는 트레버 로저스, 라이언 헬슬리 등 불펜 투수를 트레이드로 데려와 월드시리즈 우승을 향한 승부수를 띄웠다." +
                "메츠의 예상대로 소토는 1인분은 충분히 해냈다. 주루 능력까지 발전한 그는 생애 처음으로 40홈런-30도루 고지에 올랐다. 오타니 쇼헤이(LA 다저스)만 아니었다면 내셔널리그 MVP 경쟁을 충분히 벌일 수 있는 수준이다." +
                "하지만 여름에 데려왔던 불펜이 문제였다. 헬슬리, 로저스 모두 이적 전보다 성적이 더 떨어졌다. 특히 헬슬리는 마이너스에 가까운 모습이다. 결국 단 한 번의 잘못된 선택이 메츠의 가을 야구를 빼앗아 가는 결과로 다가왔다.";
        // 2. 텍스트에서 특수문자와 숫자를 제거하고, 공백 또는 마침표(.)를 기준으로 단어를 분리하여 배열로 만듭니다.
        String cleanedText = text.replaceAll("[():'?0-9]", ""); // 정규식으로 불필요한 문자 제거
        String[] words = cleanedText.split("[\\s.,]+"); // 공백, 쉼표, 마침표 기준으로 단어 분리

        // 3. 각 단어의 빈도수를 계산하기 위해 Map을 사용합니다.
        Map<String, Integer> wordCounts = new HashMap<>();
        for (String word : words) {
            if (word.isEmpty()) { // 분리 과정에서 생긴 공백 단어는 건너뜁니다.
                continue;
            }
            // getOrDefault: 단어가 이미 Map에 있으면 기존 횟수를, 없으면 0을 가져온 뒤 +1을 해서 다시 저장합니다.
            wordCounts.put(word, wordCounts.getOrDefault(word, 0) + 1);
        }

        // 4. Highcharts가 요구하는 JSON 형식(JSONArray)으로 데이터를 변환합니다.
        JSONArray finalJsonArray = new JSONArray();
        for (Map.Entry<String, Integer> entry : wordCounts.entrySet()) {
            JSONObject wordObject = new JSONObject();
            wordObject.put("name", entry.getKey());     // 단어
            wordObject.put("weight", entry.getValue()); // 빈도수
            finalJsonArray.add(wordObject);
        }

        // 5. 완성된 JSON 배열을 반환합니다.
        return finalJsonArray;
    }


    @RequestMapping("/chart1")
    public Object chart1() throws Exception {
        // []
        JSONArray jsonArray = new JSONArray();

        // {}
        JSONObject jsonObject1 = new JSONObject();
        JSONObject jsonObject2 = new JSONObject();
        JSONObject jsonObject3 = new JSONObject();
        jsonObject1.put("name","Korea");
        jsonObject2.put("name","Japan");
        jsonObject3.put("name","China");
        // []
        JSONArray data1Array = new JSONArray();
        JSONArray data2Array = new JSONArray();
        JSONArray data3Array = new JSONArray();

        Random random = new Random();
        for(int i=0;i<12;i++){
            data1Array.add(random.nextInt(100)+1);
            data2Array.add(random.nextInt(100)+1);
            data3Array.add(random.nextInt(100)+1);
        }
        jsonObject1.put("data",data1Array);
        jsonObject2.put("data",data2Array);
        jsonObject3.put("data",data3Array);

        jsonArray.add(jsonObject1);
        jsonArray.add(jsonObject2);
        jsonArray.add(jsonObject3);
        return  jsonArray;
    }
    @RequestMapping("/chart2_4")
    public Object chart2_4() throws Exception{
        JSONArray jsonArray = new JSONArray();
        JSONObject jsonObject1 = new JSONObject();
        JSONObject jsonObject2 = new JSONObject();
        JSONObject jsonObject3 = new JSONObject();
        jsonObject1.put("name","Kor");
        jsonObject2.put("name","Eng");
        jsonObject3.put("name","Japan");
        return jsonArray;
    }

    @RequestMapping("/chart3_1")
    public List<Order> getMonthlyTotalSales() { // [수정] 반환 타입 변경
        return orderService.getMonthlySales();
    }

    @RequestMapping("/chart3_2")
    public List<Order> getMonthlyAverageSales() { // [수정] 반환 타입 변경
        return orderService.getMonthlySales();
    }

}