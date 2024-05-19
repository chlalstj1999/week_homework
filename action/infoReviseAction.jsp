<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    request.setCharacterEncoding("utf-8");

    Integer accountIdx = (Integer) session.getAttribute("account_idx");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String birth = request.getParameter("birth");
    String gender = request.getParameter("gender");
    String phonenumber = request.getParameter("phonenumber");
    String errorMessage = null;

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/homework1", "stageus", "1234");

        String sql = "SELECT email FROM account WHERE email=?";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, email);
        
        ResultSet result = query.executeQuery();

        if (result.next()) {
            throw new Exception("이미 존재하는 이메일입니다")
        }

        sql = "SELECT phonenumber FROM account WHERE phonenumber=?;";
        query = connect.prepareStatement(sql);
        query.setString(1, phonenumber);

        result = query.executeQuery();

        if (result.next()) {
            throw new Exception("이미 존재하는 전화번호입니다")
        }

        sql = "UPDATE account SET name=?, email=?, birth=?, gender=?, phonenumber=? WHERE idx=?;";
        query = connect.prepareStatement(sql);
        query.setString(1, name);
        query.setString(2, email);
        query.setString(3, birth);
        query.setString(4, gender);
        query.setString(5, phonenumber);
        query.setInt(6, accountIdx);

        query.executeUpdate();
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
    <% if (errorMessage == null) { %>
        <p>정보가 수정되었습니다</p>
        <input type=button value="확인" onclick="closeEvent()">

        <script>
            function closeEvent() {
                location.href = "../page/infoPage.jsp"
            }
        </script>
    <% } else { %>
        <script>
            alert("<%=errorMessage%>")
        </script>
    <% } %>
</body>