<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <table>
        <tr>
            <td>아이디</td>
            <td><input type="text" id="id" placeholder="아이디"></td>
        </tr>
    </table>
    <input type="button" value="비밀번호 찾기" onclick="checkEvent()">

    <script>
        function checkEvent() {
            var id = document.getElementById("id").value
            
            if (!id) {
                alert("아이디를 입력해주세요!")
            } else {
                location.href = "../action/findPwAction.jsp?id=" + id
            }
        }
    </script>
</body>