<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="/WEB-INF/views/common.jsp"%>  

<!DOCTYPE html>
<html>

<head>

  
</head>
<body>
    <div id="container">    
  <%@ include file="header.jsp" %>



    
     
          <center>          
          <input type="button" value="개인" onCLick= "location.replace('/personalRegForm.do')">
          <input type="button" value="기업" onCLick= "location.replace('/companyRegForm.do')">
     </center>
      </form>
  </div>
       
       
</body>
<%@ include file="footer.jsp" %>
</html>
