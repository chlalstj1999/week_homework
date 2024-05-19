<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<% 
    Integer accountIdx = (Integer) session.getAttribute("account_idx");
    String inputPw = request.getParameter("pw");
    String id = null;
    String password = null;
    boolean isConfirm = false;
    String errorMessage = null;

    try {
        if (inputPw.isEmpty()) {
            throw new Exception("비밀번호를 입력해주세요")
        }

        Class.forName("org.mariadb.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/homework1", "stageus", "1234");

        String sql = "SELECT id, password FROM account WHERE idx=?;";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setInt(1, accountIdx);

        ResultSet result = query.executeQuery();

        if (result.next()) {
            id = result.getString(1);
            password = result.getString(2);
            
            if (inputPw.equals(password)) {
                isConfirm = true;

                sql = "DELETE FROM account WHERE id=? AND password=?;";
                query = connect.prepareStatement(sql);
                query.setString(1, id);
                query.setString(2, password);

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
            <p>회원 탈퇴가 완료되었습니다</p>
            <input type=button value="확인" onclick="closeEvent1()">
        <% } else { %>
            <p>비밀번호를 잘못 입력하셨습니다</p>
            <input type=button value="확인" onclick="closeEvent2()">
        <% } %>

        <script>
            function closeEvent1() {
                location.href = "../action/logoutAction.jsp"
            }

            function closeEvent2() {
                location.href = "../page/accountRemovePage.jsp"
            }
        </script>
    <% } else { %>
        <script>
            alert("<%=errorMessage%>")
        </script>
    <% } %>
</body>