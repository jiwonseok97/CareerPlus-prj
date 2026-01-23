package com.wa.erp;

import java.util.List;
import java.util.Map;

//BoardService 인터페이스 선언
public interface ResumeService {

	List<BoardDTO> getResumeList(BoardSearchDTO boardSearchDTO);

	BoardDTO getResume(int p_no);

	List<BoardDTO> getSkillList(int resume_no);

	int getresumeListCnt(BoardSearchDTO boardSearchDTO);

	int getresumeListAllCnt(BoardSearchDTO boardSearchDTO);

	int insertcomtoper(BoardDTO boardDTO);

}
