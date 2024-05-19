<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%  
    String postIdx = request.getParameter("postIdx");
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/homework1", "stageus", "1234");

    String sql = "UPDATE post SET title=?, content=? WHERE idx=?;";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, title);
    query.setString(2, content);
    query.setString(3, postIdx);

    query.executeUpdate();
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        alert("게시글이 수정되었습니다")
        location.href = "../page/postContentPage.jsp?postIdx=<%=postIdx%>"
    </script>
</body>