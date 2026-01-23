package com.wa.erp;

import org.springframework.web.multipart.MultipartFile;

public class BuupDTO {
	
	private int desc_rank;
	private int b_no;
	private int p_no;
	private int resume_no;
	

	private String reg_date;
	private int read_count;
	private int rec_count;
	private String nickname;
	
	private String content;
	private String pwd;
	private String trade_type;
	private int price;
	private String name;
	private String indus;
	private int sales;
	private int sal_avg;
	private String hope_work;
	private String field_name;
	

	private String subject;	
	private String addr;
	private String addr1;
	private String addr2;
	private String addr3;
	private String phone;
	private String career;
	private String start_time;
	private String end_time;
	
	
	private String start_date;
	private String end_date;
	

	private String license_name1;
	private String license_name2;
	private String license_name3;
	private String license_name4;
	private String license_name5;

	private String career1;
	private String career2;
	private String career3;
	private String career4;
	private String career5;


	private MultipartFile img;
	private String img_name;
	private String isdel;
	
	
	
	public MultipartFile getImg() {
		return img;
	}
	public void setImg(MultipartFile img) {
		this.img = img;
	}
	public String getImg_name() {
		return img_name;
	}
	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}
	public String getIsdel() {
		return isdel;
	}
	public void setIsdel(String isdel) {
		this.isdel = isdel;
	}
	
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	public int getResume_no() {
		return resume_no;
	}
	public void setResume_no(int resume_no) {
		this.resume_no = resume_no;
	}

	public String getLicense_name1() {
		return license_name1;
	}
	public void setLicense_name1(String license_name1) {
		this.license_name1 = license_name1;
	}
	public String getLicense_name2() {
		return license_name2;
	}
	public void setLicense_name2(String license_name2) {
		this.license_name2 = license_name2;
	}
	public String getLicense_name3() {
		return license_name3;
	}
	public void setLicense_name3(String license_name3) {
		this.license_name3 = license_name3;
	}
	public String getLicense_name4() {
		return license_name4;
	}
	public void setLicense_name4(String license_name4) {
		this.license_name4 = license_name4;
	}
	public String getLicense_name5() {
		return license_name5;
	}
	public void setLicense_name5(String license_name5) {
		this.license_name5 = license_name5;
	}
	
	
	public String getCareer1() {
		return career1;
	}
	public void setCareer1(String career1) {
		this.career1 = career1;
	}
	public String getCareer2() {
		return career2;
	}
	public void setCareer2(String career2) {
		this.career2 = career2;
	}
	public String getCareer3() {
		return career3;
	}
	public void setCareer3(String career3) {
		this.career3 = career3;
	}
	public String getCareer4() {
		return career4;
	}
	public void setCareer4(String career4) {
		this.career4 = career4;
	}
	public String getCareer5() {
		return career5;
	}
	public void setCareer5(String career5) {
		this.career5 = career5;
	}
	
	
	
	
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	
	
	
	private String preferred_work;
	public int getDesc_rank() {
		return desc_rank;
	}
	public void setDesc_rank(int desc_rank) {
		this.desc_rank = desc_rank;
	}
	public int getB_no() {
		return b_no;
	}
	public void setB_no(int b_no) {
		this.b_no = b_no;
	}
	public int getP_no() {
		return p_no;
	}
	public void setP_no(int p_no) {
		this.p_no = p_no;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public int getRead_count() {
		return read_count;
	}
	public void setRead_count(int read_count) {
		this.read_count = read_count;
	}
	public int getRec_count() {
		return rec_count;
	}
	public void setRec_count(int rec_count) {
		this.rec_count = rec_count;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getTrade_type() {
		return trade_type;
	}
	public void setTrade_type(String trade_type) {
		this.trade_type = trade_type;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIndus() {
		return indus;
	}
	public void setIndus(String indus) {
		this.indus = indus;
	}
	public int getSales() {
		return sales;
	}
	public void setSales(int sales) {
		this.sales = sales;
	}
	public int getSal_avg() {
		return sal_avg;
	}
	public void setSal_avg(int sal_avg) {
		this.sal_avg = sal_avg;
	}
	public String getHope_work() {
		return hope_work;
	}
	public void setHope_work(String hope_work) {
		this.hope_work = hope_work;
	}
	public String getField_name() {
		return field_name;
	}
	public void setField_name(String field_name) {
		this.field_name = field_name;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
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
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getCareer() {
		return career;
	}
	public void setCareer(String career) {
		this.career = career;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public String getPreferred_work() {
		return preferred_work;
	}
	public void setPreferred_work(String preferred_work) {
		this.preferred_work = preferred_work;
	}
	
	
	
}
