<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%  
    request.setCharacterEncoding("utf-8");

    String errorMessage = null;
    boolean isLoginSuccess = false;

    String idValue = request.getParameter("id_value");
    String pwValue = request.getParameter("pw_value");

    try {
        if (idValue == "") {
            throw new NullPointerException("아이디를 입력해주세요");
        } else if (pwValue == "") {
            throw new NullPointerException("비밀번호를 입력해주세요");
        }

        Class.forName("org.mariadb.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/homework1", "stageus", "1234");

        String sql = "SELECT idx FROM account WHERE id=? AND password=?";
        PreparedStatement query = connect.prepareStatement(sql);

        query.setString(1, idValue);
        query.setString(2, pwValue);

        ResultSet result = query.executeQuery();

        if (result.next()) {
            isLoginSuccess = true;
            session.setAttribute("account_idx", result.getInt(1));
        } else {
            errorMessage = "아이디 또는 비밀번호가 틀렸습니다";
        }
    } catch (NullPointerException e) {
        errorMessage = e.getMessage();
    } catch (Exception e) {
        errorMessage = "로그인 중 알 수 없는 오류가 발생했습니다. 새로고침 후 다시 이용해주세요.";
    } 
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        if(!<%=isLoginSuccess%>) {
            alert("<%=errorMessage%>")
            location.href = "../index.jsp"
        } else {
            location.href = "../page/mainPage.jsp"
        }

    </script>
</body>