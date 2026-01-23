package com.wa.erp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
@Service
@Transactional
public class GonggoServiceImpl implements GonggoService{

		@Autowired
		private GonggoDAO gonggoDAO;
	
		
		public List<GonggoDTO> getgongGoList(
				BoardSearchDTO	boardSearchDTO
					){
					
				List<GonggoDTO> gongGoList = this.gonggoDAO.getgongGoList(boardSearchDTO);
					
				
				
						return gongGoList;
			}
		
		
		public int getGonggoListCnt(BoardSearchDTO boardSearchDTO) {


			int gonggoListCnt = this.gonggoDAO.getGonggoListCnt(boardSearchDTO);
			return gonggoListCnt;
		}
		

		// 게시판 총 개수 구하는 메소드 선언하기

		public int getGonggoListAllCnt(BoardSearchDTO boardSearchDTO) {
			
			int gonggoListAllCnt = this.gonggoDAO.getGonggoListAllCnt(boardSearchDTO);
			return gonggoListAllCnt;
		}
		
		public GonggoDTO getgonggoDetailForm(int g_no) {
			
			GonggoDTO gonggoDTO = this.gonggoDAO.getgonggoDetailForm(g_no); 
			
			
			
			return gonggoDTO;
		}
		
		public int insertGongo(GonggoDTO gonggoDTO ) {

			int insertGonggoCnt = this.gonggoDAO.insertGonggo(gonggoDTO);		
			
			  int insertGonggo_fieldCnt = this.gonggoDAO.insertGonggo_field( gonggoDTO); 
			  	if(insertGonggo_fieldCnt==0) {return 2;}
			  int insertGonggo_benefitCnt = this.gonggoDAO.insertBenefit_code(gonggoDTO); 
			  	if(insertGonggo_benefitCnt==0) {return 3;}
			  int insertRole_DetailCnt = this.gonggoDAO.insertRole_Detail(gonggoDTO);
			  	if(insertRole_DetailCnt==0) {return 4;}
			 
			return insertGonggoCnt;
		}
		
		public GonggoDTO getGonggo(int g_no) {
			
			GonggoDTO gonggoDTO  = this.gonggoDAO.getGonggo(g_no);

//			System.out.println(gonggoDTO.getCareer());

			return gonggoDTO;
		}
		//공고 삭제
				@RequestMapping( 
						value="/gonggoDelProc.do" 
						,method=RequestMethod.POST
						,produces="application/json;charset=UTF-8"
				)
		@ResponseBody
		public int deleteFromGonggo(GonggoDTO gonggoDTO) {
			int deleteFormGonggoCnt = this.gonggoDAO.deleteFromGonggo(gonggoDTO);
		
			return deleteFormGonggoCnt;		
			
		}
		

				// 공고 업데이트
				public int updateGonggo(GonggoDTO gonggoDTO)  {

					int updateGonggoCnt = this.gonggoDAO.updateGonggo(gonggoDTO);
					int updateBenefit_code = this.gonggoDAO.updateBenefit_code(gonggoDTO);
					int updateRole_detail = this.gonggoDAO.updateRole_detail(gonggoDTO);
					if( updateGonggoCnt==0 ) { return -1; }
					

					return updateGonggoCnt;
				}
				// 공고 이력서 지원
				@ResponseBody
				public int gonggoSupport(GonggoDTO gonggoDTO) {

					
					
					int getPertocomCnt = this.gonggoDAO.getPertocom(gonggoDTO);
					if(getPertocomCnt >= 1) {return -1;}

					int gonggoSupportCnt = this.gonggoDAO.gonggoSupport(gonggoDTO);
					
					return getPertocomCnt;
					
					
				}
}
