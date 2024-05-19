<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    request.setCharacterEncoding("utf-8");

    Integer accountIdx = (Integer) session.getAttribute("account_idx");
    String categoryIdx = request.getParameter("categoryIdx");
    String categoryName = request.getParameter("categoryName");
    boolean isLogin = false;
    ResultSet result = null;
    String errorMessage = null;

    try {
        if (accountIdx == null) {
            throw new Exception("로그인 후 이용해주세요");
        } else {
            isLogin = true;
        }

        Class.forName("org.mariadb.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/homework1", "stageus", "1234");

        String sql = "SELECT idx, title FROM post WHERE category_idx=? ORDER BY created_at DESC;";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, categoryIdx);

        result = query.executeQuery();
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
        <a href="mainPage.jsp">메인페이지</a>
        <h1>'<%=categoryName%>' 관련 게시글 목록</h1>

        <table>
            <tr>
                <th>게시글 번호</th>
                <th>게시글 제목</th>
            </tr>
            <% 
            int num = 1;
            while(result.next()) { 
            %>
                <tr>
                    <td><%=num%></td>
                    <td><a href="postContentPage.jsp?postIdx=<%=result.getString(1)%>"><%=result.getString(2)%></a></td>
                </tr>
            <%
            num++;
            } %>
        </table>

        <input type="button" value="게시글 쓰기" onclick="writePostEvent()">

        <script>
            function writePostEvent() {
                location.href="writePostPage.jsp?categoryIdx=<%=categoryIdx%>&categoryName=<%=categoryName%>"
            }
        </script>
    <% } else { %>
        <script>
            alert("<%=errorMessage%>")
            location.href = "../index.jsp"
        </script>
    <% } %>
</body>