package com.wa.erp;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class BoardDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private int desc_rank;
	private int admin_no;
	private int c_no;
	private int n_no;
	private int b_no;
	private int p_no;
	private int r_no;
	private String cid;
	private String table;
	private String reg_date;
	private int read_count;
	private int rec_count;
	private String nickname;
	private String subject;
	private String content;
	private String addr;
	private String pwd;
	private String trade_type;
	private int price;
	private String name;
	private String indus;
	private int sales;
	private int sal_avg;
	private String hope_work;
	private String field_name;
	private String phone;
	private String preferred_work;
	private String start_time;
	private String end_time;
	private String career;
	private int star;
	private String star_avg;
    private int rating;
    private String url;
	private String email;
	private String volume;
	private String emp_no;
	private String birth;
	private String ceo_name;
	private String call;
	private String married;
	private String military;
	private String name1;
	private String name2;
	private String name3;
	private String name4;
	private String type1;
	private String type2;
	private String type3;
	private String type4;
	private String organizer1;
	private String organizer2;
	private String organizer3;
	private String organizer4;
	private int award_no1;
	private int award_no2;
	private int award_no3;
	private int award_no4;
	private List<Integer> skill_code;
	private String career1;
	private String career2;
	private String career3;
	private String career4;
	private String career5;
	private String license_name1;
	private String license_name2;
	private String license_name3;
	private String license_name4;
	private String license_name5;
	private String education;
	private String school_name;
	private String enter_date;
	private String graduation_date;
	private String introduce;
	private String is_offer;
	private String hope_salary;
	private int comment_no;
	private int resume_no;
	private String comment_table;
	private int like_no;
	private String updateComment;
	private int age;
	private String sex;
	private String is_job;
	private String skills;
	private String welfare;
    private String type;
	private String organizer;
	private int award_no;
	private String category;
	private String[] b_noList;
	private String boardname;
	private String ceo_phone;
	private String id;
	private String member_type;
	private String is_block;
	private int rnum;
	private int count_seoul;
	private int count_busan;
	private int count_incheon;
	private int count_gyeonggi;
	private int count_gangwon;
	private String salary_range;
	private int hope_cnt;
	private int apply_cnt;
	private int male;
	private int female;
	private int person;
	private int company;
	private String month;
	private int person_count;
	

	private transient MultipartFile img;
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
	public String getIs_block() {
		return is_block;
	}
	public void setIs_block(String is_block) {
		this.is_block = is_block;
	}
	public String getMember_type() {
		return member_type;
	}
	public void setMember_type(String member_type) {
		this.member_type = member_type;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCeo_phone() {
		return ceo_phone;
	}
	public void setCeo_phone(String ceo_phone) {
		this.ceo_phone = ceo_phone;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	private int count_c_no;
	private String sal_avg_range;
	private int gonggo_count;
	private int company_count;
	
		public String getBoardname() {
		return boardname;
	}
	public void setBoardname(String boardname) {
		this.boardname = boardname;
	}
		public String[] getB_noList() {
		return b_noList;
	}
	public void setB_noList(String[] b_noList) {
		this.b_noList = b_noList;
	}
		public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	private int mem_p_no;
		//프로젝트 공모 위한 선언//
		private int prj_no;
		private String project_type;
		private int field_code;
		private int people_to;
		private String code_field;
		private int comp_pk;
		private String skill_name;
		
		//마이기업페이지
		private int g_no;
		private String gonggoreg_date;
		private String opendate;
		private String closedate;
	    private String business_industry;
		private String business_no;
		
		private String addr1;
		private String addr2;
		private String addr3;
		
		private List<String> welfare_code;
		private String welfare_code2;
		
		
		
		
		
		public List<String> getWelfare_code() {
			return welfare_code;
		}
		public void setWelfare_code(List<String> welfare_code) {
			this.welfare_code = welfare_code;
		}
		public String getWelfare_code2() {
			return welfare_code2;
		}
		public void setWelfare_code2(String welfare_code2) {
			this.welfare_code2 = welfare_code2;
		}
		private String email2;
		
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
		public int getG_no() {
			return g_no;
		}
		public void setG_no(int g_no) {
			this.g_no = g_no;
		}
		public String getGonggoreg_date() {
			return gonggoreg_date;
		}
		public void setGonggoreg_date(String gonggoreg_date) {
			this.gonggoreg_date = gonggoreg_date;
		}
		public String getOpendate() {
			return opendate;
		}
		public void setOpendate(String opendate) {
			this.opendate = opendate;
		}
		public String getClosedate() {
			return closedate;
		}
		public void setClosedate(String closedate) {
			this.closedate = closedate;
		}
		public String getSkills() {
		return skills;
	}
	public void setSkills(String skills) {
		this.skills = skills;
	}
	public String getWelfare() {
		return welfare;
	}
	public void setWelfare(String welfare) {
		this.welfare = welfare;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getOrganizer() {
		return organizer;
	}
	public void setOrganizer(String organizer) {
		this.organizer = organizer;
	}
	public int getAward_no() {
		return award_no;
	}
	public void setAward_no(int award_no) {
		this.award_no = award_no;
	}
		public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getIs_job() {
		return is_job;
	}
	public void setIs_job(String is_job) {
		this.is_job = is_job;
	}
		public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
		public int getComp_pk() {
			return comp_pk;
		}
		public int getDesc_rank() {
			return desc_rank;
		}
		public void setDesc_rank(int desc_rank) {
			this.desc_rank = desc_rank;
		}
		public int getC_no() {
			return c_no;
		}
		public void setC_no(int c_no) {
			this.c_no = c_no;
		}
		public int getB_no() {
			return b_no;
		}
		public int getAdmin_no() {
			return admin_no;
		}
		public void setAdmin_no(int admin_no) {
			this.admin_no = admin_no;
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
		public int getR_no() {
			return r_no;
		}
		public void setR_no(int r_no) {
			this.r_no = r_no;
		}
		public String getTable() {
			return table;
		}
		public void setTable(String table) {
			this.table = table;
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
		public String getSubject() {
			return subject;
		}
		public void setSubject(String subject) {
			this.subject = subject;
		}
		public String getContent() {
			return content;
		}
		public void setContent(String content) {
			this.content = content;
		}
		public String getAddr() {
			return addr;
		}
		public void setAddr(String addr) {
			this.addr = addr;
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
		public String getPhone() {
			return phone;
		}
		public void setPhone(String phone) {
			this.phone = phone;
		}
		public String getPreferred_work() {
			return preferred_work;
		}
		public void setPreferred_work(String preferred_work) {
			this.preferred_work = preferred_work;
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
		public String getCareer() {
			return career;
		}
		public void setCareer(String career) {
			this.career = career;
		}
		public int getN_no() {
			return n_no;
		}
		public void setN_no(int n_no) {
			this.n_no = n_no;
		}
		public int getStar() {
			return star;
		}
		public void setStar(int star) {
			this.star = star;
		}
		public String getStar_avg() {
			return star_avg;
		}
		public void setStar_avg(String star_avg) {
			this.star_avg = star_avg;
		}
		public int getRating() {
			return rating;
		}
		public void setRating(int rating) {
			this.rating = rating;
		}
		public String getUrl() {
			return url;
		}
		public void setUrl(String url) {
			this.url = url;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getVolume() {
			return volume;
		}
		public void setVolume(String volume) {
			this.volume = volume;
		}
		public String getEmp_no() {
			return emp_no;
		}
		public void setEmp_no(String emp_no) {
			this.emp_no = emp_no;
		}
		public String getBirth() {
			return birth;
		}
		public void setBirth(String birth) {
			this.birth = birth;
		}
		public String getCeo_name() {
			return ceo_name;
		}
		public void setCeo_name(String ceo_name) {
			this.ceo_name = ceo_name;
		}
		public String getCall() {
			return call;
		}
		public void setCall(String call) {
			this.call = call;
		}
		public String getMarried() {
			return married;
		}
		public void setMarried(String married) {
			this.married = married;
		}
		public String getMilitary() {
			return military;
		}
		public void setMilitary(String military) {
			this.military = military;
		}
		public String getName1() {
			return name1;
		}
		public void setName1(String name1) {
			this.name1 = name1;
		}
		public String getName2() {
			return name2;
		}
		public void setName2(String name2) {
			this.name2 = name2;
		}
		public String getName3() {
			return name3;
		}
		public void setName3(String name3) {
			this.name3 = name3;
		}
		public String getName4() {
			return name4;
		}
		public void setName4(String name4) {
			this.name4 = name4;
		}
		public String getType1() {
			return type1;
		}
		public void setType1(String type1) {
			this.type1 = type1;
		}
		public String getType2() {
			return type2;
		}
		public void setType2(String type2) {
			this.type2 = type2;
		}
		public String getType3() {
			return type3;
		}
		public void setType3(String type3) {
			this.type3 = type3;
		}
		public String getType4() {
			return type4;
		}
		public void setType4(String type4) {
			this.type4 = type4;
		}
		public String getOrganizer1() {
			return organizer1;
		}
		public void setOrganizer1(String organizer1) {
			this.organizer1 = organizer1;
		}
		public String getOrganizer2() {
			return organizer2;
		}
		public void setOrganizer2(String organizer2) {
			this.organizer2 = organizer2;
		}
		public String getOrganizer3() {
			return organizer3;
		}
		public void setOrganizer3(String organizer3) {
			this.organizer3 = organizer3;
		}
		public String getOrganizer4() {
			return organizer4;
		}
		public void setOrganizer4(String organizer4) {
			this.organizer4 = organizer4;
		}
		public int getAward_no1() {
			return award_no1;
		}
		public void setAward_no1(int award_no1) {
			this.award_no1 = award_no1;
		}
		public int getAward_no2() {
			return award_no2;
		}
		public void setAward_no2(int award_no2) {
			this.award_no2 = award_no2;
		}
		public int getAward_no3() {
			return award_no3;
		}
		public void setAward_no3(int award_no3) {
			this.award_no3 = award_no3;
		}
		public int getAward_no4() {
			return award_no4;
		}
		public void setAward_no4(int award_no4) {
			this.award_no4 = award_no4;
		}
		public List<Integer> getSkill_code() {
			return skill_code;
		}
		public void setSkill_code(List<Integer> skill_code) {
			this.skill_code = skill_code;
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
		public String getEducation() {
			return education;
		}
		public void setEducation(String education) {
			this.education = education;
		}
		public String getSchool_name() {
			return school_name;
		}
		public void setSchool_name(String school_name) {
			this.school_name = school_name;
		}


		public String getEnter_date() {
			return enter_date;
		}
		public void setEnter_date(String enter_date) {
			this.enter_date = enter_date;
		}
		public String getGraduation_date() {
			return graduation_date;
		}
		public void setGraduation_date(String graduation_date) {

			this.graduation_date = graduation_date;
		}
		public String getIntroduce() {
			return introduce;
		}
		public void setIntroduce(String introduce) {
			this.introduce = introduce;
		}
		public String getIs_offer() {
			return is_offer;
		}
		public void setIs_offer(String is_offer) {
			this.is_offer = is_offer;
		}
		public String getHope_salary() {
			return hope_salary;
		}
		public void setHope_salary(String hope_salary) {
			this.hope_salary = hope_salary;
		}
		public int getComment_no() {
			return comment_no;
		}
		public void setComment_no(int comment_no) {
			this.comment_no = comment_no;
		}
		public int getPrj_no() {
			return prj_no;
		}
		public void setPrj_no(int prj_no) {
			this.prj_no = prj_no;
		}
		public String getProject_type() {
			return project_type;
		}
		public void setProject_type(String project_type) {
			this.project_type = project_type;
		}
		public int getField_code() {
			return field_code;
		}
		public void setField_code(int field_code) {
			this.field_code = field_code;
		}
		public int getPeople_to() {
			return people_to;
		}
		public void setPeople_to(int people_to) {
			this.people_to = people_to;
		}
		public String getCode_field() {
			return code_field;
		}
		public void setCode_field(String code_field) {
			this.code_field = code_field;
		}
		public String getSkill_name() {
			return skill_name;
		}
		public void setSkill_name(String skill_name) {
			this.skill_name = skill_name;
		}
		public void setComp_pk(int comp_pk) {
			this.comp_pk = comp_pk;
		}
		public int getResume_no() {
			return resume_no;
		}
		public void setResume_no(int resume_no) {
			this.resume_no = resume_no;
		}
		public String getComment_table() {
			return comment_table;
		}
		public void setComment_table(String comment_table) {
			this.comment_table = comment_table;
		}
		public int getLike_no() {
			return like_no;
		}
		public void setLike_no(int like_no) {
			this.like_no = like_no;
		}
		public String getBusiness_industry() {
			return business_industry;
		}
		public void setBusiness_industry(String business_industry) {
			this.business_industry = business_industry;
		}
		public String getBusiness_no() {
			return business_no;
		}
		public void setBusiness_no(String business_no) {
			this.business_no = business_no;
		}
		public String getEmail2() {
			return email2;
		}
		public void setEmail2(String email2) {
			this.email2 = email2;
		}
		public String getUpdateComment() {
			return updateComment;
		}
		public void setUpdateComment(String updateComment) {
			this.updateComment = updateComment;
		}

		
		public int getMem_p_no() {
			return mem_p_no;
		}
		public void setMem_p_no(int mem_p_no) {
			this.mem_p_no = mem_p_no;
		}
		public int getCount_c_no() {
			return count_c_no;
		}
		public void setCount_c_no(int count_c_no) {
			this.count_c_no = count_c_no;
		}
		public String getSal_avg_range() {
			return sal_avg_range;
		}
		public void setSal_avg_range(String sal_avg_range) {
			this.sal_avg_range = sal_avg_range;
		}
		public int getGonggo_count() {
			return gonggo_count;
		}
		public void setGonggo_count(int gonggo_count) {
			this.gonggo_count = gonggo_count;
		}
		public int getCompany_count() {
			return company_count;
		}
		public void setCompany_count(int company_count) {
			this.company_count = company_count;
		}
		public int getRnum() {
			return rnum;
		}
		public void setRnum(int rnum) {
			this.rnum = rnum;
		}
		public int getCount_seoul() {
			return count_seoul;
		}
		public void setCount_seoul(int count_seoul) {
			this.count_seoul = count_seoul;
		}
		public int getCount_busan() {
			return count_busan;
		}
		public void setCount_busan(int count_busan) {
			this.count_busan = count_busan;
		}
		public int getCount_incheon() {
			return count_incheon;
		}
		public void setCount_incheon(int count_incheon) {
			this.count_incheon = count_incheon;
		}
		public int getCount_gyeonggi() {
			return count_gyeonggi;
		}
		public void setCount_gyeonggi(int count_gyeonggi) {
			this.count_gyeonggi = count_gyeonggi;
		}
		public int getCount_gangwon() {
			return count_gangwon;
		}
		public void setCount_gangwon(int count_gangwon) {
			this.count_gangwon = count_gangwon;
		}
		public String getSalary_range() {
			return salary_range;
		}
		public void setSalary_range(String salary_range) {
			this.salary_range = salary_range;
		}
		public int getHope_cnt() {
			return hope_cnt;
		}
		public void setHope_cnt(int hope_cnt) {
			this.hope_cnt = hope_cnt;
		}
		public int getApply_cnt() {
			return apply_cnt;
		}
		public void setApply_cnt(int apply_cnt) {
			this.apply_cnt = apply_cnt;
		}
		public int getMale() {
			return male;
		}
		public void setMale(int male) {
			this.male = male;
		}
		public int getFemale() {
			return female;
		}
		public void setFemale(int female) {
			this.female = female;
		}
		public int getPerson() {
			return person;
		}
		public void setPerson(int person) {
			this.person = person;
		}
		public int getCompany() {
			return company;
		}
		public void setCompany(int company) {
			this.company = company;
		}
		public String getMonth() {
			return month;
		}
		public void setMonth(String month) {
			this.month = month;
		}
		public int getPerson_count() {
			return person_count;
		}
		public void setPerson_count(int person_count) {
			this.person_count = person_count;
		}
		
		
		
}	
	
	
	
	
	
	
	
	
	

