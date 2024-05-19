<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<% 
    String postIdx = request.getParameter("postIdx");

    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/homework1", "stageus", "1234");

    String sql = "DELETE FROM post WHERE idx=?;";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, postIdx);

    query.executeUpdate();

    String categoryIdx = request.getParameter("categoryIdx");
    String categoryName = null;

    sql = "SELECT name FROM category WHERE idx=?;";
    query = connect.prepareStatement(sql);
    query.setString(1, categoryIdx);

    ResultSet result = query.executeQuery();

    if (result.next()) {
        categoryName = result.getString(1);
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        alert("게시글이 삭제되었습니다")
        location.href = "../page/postListPage.jsp?categoryIdx=<%=categoryIdx%>&categoryName=<%=categoryName%>"
    </script>
</body>