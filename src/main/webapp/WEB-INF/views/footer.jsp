<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer>
    <div class="footer-inner">
        <div class="footer-top">
            <div class="footer-logo">
                <h3>12Wa~</h3>
                <p>당신의 커리어를 함께합니다</p>
            </div>
            <div class="footer-links">
                <div class="link-group">
                    <h4>서비스</h4>
                    <ul>
                        <li><a href="/gongGoList.do">채용정보</a></li>
                        <li><a href="/companyList.do">기업정보</a></li>
                        <li><a href="/resumeList.do">이력서</a></li>
                    </ul>
                </div>
                <div class="link-group">
                    <h4>커뮤니티</h4>
                    <ul>
                        <li><a href="javascript:pushboardname('freeboard','freedome')">자유게시판</a></li>
                        <li><a href="javascript:pushboardname('qnaboard','qna')">Q&A</a></li>
                        <li><a href="javascript:pushboardname('interviewboard','interview')">면접후기</a></li>
                    </ul>
                </div>
                <div class="link-group">
                    <h4>고객지원</h4>
                    <ul>
                        <li><a href="/notice.do">공지사항</a></li>
                        <li><a href="#">이용약관</a></li>
                        <li><a href="#">개인정보처리방침</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="footer-bottom">
            <div class="company-info">
                <p><strong>12Wa 구인구직</strong></p>
                <p>서울시 금천구 가산디지털2로 101, 한라원앤원타워 | 대표전화: 02-123-4567 | 이메일: support@12wa.co.kr</p>
                <p>Copyright &copy; 2024 12Wa. All rights reserved.</p>
            </div>
            <div class="social-links">
                <a href="#" title="Facebook"><i class="fab fa-facebook-f"></i></a>
                <a href="#" title="Instagram"><i class="fab fa-instagram"></i></a>
                <a href="#" title="YouTube"><i class="fab fa-youtube"></i></a>
                <a href="#" title="Blog"><i class="fas fa-blog"></i></a>
            </div>
        </div>
    </div>
</footer>

<style>
footer {
    background: linear-gradient(180deg, #1e293b 0%, #0f172a 100%);
    color: #94a3b8;
    padding: 60px 0 30px;
    margin-top: 60px;
}

.footer-inner {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}

.footer-top {
    display: flex;
    justify-content: space-between;
    padding-bottom: 40px;
    border-bottom: 1px solid #334155;
    margin-bottom: 30px;
}

.footer-logo h3 {
    font-size: 28px;
    font-weight: 700;
    color: #fff;
    margin-bottom: 8px;
}

.footer-logo p {
    font-size: 14px;
    color: #64748b;
}

.footer-links {
    display: flex;
    gap: 80px;
}

.link-group h4 {
    font-size: 15px;
    font-weight: 600;
    color: #fff;
    margin-bottom: 16px;
}

.link-group ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

.link-group ul li {
    margin-bottom: 10px;
}

.link-group ul li a {
    color: #94a3b8;
    font-size: 14px;
    transition: color 0.2s;
}

.link-group ul li a:hover {
    color: #fff;
}

.footer-bottom {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
}

.company-info p {
    font-size: 13px;
    color: #64748b;
    line-height: 1.8;
    margin: 0;
}

.company-info p strong {
    color: #94a3b8;
}

.social-links {
    display: flex;
    gap: 12px;
}

.social-links a {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 40px;
    height: 40px;
    background: #334155;
    color: #94a3b8;
    border-radius: 50%;
    font-size: 16px;
    transition: all 0.2s;
}

.social-links a:hover {
    background: #1A6DFF;
    color: #fff;
}

@media screen and (max-width: 768px) {
    .footer-top {
        flex-direction: column;
        gap: 40px;
    }

    .footer-links {
        gap: 40px;
        flex-wrap: wrap;
    }

    .footer-bottom {
        flex-direction: column;
        gap: 20px;
        align-items: flex-start;
    }
}
</style>
