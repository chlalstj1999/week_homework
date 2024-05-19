<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    request.setCharacterEncoding("utf-8");

    String postIdx = request.getParameter("postIdx");
    String commentIdx = request.getParameter("commentIdx");
    String comment = request.getParameter("comment");

    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/homework1", "stageus", "1234");

    String sql = "UPDATE comment SET content=? WHERE idx=?;";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, comment);
    query.setString(2, commentIdx);

    query.executeUpdate();
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        alert("댓글이 수정되었습니다")
        location.href = "../page/postContentPage.jsp?postIdx=<%=postIdx%>"
    </script>
</body>