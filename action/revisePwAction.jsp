<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.regex.Pattern"%>

<%
    request.setCharacterEncoding("utf-8");

    Integer accountIdx = (Integer) session.getAttribute("account_idx");
    String beforePw = request.getParameter("before_pw");
    String afterPw = request.getParameter("after_pw");
    boolean isConfirm = false;
    String errorMessage = null;

    try {
        if (beforePw.isEmpty()) {
            throw new Exception("현재 비밀번호를 입력해주세요");
        } else if (afterPw.isEmpty()) {
            throw new Exception("변경할 비밀번호를 입력해주세요");
        } else if (!Pattern.matches("^(?=.*[a-zA-Z])(?=.*\\d).{8,15}$", afterPw)) {
            throw new Exception("비밀번호는 영문자와 숫자를 하나 이상 포함하고 8 ~ 15자리여야 합니다");
        }

        Class.forName("org.mariadb.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/homework1", "stageus", "1234");

        String sql = "SELECT password FROM account WHERE idx=?;";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setInt(1, accountIdx);

        ResultSet result = query.executeQuery();

        if (result.next()) {
            String pw = result.getString(1);

            if (pw.equals(beforePw)) {
            isConfirm = true;

            sql = "UPDATE account SET password=? WHERE idx=?;";
            query = connect.prepareStatement(sql);
            query.setString(1, afterPw);
            query.setInt(2, accountIdx);

            query.executeUpdate();
            }
        }
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
        <% if (isConfirm) { %>
            <p>비밀번호가 변경되었습니다</p>
        <% } else { %>
            <p>비밀번호를 잘못 입력하셨습니다</p>
        <% } %>
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