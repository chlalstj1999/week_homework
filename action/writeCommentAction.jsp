<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    request.setCharacterEncoding("utf-8");

    Integer accountIdx = (Integer) session.getAttribute("account_idx");
    String postIdx = request.getParameter("postIdx");
    String comment = request.getParameter("comment");

    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/homework1", "stageus", "1234");

    String sql = "INSERT INTO comment (account_idx, post_idx, content) VALUES (?, ?, ?);";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setInt(1, accountIdx);
    query.setString(2, postIdx);
    query.setString(3, comment);

    query.executeUpdate();
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        alert("작성 완료되었습니다")
        location.href = "../page/postContentPage.jsp?postIdx=<%=postIdx%>"
    </script>
</body>