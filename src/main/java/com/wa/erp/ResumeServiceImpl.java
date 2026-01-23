package com.wa.erp;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ResumeServiceImpl implements ResumeService{
	
	@Autowired
	private ResumeDAO resumeDAO;

	@Override
	public List<BoardDTO> getResumeList(BoardSearchDTO boardSearchDTO) {
		
		if(boardSearchDTO.getAge()!=null  ) {
		String ageString = boardSearchDTO.getAge(); // 주어진 문자열
		if(ageString.length()==2) {	String[] ageArray = ageString.split(",");
		boardSearchDTO.setStart_age(ageArray[0]);    
//		boardSearchDTO.setAge2(ageArray[1]);    
//		boardSearchDTO.setAge3(ageArray[2]);    
//		boardSearchDTO.setEnd_age(ageArray[ageArray.length-1]);
		
		}
		if(ageString.length()==5) {
		// 쉼표를 기준으로 문자열을 분리하여 각 값을 추출하여 배열에 넣음
		String[] ageArray = ageString.split(",");
		boardSearchDTO.setStart_age(ageArray[0]);    
//		boardSearchDTO.setAge2(ageArray[1]);    
//		boardSearchDTO.setAge3(ageArray[2]);    
		boardSearchDTO.setEnd_age(ageArray[ageArray.length-1]);
		};
		if(ageString.length()==8) {
		// 쉼표를 기준으로 문자열을 분리하여 각 값을 추출하여 배열에 넣음
		String[] ageArray = ageString.split(",");
		boardSearchDTO.setStart_age(ageArray[0]);    
        boardSearchDTO.setAge2(ageArray[1]);    
//		boardSearchDTO.setAge3(ageArray[2]);    
		boardSearchDTO.setEnd_age(ageArray[ageArray.length-1]);
		};
		if(ageString.length()==11) {
		// 쉼표를 기준으로 문자열을 분리하여 각 값을 추출하여 배열에 넣음
		String[] ageArray = ageString.split(",");
		boardSearchDTO.setStart_age(ageArray[0]);    
        boardSearchDTO.setAge2(ageArray[1]);    
		boardSearchDTO.setAge3(ageArray[2]);    
		boardSearchDTO.setEnd_age(ageArray[ageArray.length-1]);
		};
		if(ageString.length()==14) {
		// 쉼표를 기준으로 문자열을 분리하여 각 값을 추출하여 배열에 넣음
		String[] ageArray = ageString.split(",");
		boardSearchDTO.setStart_age(ageArray[0]);    
        boardSearchDTO.setAge2(ageArray[1]);    
		boardSearchDTO.setAge3(ageArray[2]);    
		boardSearchDTO.setAge4(ageArray[3]);    
		boardSearchDTO.setEnd_age(ageArray[ageArray.length-1]);
		
		};
		
		
		};
//		System.out.println("start "+boardSearchDTO.getStart_age());
//		System.out.println("end "+boardSearchDTO.getEnd_age());
		List<BoardDTO> resumeList = this.resumeDAO.getresumeList(boardSearchDTO);
		System.out.println(boardSearchDTO.getEnd_rowNo());
		return resumeList;
	}

	@Override
	public BoardDTO getResume(int p_no) {
		BoardDTO boardDTO  = this.resumeDAO.getResume(p_no);
		//------------------------------------------
		// [1개 게시판 글]이 저장된 BoardDTO 객체 리턴하기
		//------------------------------------------
		return boardDTO;
	}

	@Override
	public List<BoardDTO> getSkillList(int resume_no) {
		List<BoardDTO> skillList = this.resumeDAO.getSkillList(resume_no);
		return skillList;
	}

	@Override
	public int getresumeListCnt(BoardSearchDTO boardSearchDTO) {
		int resumeListCnt = this.resumeDAO.getresumeListCnt(boardSearchDTO);
		return resumeListCnt;
	}

	@Override
	public int getresumeListAllCnt(BoardSearchDTO boardSearchDTO) {
		int resumeListAllCnt = this.resumeDAO.getresumeListAllCnt(boardSearchDTO);
		//--------------------------------------
		// 변수 boardListAllCnt 안의 데이터를 리턴하기
		//--------------------------------------
		return resumeListAllCnt;
	}

	@Override
	public int insertcomtoper(BoardDTO boardDTO) {
		 int duplicateCount = resumeDAO.checkComtoper(boardDTO.getResume_no(), boardDTO.getC_no());
	        if (duplicateCount > 0) {
	            return -1; // 중복일 경우 -1 반환
	        }
	        return resumeDAO.insertcomtoper(boardDTO);
	}



	
}
