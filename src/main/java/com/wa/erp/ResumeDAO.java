package com.wa.erp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ResumeDAO {
	List<BoardDTO> getresumeList(BoardSearchDTO boardSearchDTO);

	BoardDTO getResume(int p_no);

	List<BoardDTO> getSkillList(int resume_no);

	int getresumeListCnt(BoardSearchDTO boardSearchDTO);

	int getresumeListAllCnt(BoardSearchDTO boardSearchDTO);

	int insertcomtoper(BoardDTO boardDTO);
	
	int checkComtoper(@Param("resume_no") int resume_no, @Param("c_no") int c_no);
}
