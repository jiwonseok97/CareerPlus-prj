package com.wa.erp;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@Controller
public class MainController {

  @RequestMapping(value = {"/"}, name = "메인")
  public String mainAction(Map<String, Object> model) {
    return "main";
  }

}
