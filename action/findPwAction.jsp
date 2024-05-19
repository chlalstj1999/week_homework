<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    request.setCharacterEncoding("utf-8");

    String idValue = request.getParameter("id");
    ResultSet result = null;
    String errorMessage = null;

    try {
        if (idValue == "") {
            throw new Exception("아이디를 입력해주세요.");
        }

        Class.forName("org.mariadb.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/homework1", "stageus", "1234");

        String sql = "SELECT password FROM account WHERE id=?;";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, idValue);

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
    <% if (errorMessage == null) { %>
        <% if (result.next()) { %>
            <p> password는 <%=result.getString(1)%>입니다. </p>
            <input type="button" value="확인" onclick="loginEvent()"> 
        <% } else { %>
            <p> 회원이 아니거나 잘못 입력하였습니다. </p>
            <input type="button" value="다시 입력" onclick="reinputEvent()">
            <input type="button" value="회원가입" onclick="signupEvent()"> 
            <input type="button" value="닫기" onclick="loginEvent()"> 
        <% } %>

        <script>
            function loginEvent() {
                location.href="../index.jsp"
            }

            function reinputEvent() {
                location.href="../page/findPwPage.jsp"
            }

            function signupEvent() {
                location.href="../page/signupPage.jsp"
            }
        </script>
    <% } else { %>
            <script>
                alert("<%=errorMessage%>")
                location.href = "../page/findPwPage.jsp"
            </script>
    <% } %>
 </body>