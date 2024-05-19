<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    request.setCharacterEncoding("utf-8");

    String phonenumberValue = request.getParameter("phonenumber");
    boolean isDuplicate = false;

    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/homework1", "stageus", "1234");

    String sql = "SELECT phonenumber FROM account WHERE phonenumber=?;";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, phonenumberValue);

    ResultSet result = query.executeQuery();

    if (result.next()) {
        isDuplicate = true;
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <% if (isDuplicate) { %>
        <p>이미 사용중인 전화번호입니다</p>
    <% } else { %>
        <p>사용 가능한 전화번호입니다</p>
    <% } %>
    <input type=button value="확인" onclick="closeWindowEvent()">

    <script>
        function closeWindowEvent() {
            window.opener.phonenumberDuplicate(<%=isDuplicate%>)
            window.close()
        }
    </script>
</body>