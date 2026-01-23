package com.wa.erp;

import java.util.Map;

public interface LoginService {
	
	
	public BoardDTO getMem(Map<String,String> midPwd);
	
	public int checkpercom(Map<String,String> midPwd);

	public int getIs_resume(Map<String, String> map);

	public int getIs_info(Map<String, String> map);
	}
