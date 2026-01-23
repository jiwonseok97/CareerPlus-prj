package com.wa.erp;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MypageDAO {
    
      List<MypageDTO> getMyPrivacy(int p_no);
      List<MypageDTO> getMytimshareList(int p_no);
      List<MypageDTO> getResumeList(int p_no);
      List<MypageDTO> getWriteList(int p_no);
      List<MypageDTO>  getScoutcompanyList(int p_no);
      List<MypageDTO> getApplycompanyList(int p_no);

}
