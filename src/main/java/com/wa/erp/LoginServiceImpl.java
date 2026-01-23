package com.wa.erp;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class LoginServiceImpl implements LoginService{

	@Autowired
	private LoginDAO loginDAO;
	
	public BoardDTO getMem(Map<String,String> midPwd) {
		BoardDTO getMem = this.loginDAO.getMem(midPwd);
		
		return getMem;
	}
	
	public int checkpercom(Map<String,String> midPwd) {
		
		int checkpid = this.loginDAO.checkpid(midPwd);
		if(checkpid==1) {return 1;}
		
		int checkcid = this.loginDAO.checkcid(midPwd);
		if (checkcid==1) {return 2;}
		
		int checkaid = this.loginDAO.checkaid(midPwd);
		if (checkaid==1) {return 5;}
		
		return 0;
	}
	
	public int getIs_resume(Map<String, String> map) {
		int is_resume = this.loginDAO.getIs_resume(map);
		
		return is_resume;
	}

	public int getIs_info(Map<String, String> map) {
		int is_info = this.loginDAO.getIs_info(map);
		
		return is_info;
	}
	
}
