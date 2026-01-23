package com.wa.erp;

import java.sql.Date;
import java.util.List;

public class MemberDTO {
	private String pid;
	private String writer;
	private String pwd;
	private List<String> skill;
	/*------회사 가입------*/
	private int c_no;
	private String business_no;
	private String cid;
	private String name;
	private String call;
	private String ceo_name;
	private String ceo_phone;
	private String email;
	private String email1;
	private String email2;
	/*-------------------*/

	/*------회사 정보------*/
	private int mem_c_no;
	private Date birth;
	private int emp_no;
	private int sales;
	private String addr1;
	private String addr2;
	private String addr3;
	private int sal_avg;
	private String url;
	private String volume;
	private String business_industry;
	private List<String> welfare_code;
	/*-------------------*/
	private String jumin_num1;
	private String jumin_num2;
	private String phone;
	private int field_code;
	private String is_job;
	private String nickname;
	private String sex;
	private int age;
	private String rec_count;
	
	
	
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public List<String> getSkill() {
		return skill;
	}
	public void setSkill(List<String> skill) {
		this.skill = skill;
	}
	public int getC_no() {
		return c_no;
	}
	public void setC_no(int c_no) {
		this.c_no = c_no;
	}
	public String getBusiness_no() {
		return business_no;
	}
	public void setBusiness_no(String business_no) {
		this.business_no = business_no;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCall() {
		return call;
	}
	public void setCall(String call) {
		this.call = call;
	}
	public String getCeo_name() {
		return ceo_name;
	}
	public void setCeo_name(String ceo_name) {
		this.ceo_name = ceo_name;
	}
	public String getCeo_phone() {
		return ceo_phone;
	}
	public void setCeo_phone(String ceo_phone) {
		this.ceo_phone = ceo_phone;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public int getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}
	public int getSales() {
		return sales;
	}
	public void setSales(int sales) {
		this.sales = sales;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getAddr3() {
		return addr3;
	}
	public void setAddr3(String addr3) {
		this.addr3 = addr3;
	}
	public int getSal_avg() {
		return sal_avg;
	}
	public void setSal_avg(int sal_avg) {
		this.sal_avg = sal_avg;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getVolume() {
		return volume;
	}
	public void setVolume(String volume) {
		this.volume = volume;
	}
	public String getBusiness_industry() {
		return business_industry;
	}
	public void setBusiness_industry(String business_industry) {
		this.business_industry = business_industry;
	}
	public List<String> getWelfare_code() {
		return welfare_code;
	}
	public void setWelfare_code(List<String> welfare_code) {
		this.welfare_code = welfare_code;
	}
	public String getJumin_num1() {
		return jumin_num1;
	}
	public void setJumin_num1(String jumin_num1) {
		this.jumin_num1 = jumin_num1;
	}
	public String getJumin_num2() {
		return jumin_num2;
	}
	public void setJumin_num2(String jumin_num2) {
		this.jumin_num2 = jumin_num2;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getField_code() {
		return field_code;
	}
	public void setField_code(int field_code) {
		this.field_code = field_code;
	}
	public String getIs_job() {
		return is_job;
	}
	public void setIs_job(String is_job) {
		this.is_job = is_job;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public int getMem_c_no() {
		return mem_c_no;
	}
	public void setMem_c_no(int mem_c_no) {
		this.mem_c_no = mem_c_no;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getRec_count() {
		return rec_count;
	}
	public void setRec_count(String rec_count) {
		this.rec_count = rec_count;
	}
	   
	   
	
}
