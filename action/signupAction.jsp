<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.regex.Pattern"%>

<%
    request.setCharacterEncoding("utf-8");

    String name = request.getParameter("name");
    String idValue = request.getParameter("id");
    String pwValue = request.getParameter("pw");
    String email = request.getParameter("email");
    String birth = request.getParameter("birth");
    String gender = request.getParameter("gender");
    String phonenumber = request.getParameter("phonenumber");
    String errorMessage = null;

    try {
        if (name.isEmpty()) {
            throw new Exception("이름을 입력해주세요");
        } else if (idValue.isEmpty()) {
            throw new Exception("아이디를 입력해주세요");
        } else if (!Pattern.matches("^[a-zA-Z0-9]*$", idValue)) {
            throw new Exception("아이디는 영문자 또는 숫자만 가능합니다");
        } else if (pwValue.isEmpty()) {
            throw new Exception("비밀번호를 입력해주세요");
        } else if (!Pattern.matches("^(?=.*[a-zA-Z])(?=.*\\d).{8,15}$", pwValue)) {
            throw new Exception("비밀번호는 영문자와 숫자를 하나 이상 포함하고 8~15자리입니다");
        } else if (email.isEmpty()) {
            throw new Exception("이메일을 입력해주세요");
        } else if (!Pattern.matches("^[a-zA-Z0-9]+@[a-zA-Z0-9]+\\.[a-z]{2,}$", email)) {
            throw new Exception("이메일 형식을 다시 확인해주세요");
        } else if (birth.isEmpty()) {
            throw new Exception("생년월일을 입력해주세요");
        } else if (!Pattern.matches("^\\d{4}-\\d{2}-\\d{2}$", birth)) {
            throw new Exception("생년월일은 YYYY-MM-DD 형태로 입력해주세요");
        } else if (gender.isEmpty()) {
            throw new Exception("성별을 입력해주세요");
        } else if (!gender.equals("M") && !gender.equals("W")) {
            throw new Exception("성별 입력을 다시 확인해주세요!");
        } else if (phonenumber.isEmpty()) {
            throw new Exception("핸드폰번호를 입력해주세요");
        }

        Class.forName("org.mariadb.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/homework1", "stageus", "1234");
        
        String sql = "SELECT id FROM account WHERE id=?;";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, idValue); 

        ResultSet result = query.executeQuery();

        if (result.next()) {
            throw new Exception("존재하는 아이디입니다");
        }

        sql = "SELECT email FROM account WHERE email=?;";
        query = connect.prepareStatement(sql);
        query.setString(1, email); 

        result = query.executeQuery();

        if (result.next()) {
            throw new Exception("존재하는 이메일입니다");
        }

        sql = "SELECT phonenumber FROM account WHERE phonenumber=?;";
        query = connect.prepareStatement(sql);
        query.setString(1, phonenumber); 

        result = query.executeQuery();

        if (result.next()) {
            throw new Exception("존재하는 전화번호입니다");
        }

        sql = "INSERT INTO account (name, id, password, email, birth, gender, phonenumber) VALUES (?, ?, ?, ?, ?, ?, ?);";
        query = connect.prepareStatement(sql);
        query.setString(1, name);
        query.setString(2, idValue);
        query.setString(3, pwValue);
        query.setString(4, email);
        query.setString(5, birth);
        query.setString(6, gender);
        query.setString(7, phonenumber);

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
        <script>
            alert("회원가입에 성공하였습니다!")
            location.href = "../index.jsp"
        </script>
    <% } else { %>
        <script>
            alert("<%=errorMessage%>")
        </script>
    <% } %>
</body>