<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<% 
    Integer accountIdx = (Integer) session.getAttribute("account_idx");
    String username = "";
    ResultSet result2 = null;
    boolean isLogin = false;
    String errorMessage = null;

    try {
        if (accountIdx == null) {
            throw new Exception("로그인 후 이용해주세요");
        } else {
            isLogin = true;
        }

        Class.forName("org.mariadb.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/homework1", "stageus", "1234");

        String sql = "SELECT name FROM account WHERE idx=?;";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setInt(1, accountIdx);
    
        ResultSet result = query.executeQuery();

        if (result.next()) {
            username = result.getString(1);
        }

        sql = "SELECT * FROM category;";
        query = connect.prepareStatement(sql);
        
        result2 = query.executeQuery();

    } catch (Exception e) {
        errorMessage = e.getMessage();
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <% if (isLogin) { %>
        <%=username%>님, 환영합니다! 
        <input type="button" value="logout" onclick="logoutEvent()">
        <h2>내 정보</h2>
        <a href="infoPage.jsp">내 정보 보기</a>

        <h2>게시판 카테고리</h2>
        <ol>
            <% while(result2.next()) { %>
                <li><a href="postListPage.jsp?categoryIdx=<%=result2.getString(1)%>&categoryName=<%=result2.getString(2)%>"><%=result2.getString(2)%></a></li>
            <% } %> 
        </ol>

        <script>
            if (<%=errorMessage%> != null) {
                alert("<%=errorMessage%>")
            }
            function logoutEvent() {
                if (confirm("로그아웃 하시겠습니까?")) {
                    location.href = "../action/logoutAction.jsp"
                }
            }
        </script>
    <% } else { %>
        <script>
            alert("<%=errorMessage%>")
            location.href = "../index.jsp"
        </script>
    <% } %>
</body>