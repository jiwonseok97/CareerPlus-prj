package com.wa.erp;

import java.util.List;

public interface MypageService {
 

	 List<MypageDTO> getWriteList(int p_no);
     List<MypageDTO> getMyPrivacy(int p_no);
     List<MypageDTO> getMytimshareList(int p_no);
     List<MypageDTO> getResumeList(int p_no);
     List<MypageDTO> getScoutcompanyList(int p_no);
     List<MypageDTO> getApplycompanyList(int p_no);
  
}
