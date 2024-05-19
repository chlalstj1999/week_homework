<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <table>
        <tr>
            <td>이름</td>
            <td><input type="text" id="name" placeholder="이름"></td>
        </tr>
        <tr>
            <td>email</td>
            <td><input type="text" id="email" placeholder="이메일 주소"></td>
        </tr>
        <tr>
            <td>전화번호</td>
            <td><input type="text" id="phonenumber" placeholder="휴대전화번호"></td>
        </tr>
    </table>
    <input type="button" value="아이디 찾기" onclick="checkEvent()">

    <script>
        function checkEvent() {
            var name = document.getElementById("name").value
            var email = document.getElementById("email").value
            var phonenumber = document.getElementById("phonenumber").value
            
            if (!name) {
                alert("이름을 입력해주세요!")
            } else if (!email) {
                alert("이메일을 입력해주세요!")
            } else if (!phonenumber) {
                alert("핸드폰번호를 입력해주세요!")
            } else {
                location.href = "../action/findIdAction.jsp?name=" + name + "&email=" + email + "&phonenumber=" + phonenumber
            }
        }   
    </script>
</body>