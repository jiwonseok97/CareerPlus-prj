package com.wa.erp;

import java.io.Serializable;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;


//게시판 검색화면에서 검색버튼 누르면
//WAS 로 접속할 때 가져올 파라미터값을 저장할 DTO 객체 선언하기
//이 객체에는 검색조건이 주로 들어있다.
public class BoardSearchDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String keyword;
	private String tradetype;
	private String boardname;
	private int selectfield_code;
	private String category;
	private String member_type;


	private int c_no;
	private int b_no;
	private int p_no;
	private String type;
	private String table;
	private String avg_star;
	private String sido;
	private String gugun;
	private String sort;
	private String sort2;
	private String sort3;
	private String sort4;
	private int selectPageNo;		// 선택한 페이지 번호 관련 파값 저장 변수
	private int rowCntPerPage;		// 페이지 당 보여줄 행의 개수 관련 파값 저장 변수
	private int begin_rowNo;		// 테이블 검색 시 시작행 번호 저장 변수 선언.
	private int end_rowNo;			// 테이블 검색 시 끝행 번호 저장 변수 선언.
//	
	//기업정보, 이력서 관련 //
	private String tmp;
	private String sex;
	private String age;
	private String start_age;
	private String age2;
	private String age3;
	private String age4;
	private String end_age;
	private String education;
	private String hope_salary;
	private String field_code;
	private String career;
	 private String[] skill_name; 
	 private String multisort1;
	 private String multisort2;
	 private String multisort3;
	 private String name;

	 
	 
	
	 
		private int resume_no;
		private  String[] welfare;
		/////////////////////////////
		//프로젝트/공모전 게시판을 위한 선언//
		private List<String> date;
		private String ing;
		private String project_type;
		private String field_name;
	
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
		private transient MultipartFile img;
		private String img_name;
		private String isdel;
		
		public String getMember_type() {
			return member_type;
		}
		public void setMember_type(String member_type) {
			this.member_type = member_type;
		}
		public String getCategory() {
			return category;
		}
		public void setCategory(String category) {
			this.category = category;
		}
	
	
		public String getMultisort1() {
			return multisort1;
		}
		public void setMultisort1(String multisort1) {
			this.multisort1 = multisort1;
		}
		public String getMultisort2() {
			return multisort2;
		}
		public void setMultisort2(String multisort2) {
			this.multisort2 = multisort2;
		}
		public String getMultisort3() {
			return multisort3;
		}
		public void setMultisort3(String multisort3) {
			this.multisort3 = multisort3;
		}
		// 업종별 검색 추가
		private String industry;
	// 지역별 검색 추가
		private String work_place;
		// 진행중인 공고
		private String gonggoStatus;
	
	

		 
		public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
		
		public String getTradetype() {
			return tradetype;
		}
		public void setTradetype(String tradetype) {
			this.tradetype = tradetype;
		}
	public int getP_no() {
			return p_no;
		}
		public void setP_no(int p_no) {
			this.p_no = p_no;
		}
//		private String keyword2;
//		private String orand;
//		private List<String> checkdate;
//		private String sort;
//		private String minYear;
//		private String minMonth;
//		private String maxYear;
//		private String maxMonth;
	//	
		public String getTmp() {
			return tmp;
		}
		public void setTmp(String tmp) {
			this.tmp = tmp;
		}
		public String getSex() {
			return sex;
		}
		public void setSex(String sex) {
			this.sex = sex;
		}
		public String getAge() {
			return age;
		}
		public void setAge(String age) {
			this.age = age;
		}
		public String getStart_age() {
			return start_age;
		}
		public void setStart_age(String start_age) {
			this.start_age = start_age;
		}
		public String getAge2() {
			return age2;
		}
		public void setAge2(String age2) {
			this.age2 = age2;
		}
		public String getAge3() {
			return age3;
		}
		public void setAge3(String age3) {
			this.age3 = age3;
		}
		public String getAge4() {
			return age4;
		}
		public void setAge4(String age4) {
			this.age4 = age4;
		}
		public String getEnd_age() {
			return end_age;
		}
		public void setEnd_age(String end_age) {
			this.end_age = end_age;
		}
		public String getEducation() {
			return education;
		}
		
		public void setEducation(String education) {
			this.education = education;
			
		}
		public String getHope_salary() {
			return hope_salary;
		}
		public void setHope_salary(String hope_salary) {
			this.hope_salary = hope_salary;
		}
		public String getField_code() {
			return field_code;
		}
		public void setField_code(String field_code) {
			this.field_code = field_code;
		}
		public String getCareer() {
			return career;
		}
		public void setCareer(String career) {
			this.career = career;
		}
		public String[] getSkill_name() {
			return skill_name;
		}
		public void setSkill_name(String[] skill_name) {
			this.skill_name = skill_name;
		}
	public List<String> getDate() {
			return date;
		}
		public void setDate(List<String> date) {
			this.date = date;
		}
		public String getIng() {
			return ing;
		}
		public void setIng(String ing) {
			this.ing = ing;
		}
		public String getProject_type() {
			return project_type;
		}
		public void setProject_type(String project_type) {
			this.project_type = project_type;
		}
		public String getField_name() {
			return field_name;
		}
		public void setField_name(String field_name) {
			this.field_name = field_name;
		}
	public String getSido() {
		return sido;
	}
	public void setSido(String sido) {
		this.sido = sido;
	}
	public String getGugun() {
		return gugun;
	}
	public void setGugun(String gugun) {
		this.gugun = gugun;
	}
	public String getTable() {
		return table;
	}
	public void setTable(String table) {
		this.table = table;
	}
	public int getB_no() {
		return b_no;
	}
	public void setB_no(int b_no) {
		this.b_no = b_no;
	}
	
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getAvg_star() {
		return avg_star;
	}
	public void setAvg_star(String avg_star) {
		this.avg_star = avg_star;
	}
	public int getC_no() {
		return c_no;
	}
	public void setC_no(int c_no) {
		this.c_no = c_no;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getBoardname() {
		return boardname;
	}
	public void setBoardname(String boardname) {
		this.boardname = boardname;
	}
//	public String getOrand() {
//		return orand;
//	}
//	public void setOrand(String orand) {
//		this.orand = orand;
//	}
//	public String getKeyword2() {
//		return keyword2;
//	}
//	public void setKeyword2(String keyword2) {
//		this.keyword2 = keyword2;
//	}
//	public String getSort() {
//		return sort;
//	}
//	public void setSort(String sort) {
//		this.sort = sort;
//	}
//	public List<String> getCheckdate() {
//		return checkdate;
//	}
//	public void setCheckdate(List<String> checkdate) {
//		this.checkdate = checkdate;
//	}
	public int getSelectPageNo() {
		return selectPageNo;
	}
	public void setSelectPageNo(int selectPageNo) {
		this.selectPageNo = selectPageNo;
	}
	public int getRowCntPerPage() {
		return rowCntPerPage;
	}
	public void setRowCntPerPage(int rowCntPerPage) {
		this.rowCntPerPage = rowCntPerPage;
	}
	public int getBegin_rowNo() {
		return begin_rowNo;
	}
	public void setBegin_rowNo(int begin_rowNo) {
		this.begin_rowNo = begin_rowNo;
	}
	public int getEnd_rowNo() {
		return end_rowNo;
	}
	public void setEnd_rowNo(int end_rowNo) {
		this.end_rowNo = end_rowNo;
	}
	public int getResume_no() {
		return resume_no;
	}
	public void setResume_no(int resume_no) {
		this.resume_no = resume_no;
	}
	public String[] getWelfare() {
		return welfare;
	}
	public void setWelfare(String[] welfare) {
		this.welfare = welfare;
	}
	public String getSort2() {
		return sort2;
	}
	public void setSort2(String sort2) {
		this.sort2 = sort2;
	}
	public String getSort3() {
		return sort3;
	}
	public void setSort3(String sort3) {
		this.sort3 = sort3;
	}
	public String getSort4() {
		return sort4;
	}
	public void setSort4(String sort4) {
		this.sort4 = sort4;
	}
	public String getIndustry() {
		return industry;
	}
	public void setIndustry(String industry) {
		this.industry = industry;
	}
	public String getWork_place() {
		return work_place;
	}
	public void setWork_place(String work_place) {
		this.work_place = work_place;
	}
	public String getGonggoStatus() {
		return gonggoStatus;
	}
	public void setGonggoStatus(String gonggoStatus) {
		this.gonggoStatus = gonggoStatus;
	}
	public int getSelectfield_code() {
		return selectfield_code;
	}
	public void setSelectfield_code(int selectfield_code) {
		this.selectfield_code = selectfield_code;
	}
	
	
	
//	public String getMinYear() {
//		return minYear;
//	}
//	public void setMinYear(String minYear) {
//		this.minYear = minYear;
//	}
//	public String getMinMonth() {
//		return minMonth;
//	}
//	public void setMinMonth(String minMonth) {
//		this.minMonth = minMonth;
//	}
//	public String getMaxYear() {
//		return maxYear;
//	}
//	public void setMaxYear(String maxYear) {
//		this.maxYear = maxYear;
//	}
//	public String getMaxMonth() {
//		return maxMonth;
//	}
//	public void setMaxMonth(String maxMonth) {
//		this.maxMonth = maxMonth;
//	}
//	
//	
	
	
	
	
}
