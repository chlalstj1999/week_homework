<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        a {
            text-decoration: none;
        }
    </style>
</head>
<body>
    <h1>Login</h1>
    <table>
        <tr>
            <td> 아이디 </td>
            <td> <input type="text" id="id_value" placeholder="아이디"> </td>
        </tr>
        <tr>
            <td> 비밀번호 </td>
            <td> <input type="password" id="pw_value" placeholder="비밀번호"> </td>
        </tr>
    <table>
    <div> <input type="button" value="로그인" onclick="checkLoginEvent(event)"> </div>
    <a href="page/findIdPage.jsp"> 아이디 찾기 | </a>
    <a href="page/findPwPage.jsp"> 비밀번호 찾기 </a>
    <div><a href="page/signupPage.jsp">회원가입</a><div>

    <script>
        function checkLoginEvent(e) {
            e.preventDefault()

            var idValue = document.getElementById("id_value").value
            var pwValue = document.getElementById("pw_value").value

            if (!idValue || !pwValue)
            {
                alert("아이디 또는 비밀번호를 입력해주세요")
            } else {
                location.href = "action/loginAction.jsp?id_value=" + idValue + "&pw_value=" + pwValue
            }
        }
    </script>
</body>