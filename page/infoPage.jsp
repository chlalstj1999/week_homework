<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<% 
    Integer accountIdx = (Integer) session.getAttribute("account_idx");
    String name = null;
    String email = null;
    String birth = null;
    String gender = null;
    String phonenumber = null;
    boolean isLogin = false;
    String errorMessage = null;

    try {
        if (accountIdx == null) {
            throw new Exception("로그인 후 이용해주세요");
        } else {
            isLogin = true;
        }

        Class.forName("org.mariadb.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/homework1", "stageus", "1234");

        String sql = "SELECT * FROM account WHERE idx=?;";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setInt(1, accountIdx);

        ResultSet result = query.executeQuery();

        if (result.next()) {
            name = result.getString(1);
            email = result.getString(5);
            birth = result.getString(6);
            gender = result.getString(7);
            phonenumber = result.getString(8);
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
    <% if (isLogin) { %>
        <a href="mainPage.jsp">메인페이지</a>
        <h1>내 정보 보기</h1>
        <table>
            <tr>
                <td>이름 : </td>
                <td><%= name %></td>
            </tr>
            <tr>
                <td>이메일 : </td>
                <td><%=email %></td>
            </tr>
            <tr>
                <td>생년월일 : </td>
                <td><%=birth %></td>
            </tr>
            <tr>
                <td>성별 : </td>
                <td><%=gender%></td>
            </tr>
            <tr>
                <td>전화번호 : </td>
                <td><%=phonenumber%></td>
            </tr>
        </table>
        <input type="button" value="내 정보 수정" onclick="infoReviseEvent()">
        <input type="button" value="비밀번호 변경" onclick="pwReviseEvent()">
        <input type="button" value="회원 탈퇴" onclick="accountRemoveEvent()">

        <script>
            function infoReviseEvent() {
                location.href = "infoRevisePage.jsp"
            }

            function pwReviseEvent() {
                location.href = "revisePwPage.jsp"
            }

            function accountRemoveEvent() {
                location.href = "accountRemovePage.jsp"
            }

        </script>
    <% } else { %>
        <script>
            alert("<%=errorMessage%>")
            location.href = "../index.jsp"
        </script>
    <% } %>
    
</body>