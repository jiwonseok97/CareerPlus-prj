package com.wa.erp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class MypageServiceImpl implements MypageService {

    @Autowired
    private MypageDAO mypageDAO;

    
    @Override
	public List<MypageDTO> getMyPrivacy(int p_no) {
		List<MypageDTO> MyPrivacy = this.mypageDAO.getMyPrivacy(p_no);
		return MyPrivacy;
	}
    
    @Override
	public List<MypageDTO> getWriteList(int p_no) {
    	List<MypageDTO> WriteList = this.mypageDAO.getWriteList(p_no);
		return WriteList;
	}
    
    @Override
	   public List<MypageDTO> getMytimshareList( int p_no) {
		List<MypageDTO> MytimshareList = this.mypageDAO.getMytimshareList(p_no);
		return MytimshareList;
	}
    
    @Override
	public List<MypageDTO> getScoutcompanyList( int p_no) {
		List<MypageDTO> ScoutcompanyList = this.mypageDAO.getScoutcompanyList(p_no);
		return ScoutcompanyList;
	}
    
    
    @Override
	public List<MypageDTO> getApplycompanyList( int p_no) {
		List<MypageDTO> ApplycompanyList = this.mypageDAO.getApplycompanyList(p_no);
		return ApplycompanyList;
	 }
    
    @Override
	public List<MypageDTO> getResumeList( int p_no) {
		List<MypageDTO> ResumeList = this.mypageDAO.getResumeList(p_no);
		return ResumeList;
	}
}
