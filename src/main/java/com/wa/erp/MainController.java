package com.wa.erp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class MainController {

  @Autowired
  private GonggoDAO gonggoDAO;

  @RequestMapping(value = {"/"}, name = "메인")
  public String mainAction(Map<String, Object> model) {
    try {
      // 직무별 공고 수 TOP 5 가져오기
      List<Map<String, Object>> jobFieldTop5 = gonggoDAO.getJobFieldTop5();

      if (jobFieldTop5 != null && !jobFieldTop5.isEmpty()) {
        List<String> fieldNames = new ArrayList<>();
        List<Integer> fieldCounts = new ArrayList<>();

        for (Map<String, Object> item : jobFieldTop5) {
          String fieldName = (String) item.get("FIELD_NAME");
          Number cnt = (Number) item.get("CNT");
          if (fieldName != null && cnt != null) {
            fieldNames.add(fieldName);
            fieldCounts.add(cnt.intValue());
          }
        }

        // JavaScript 배열 형식으로 변환
        if (!fieldNames.isEmpty()) {
          StringBuilder fieldListStr = new StringBuilder("[");
          StringBuilder cntListStr = new StringBuilder("[");
          for (int i = 0; i < fieldNames.size(); i++) {
            if (i > 0) {
              fieldListStr.append(", ");
              cntListStr.append(", ");
            }
            fieldListStr.append("\"").append(fieldNames.get(i)).append("\"");
            cntListStr.append(fieldCounts.get(i));
          }
          fieldListStr.append("]");
          cntListStr.append("]");

          model.put("jobFieldList", fieldListStr.toString());
          model.put("jobFieldCntList", cntListStr.toString());
        }
      }
    } catch (Exception e) {
      // 에러 발생 시 기본값 사용 (JSP에서 처리)
      e.printStackTrace();
    }

    return "main.jsp";
  }

}
