package com.wa.erp;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
@Transactional
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardDAO boardDAO;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private MemberDAO memberDTO;
	
//	public List<Map<String,String>> getBoardList(){
//	
//		List<Map<String,String>> boardList = this.boardDAO.getBoardList();
//		return boardList;
//	}

	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// n행m열의 게시판 검색을 getBoardList 메소드 선언하기
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	@Override
	public List<BoardDTO> getboardList(BoardSearchDTO boardSearchDTO){
		//--------------------------------------
		// BoardDAOImpl 객체의 getBoardList 메소드를 호출하여
		// n행m열의 게시판 검색 데이터가 저장된 List<BoardDTO> 객체얻기
		// List<BoardDTO> 객체의 메위주를 변수 boardList 에 저장하기
		//--------------------------------------
		List<BoardDTO> boardList = this.boardDAO.getboardList(boardSearchDTO);
		return boardList;
	}

	@Override
	@Cacheable(value = "companyList", key = "'page:' + #boardSearchDTO.selectPageNo + ':row:' + #boardSearchDTO.rowCntPerPage", condition = "#boardSearchDTO.keyword == null")
	public List<BoardDTO> getcompanyList(BoardSearchDTO boardSearchDTO) {
		List<BoardDTO> companyList = this.boardDAO.getcompanyList(boardSearchDTO);
		return companyList;


	}

	@Override
	public List<BoardDTO> getgongGoList() {
		List<BoardDTO> gongGoList = this.boardDAO.getgongGoList();
		return gongGoList;
	}


	@Override
	public List<BoardDTO> getprjList() {
		List<BoardDTO> prjList = this.boardDAO.getprjList();
		return prjList;
	}

	@Override
	public List<BoardDTO> getgongMoList() {
		List<BoardDTO> gongMoList = this.boardDAO.getgongMoList();
		return gongMoList;
	}
	
//	상세보기 화면에서 필요한
//	1개의 게시판 글 을 검색하여 리턴하는 메소드 선언
//	매개변수로 검색할 게시판의 고유번호가 들어온다.
	@Override
	public BoardDTO getBoard(Map<String,Object> paramMap) {
		
		
//		BoardDAOImpl 객체의 updateReadCount 메소드를 호출하여
//		조회수 증가 하고 수정한 행의 개수를 얻는다.
//		존재하지 않는 게시판이라도 쿼리문은 작동된다.
		int updateCnt = this.boardDAO.updateReadCount(paramMap);
		
//		BoardDAOImpl 객체의 getBoard 메소드를 호출하여
//		1개의 게시판 글 을 얻는다.
//		존재하지 않는 게시판 글일 경우 null로 들어온다.
		BoardDTO boardDTO = this.boardDAO.getBoard(paramMap);
		
//		1개 게시판 글이 저장된 BoardDTO 객체 리턴하기
		return boardDTO;
	}
	
	@Override
	public List<BoardDTO> getComment(Map<String,Object> paramMap) {
		
		List<BoardDTO> boardDTO = this.boardDAO.getComment(paramMap);
		
		return boardDTO;
	}
	
	// *********************************************************************//
	
	
	

	
		@Override
		public BoardDTO getcompanyDetail(int c_no) {
			//------------------------------------------
			// [BoardDAOImpl 객체]의  getBoard 메소드를 호출하여
			// [1개 게시판 글]을 얻는다
			//------------------------------------------
			BoardDTO boardDTO  = this.boardDAO.getcompanyDetail(c_no);
			//------------------------------------------
			// [1개 게시판 글]이 저장된 BoardDTO 객체 리턴하기
			//------------------------------------------
			return boardDTO;
		}
		
		// review 창 가져오기
		@Override
		public List<BoardReviewDTO> getreviewContent(int c_no) {
			List<BoardReviewDTO> reviewContent = this.boardDAO.getreviewContent(c_no);
			return reviewContent;
		}
		
		@Override
		public List<BoardDTO> getReview(int c_no) {
			// TODO Auto-generated method stub
			return null;
		}
		
		
		
	public int getboardListCnt(BoardSearchDTO boardSearchDTO ) {
		//--------------------------------------
		// BoardDAOImpl 객체의 getBoardListCnt 메소드를 호출하여
		// 게시판 검색 개수를 구하여 변수 boardListCnt 에 저장하기
		//--------------------------------------
		int boardListCnt = this.boardDAO.getboardListCnt(boardSearchDTO);
		
		//--------------------------------------
		// 변수 boardListCnt 안의 데이터를 리턴하기
		//--------------------------------------
		return boardListCnt;
	}

	public int getboardListAllCnt(BoardSearchDTO boardSearchDTO) {
		//--------------------------------------
		// BoardDAOImpl 객체의 getBoardListCnt 메소드를 호출하여
		// 게시판 총 개수를 구하여 변수 boardListAllCnt 에 저장하기
		//--------------------------------------
		int boardListAllCnt = this.boardDAO.getboardListAllCnt(boardSearchDTO);
		//--------------------------------------
		// 변수 boardListAllCnt 안의 데이터를 리턴하기
		//--------------------------------------
		return boardListAllCnt;
	}
	
	@Override
	public int getReviewListAllCnt() {
		int reviewListAllCnt = this.boardDAO.getReviewListAllCnt();
		return reviewListAllCnt;
	}

	@Override
	public int getReviewListCnt(BoardReviewDTO boardReviewDTO) {
		int reviewListCnt = this.boardDAO.getReviewListCnt(boardReviewDTO);
		return reviewListCnt;
	}



	@Override
	public List<BoardReviewDTO> getreviewContent(BoardReviewDTO boardReviewDTO) {
	List<BoardReviewDTO> reviewContent = this.boardDAO.getreviewContent(boardReviewDTO);

		return reviewContent;
	}

	@Override
	public BoardDTO getcompanyListDetail(int c_no) {
		BoardDTO boardDTO  = this.boardDAO.getcompanyListDetail(c_no);
		//------------------------------------------
		// [1개 게시판 글]이 저장된 BoardDTO 객체 리턴하기
		//------------------------------------------
		return boardDTO;
	}
	
		//프로젝트 공모 게시판을 위한 선언
		@Autowired
		private BoardDAO boardDTO;
		
		//입력을 위한 선언
		@Override
		public int insertPrj(BoardDTO boardDTO)throws Exception{
			
			MultipartFile multi = boardDTO.getImg();
			boolean isFile = multi!=null && multi.isEmpty()==false;
			String newFileName = Util.getNewFileName(multi);
			
			int checkUploadfile = Util.checkUploadFileForBoard( multi );
			if( checkUploadfile<0 ) {
				return checkUploadfile;	
			}	
			
			boardDTO.setImg_name(newFileName);
			
			int boardRegCnt = this.boardDAO.insertPrj(boardDTO);
			
			if( isFile ) {
				File file = new File( Util.uploadDirForBoard() + newFileName );
				multi.transferTo(file);
			}
			return boardRegCnt;
		}
	

		@Override
		public BoardDTO getPrj(int prj_no) {
			
			int updateCount = this.boardDAO.prjUpdateReadcount(prj_no);
			
			BoardDTO boardDTO = this.boardDAO.getPrj(prj_no);
			
			return boardDTO;
			
		}
		
		// 프로젝트 수정/삭제
		@Override
		public BoardDTO getPrjForUpDel(int prj_no) {
			
			BoardDTO boardDTO = this.boardDAO.getPrj(prj_no);
			
			return boardDTO;
		}
		
		@Override
		public int updatePrj(BoardDTO boardDTO)throws Exception{
			
			int prjCnt = this.boardDAO.getPrjCnt( boardDTO.getPrj_no() );
			if( prjCnt==0 ){ return -2; }
//			int prjCnt = this.boardDAO.getPrjCnt( boardDTO.getPrj_no() );
//			if( prjCnt==0 ) { return prjCnt; }
			
			//----------------------------------------------
			// boardDTO 객체에 저장된 MultipartFile 객체를 꺼내서 변수 multi 에 저장하기
			// MultipartFile 객체가 업로드된 파일을 관리하고 있다면  
			// 변수 isFile 에 true 저장하고 아니면 false 저장하기
			// 업로드된 파일의 새 이름을 구해서 변수 newFileName 에 저장하기
			//---------------------------------------------
			MultipartFile multi      =  boardDTO.getImg();
			boolean isFile            =  multi!=null && multi.isEmpty()==false;
			String newFileName  =  Util.getNewFileName(multi);
			String isdel                =  boardDTO.getIsdel();
			//----------------------------------------------*
			// 업로드 파일의 크기와 확장자 검사하기
			// Util 클래스의 checkUploadFileForBoard 메소드를 호출하여
			// 리턴되는 데이터가 -11 이면 크기가 너무 큰 것이고
			//                   -12 이면 확장자가 틀린것이다.
			//----------------------------------------------
			int checkUploadfile = Util.checkUploadFileForBoard( multi );
			if( checkUploadfile<0 ) {
				return checkUploadfile;
			}

			if( isFile ) {
				boardDTO.setImg_name(newFileName);
			}
			else {
				if( isdel!=null ) {
					boardDTO.setImg_name(null);
				}
			}
			

			int prjPwdCnt = this.boardDAO.getPrjPwdCnt(boardDTO);
			if( prjPwdCnt==0 ) {return -1;}
			
			int prjUpCnt = this.boardDAO.updatePrj(boardDTO);
			
			//--------------------------------------
			// 만약에 boardDTO 객체의 멤버변수 img 가 null 이 아니면
			// 즉 파일업로드가 되었다면
			//--------------------------------------
			if( isFile ) {
				//-----------------------
				// 새 파일을 만들고 이 파일을 관리하는 
				// File 객체 생성하고 이 객체의 메위주를 변수 file 에 저장하기
				// 즉 텅비어 있는 파일을 먼저 만든다.
				//-----------------------
				File file = new File(  Util.uploadDirForBoard() +  newFileName );
				//-----------------------
				// MultipartFile 객체의 transferTo 메소드를 호출하여
				// MultipartFile 객체가 관리하는 업로드 파일을 위에서 만든 새 파일에 덮어쓰기   
				//-----------------------
				multi.transferTo(file);
			}
			
			return prjUpCnt;
		}

		@Override
		public int deldatePrj(BoardDTO boardDTO) {
			
			int prjCnt = this.boardDAO.getPrjCnt( boardDTO.getPrj_no() );
			if( prjCnt==0 ) { return prjCnt; }
			
			int prjPwdCnt = this.boardDAO.getPrjPwdCnt(boardDTO);
			if( prjPwdCnt==0 ) {return -1;}
			
			int prjDelCnt = this.boardDAO.deldatePrj(boardDTO);
			
			return prjDelCnt;
		}

		
		//공모전을 위한 선언들
		@Override
		public int insertGongMo(BoardDTO boardDTO)throws Exception{
			
			
			
			MultipartFile multi = boardDTO.getImg();
			boolean isFile = multi!=null && multi.isEmpty()==false;
			String newFileName = Util.getNewFileName(multi);
			
			int checkUploadfile = Util.checkUploadFileForBoard( multi );
			if( checkUploadfile<0 ) {
				return checkUploadfile;	
			}	
			boardDTO.setImg_name(newFileName);
			
			// boardDAOImpl 객체의
			// insertBoard 메소드 호출하여
			// 게시판 글 입력 후 적용 행의 개수 얻기
			int boardRegCnt = this.boardDTO.insertGongMo(boardDTO);
			
			if( isFile ){
			File file = new File( Util.uploadDirForBoard() + newFileName );
			multi.transferTo(file);
			}
			// 1개 게시판 글 입력 적용 행의 개수 리턴하기
			return boardRegCnt;
		}
		
		@Override
		public List<BoardDTO> getGongMoList(BoardSearchDTO boardSearchDTO) {
			
			List<BoardDTO> gongMoList = this.boardDAO.getGongMoList(boardSearchDTO);
			
			return gongMoList;
		}

		@Override
		public BoardDTO getGongMo(int comp_pk) {
			// [BoardDAOImpl 객체]의 updateReadcount 메소드를 호출하여
			// [조회수 증가]하고 수정한 행의 개수를 얻는다.
			int updateCount = this.boardDAO.gongMoUpdateReadcount(comp_pk);
			// [BoardDAOImpl 객체]의 getBoard 메소드를 호출하여
			// [1개 게시판 글]을 얻는다.
			BoardDTO boardDTO = this.boardDAO.getGongMo(comp_pk);
			// [1개 게시판 글]이 저장된 BoardDTO 객체 리턴하기
			return boardDTO;
		}

		@Override
		public BoardDTO gongMoForUpDel(int comp_pk) {
			BoardDTO boardDTO = this.boardDAO.getGongMo(comp_pk);
			// [1개 게시판 글]이 저장된 BoardDTO 객체 리턴하기
			return boardDTO;
		}

		@Override
		public int updateGongMo(BoardDTO boardDTO)throws Exception{
			
			
			//----------------------------------------------
			// timeShareDTO 객체에 저장된 MultipartFile 객체를 꺼내서 변수 multi 에 저장하기
			// MultipartFile 객체가 업로드된 파일을 관리하고 있다면  
			// 변수 isFile 에 true 저장하고 아니면 false 저장하기
			// 업로드된 파일의 새 이름을 구해서 변수 newFileName 에 저장하기
			//---------------------------------------------
			MultipartFile multi      =  boardDTO.getImg();
			boolean isFile            =  multi!=null && multi.isEmpty()==false;
			String newFileName  =  Util.getNewFileName(multi);
			String isdel                =  boardDTO.getIsdel();
			//----------------------------------------------*
			// 업로드 파일의 크기와 확장자 검사하기
			// Util 클래스의 checkUploadFileForBoard 메소드를 호출하여
			// 리턴되는 데이터가 -11 이면 크기가 너무 큰 것이고
			//                   -12 이면 확장자가 틀린것이다.
			//----------------------------------------------
			int checkUploadfile = Util.checkUploadFileForBoard( multi );
			if( checkUploadfile<0 ) {
				return checkUploadfile;
			}

			if( isFile ) {
				boardDTO.setImg_name(newFileName);
			}
			else {
				if( isdel!=null) {
					boardDTO.setImg_name(null);
				}
				
			}
			
			// 암호의 존재 개수 얻기
			// 만약 암호의 존개 개수가 0개면(=암호가 틀렸으면) -1 리턴하기
			int boardPwdCnt = this.boardDAO.getGongMoPwdCnt(boardDTO);
			if( boardPwdCnt==0 ) {return -1;}
			// 수정 실행하고 수정 적용행의 개수 얻기
			int boardUpCnt = this.boardDAO.updateGongMo(boardDTO);
			
			
			//--------------------------------------
			// 만약에 timeShareDTO 객체의 멤버변수 img 가 null 이 아니면
			// 즉 파일업로드가 되었다면
			//--------------------------------------
			if( isFile ) {
				//-----------------------
				// 새 파일을 만들고 이 파일을 관리하는 
				// File 객체 생성하고 이 객체의 메위주를 변수 file 에 저장하기
				// 즉 텅비어 있는 파일을 먼저 만든다.
				//-----------------------
				File file = new File(  Util.uploadDirForBoard() +  newFileName );
				//-----------------------
				// MultipartFile 객체의 transferTo 메소드를 호출하여
				// MultipartFile 객체가 관리하는 업로드 파일을 위에서 만든 새 파일에 덮어쓰기   
				//-----------------------
				multi.transferTo(file);
			}
			
			
			
			// 수정 적용행의 개수 리턴히기
			return boardUpCnt;
		}

		@Override
		public int deldateGongMo(BoardDTO boardDTO) {
			// 암호의 존재 개수 얻기
			// 만약 암호의 존개 개수가 0개면(=암호가 틀렸으면) -1 리턴하기
			int boardPwdCnt = this.boardDAO.getGongMoPwdCnt(boardDTO);
			if( boardPwdCnt==0 ) {return -1;}
					
			// 삭제 실행하고 수정 적용행의 개수 얻기
			int boardDelCnt = this.boardDAO.deldateGongMo(boardDTO);
			// 삭제 적용행의 개수 리턴히기
			return boardDelCnt;
		}

		@Override
		public int getPrjListAllCnt() {
			
			int boardListAllCnt = this.boardDAO.getPrjListAllCnt();
			
			return boardListAllCnt;
		}

		@Override
		public int getPrjListCnt(BoardSearchDTO boardSearchDTO) {
			
			int boardListCnt = this.boardDAO.getPrjListCnt(boardSearchDTO);
			
			return boardListCnt;
		}

		@Override
		public List<BoardDTO> getPrjList(BoardSearchDTO boardSearchDTO) {
			
			List<BoardDTO> boardList = this.boardDAO.getPrjList( boardSearchDTO );
			
			return boardList;
		}

		@Override
		public int getGongMoListAllCnt() {
			
			int gongMoListAllCnt = this.boardDAO.getGongMoListAllCnt();
			
			return gongMoListAllCnt;
		}

		@Override
		public int getGongMoListCnt(BoardSearchDTO boardSearchDTO) {
			
			int gongMoListCnt = this.boardDAO.getGongMoListCnt(boardSearchDTO);
			
			return gongMoListCnt;
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		@Override
		public List<BoardDTO> getCommentLike(Map<String, Object> paramMap){
			
			List<BoardDTO> getCommentLike = this.boardDAO.getCommentLike(paramMap);
			

			return getCommentLike;
		}
		
		public List<BoardDTO> getlikeCompany(int p_no){
			List<BoardDTO> getLikeCompany = this.boardDAO.getLikeCompany(p_no);
			
			return getLikeCompany;
		}
/// 기업정보관련 추가///////////////
		@Override
		public int getcompanyListCnt(BoardSearchDTO boardSearchDTO) {
			int companyListCnt = this.boardDAO.getcompanyListCnt(boardSearchDTO);
			
			//--------------------------------------
			// 변수 boardListCnt 안의 데이터를 리턴하기
			//--------------------------------------
			return companyListCnt;
		}
		
		//기업마이페이지
		@Override
		public List<BoardDTO> getMyGongMoList(int c_no) {
			
			List<BoardDTO> myGongMoList = this.boardDAO.getMyGongMoList(c_no);
			
			return myGongMoList;
		}

		@Override
		public List<BoardDTO> getMyGongGoList(int c_no) {
			
			List<BoardDTO> myGongGoList = this.boardDAO.getMyGongGoList(c_no);
			
			return myGongGoList;
		}

		@Override
		public List<BoardDTO> getMyCompanyInfo(int c_no) {
			
			List<BoardDTO> myCompanyInfo = this.boardDAO.getMyCompanyInfo(c_no);
			
			return myCompanyInfo;
		}

		@Override
		public List<BoardDTO> getGonggoPertocom(int c_no) {
			
			List<BoardDTO> myComPertocom = this.boardDAO.getGonggoPertocom(c_no);
			
			return myComPertocom;
		}

		@Override
		public BoardDTO getComInfoSujung(int c_no) {
			
			BoardDTO boardDTO = this.boardDAO.getComInfoSujung(c_no);
			
			return boardDTO;
		}

		@Override
		public int updateComInfo(BoardDTO boardDTO) {
			//--------------------------------------
			// 수정할 게시판의 존재 개수 얻기
			// 만약 수정할 게시판의 개수가 0개면(=이미 삭제되었으면) 0리턴하기
			//--------------------------------------
			int comInfoCnt = this.boardDAO.getComInfoCnt( boardDTO.getC_no() );
			if( comInfoCnt==0 ) { return comInfoCnt; }
			// 암호의 존재 개수 얻기
			// 만약 암호의 존개 개수가 0개면(=암호가 틀렸으면) -1 리턴하기
			int comInfoPwdCnt = this.boardDAO.getComInfoPwdCnt(boardDTO);
			if( comInfoPwdCnt==0 ) {return -1;}
			// 수정 실행하고 수정 적용행의 개수 얻기
			int comInfoUpCnt = this.boardDAO.updateComInfo(boardDTO);
			// 수정 적용행의 개수 리턴히기
			return comInfoUpCnt;
		
		}
		
		@Override
		public int updateComMem(BoardDTO boardDTO) {
			int comMemCnt = this.boardDAO.getComMemCnt( boardDTO.getC_no() );
			if( comMemCnt==0 ) { return comMemCnt; }
			// 수정 실행하고 수정 적용행의 개수 얻기
			int comMemUpCnt = this.boardDAO.updateComMem(boardDTO);
			// 수정 적용행의 개수 리턴히기
			return comMemUpCnt;
		}
		
		
		@Override
		public int updateComWel(BoardDTO boardDTO) {
			
			int comWelCnt = this.boardDAO.getComUpWelCnt( boardDTO.getC_no() );
			if( comWelCnt==0 ) { return comWelCnt; }
			
			int comWelDelCnt = this.boardDAO.deldateComWel(boardDTO);
			
			// 수정 실행하고 수정 적용행의 개수 얻기
			int comMemUpCnt = this.boardDAO.updateComWel(boardDTO);
			// 수정 적용행의 개수 리턴히기
			return comMemUpCnt;
		}

		@Override
		public int getcompanyListAllCnt(BoardSearchDTO boardSearchDTO) {
			int companyAllListCnt = this.boardDAO.getcompanyListAllCnt(boardSearchDTO);
			
			//--------------------------------------
			// 변수 boardListCnt 안의 데이터를 리턴하기
			//--------------------------------------
			return companyAllListCnt;
		}

		@Override
		public BoardDTO getcompanyWelfare(int c_no) {
			BoardDTO welfare = this.boardDAO.getcompanyWelfare(c_no);

			return welfare;
		}

		@Override
		public int getnoticeListCnt(BoardSearchDTO boardSearchDTO) {
			int noticeListCnt = this.boardDAO.getnoticeListCnt(boardSearchDTO);
			
			//--------------------------------------
			// 변수 boardListCnt 안의 데이터를 리턴하기
			//--------------------------------------
			return noticeListCnt;
		}

		@Override
		@Cacheable(value = "noticeList", key = "'page:' + #boardSearchDTO.selectPageNo + ':row:' + #boardSearchDTO.rowCntPerPage")
		public List<BoardDTO> getNoticeList(BoardSearchDTO boardSearchDTO) {
			List<BoardDTO> noticeList = this.boardDAO.getNoticeList( boardSearchDTO );

			return noticeList;
		}

		@Override
		public int getnoticeListAllCnt(BoardSearchDTO boardSearchDTO) {
	int noticeAllListCnt = this.boardDAO.getnoticeListAllCnt(boardSearchDTO);
	
			//--------------------------------------
			// 변수 boardListCnt 안의 데이터를 리턴하기
			//--------------------------------------
			return noticeAllListCnt;
		}

		@Override
		public BoardDTO getNotice(int n_no) {
			
			
//			BoardDAOImpl 객체의 getBoard 메소드를 호출하여
//			1개의 게시판 글 을 얻는다.
//			존재하지 않는 게시판 글일 경우 null로 들어온다.
			int updateCount = this.boardDAO.updateNoticeReadcount(n_no);

			BoardDTO boardDTO  = this.boardDAO.getNoticeDetail(n_no);
			//------------------------------------------
			// [1개 게시판 글]이 저장된 BoardDTO 객체 리턴하기
			//------------------------------------------
			return boardDTO;
		}
	public BoardDTO getNoticeUpDel(int n_no) {
			
			
//			BoardDAOImpl 객체의 getBoard 메소드를 호출하여
//			1개의 게시판 글 을 얻는다.
//			존재하지 않는 게시판 글일 경우 null로 들어온다.

			BoardDTO boardDTO  = this.boardDAO.getNoticeDetail(n_no);
			//------------------------------------------
			// [1개 게시판 글]이 저장된 BoardDTO 객체 리턴하기
			//------------------------------------------
			return boardDTO;
		}

		@Override
		public List<BoardDTO> getMainNoticeList(BoardSearchDTO boardSearchDTO) {
			List<BoardDTO> MainNoticeList = this.boardDAO.getMainNoticeList( boardSearchDTO );
			
			return MainNoticeList;
		}


		//관리자
		@Override
		public int getMemberListCnt(BoardSearchDTO boardSearchDTO) {
			int MemberListCnt = this.boardDAO.getMemberListCnt( boardSearchDTO );
			
			return MemberListCnt;
		}

		@Override
		public int getMemberListAllCnt(BoardSearchDTO boardSearchDTO) {
			int MemberListAllCnt = this.boardDAO.getMemberListAllCnt(boardSearchDTO);
			
			//--------------------------------------
			// 변수 boardListCnt 안의 데이터를 리턴하기
			//--------------------------------------
			return MemberListAllCnt;
		}

		@Override
		public List<BoardDTO> getMemberList(BoardSearchDTO boardSearchDTO) {
			List<BoardDTO> memberList = this.boardDAO.getMemberList( boardSearchDTO );
			
			return memberList;
		}

		@Override
		public int getBlockMemberListCnt(BoardSearchDTO boardSearchDTO) {
			int blockMemberListCnt = this.boardDAO.getBlockMemberListCnt( boardSearchDTO );
			
			return blockMemberListCnt;
		}

		@Override
		public int getBlockMemberListAllCnt(BoardSearchDTO boardSearchDTO) {
			int blockMemberListAllCnt = this.boardDAO.getBlockMemberListAllCnt(boardSearchDTO);
			
			//--------------------------------------
			// 변수 boardListCnt 안의 데이터를 리턴하기
			//--------------------------------------
			return blockMemberListAllCnt;
		}

		@Override
		public List<BoardDTO> getBlockMemberList(BoardSearchDTO boardSearchDTO) {
			List<BoardDTO> blockMemberList = this.boardDAO.getBlockMemberList( boardSearchDTO );
			
			return blockMemberList;
		}

		@Override
		@Cacheable(value = "salaryData", key = "'all'")
		public List<BoardDTO> getSalaryData() {
			List<BoardDTO> SalaryData = this.boardDAO.getSalaryData();

	        return SalaryData;
		}
		@Override
		@Cacheable(value = "fieldGonggoData", key = "'all'")
		public List<BoardDTO> getFieldGonggoData(){
			List<BoardDTO> FieldData = this.boardDAO.getFieldGonggoData();

			return FieldData;
		}
		@Override
		@Cacheable(value = "popularCom", key = "'top'")
		public List<BoardDTO> getpopularCom(){
			List<BoardDTO> popularCom = this.boardDAO.getpopularCom();

			return popularCom;
		}
		@Override
		@Cacheable(value = "regionCounts", key = "'all'")
		public List<BoardDTO> getRegionCounts(){
			List<BoardDTO> getRegionCounts = this.boardDAO.getRegionCounts();

			return getRegionCounts;
		}
		
		@Override
		public List<BoardDTO> getHope_Salary(){
			List<BoardDTO> getHope_Salary = this.boardDAO.getHope_Salary();
			
			return getHope_Salary;
		}

		@Override
		public List<BoardDTO> getHope_Field(){
			List<BoardDTO> getHope_Field = this.boardDAO.getHope_Field();
			
			return getHope_Field;
		}

		@Override
		public List<BoardDTO> getPer_Region(){
			List<BoardDTO> getPer_Region = this.boardDAO.getPer_Region();
			
			return getPer_Region;
		}

		@Override
		public BoardDTO getSexRatio(){
			BoardDTO getSexRatio = this.boardDAO.getSexRatio();
			
			return getSexRatio;
		}

		@Override
		public BoardDTO getMemberRatio(){
			BoardDTO getMemberRatio = this.boardDAO.getMemberRatio();
			
			return getMemberRatio;
		}

		@Override
		public List<BoardDTO> getMemberPerMonthCnt(){
			List<BoardDTO> getMemberPerMonthCnt = this.boardDAO.getMemberPerMonthCnt();
			
			return getMemberPerMonthCnt;
		}

		
}
