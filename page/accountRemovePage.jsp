<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h1> 회원탈퇴 </h1>
    <form name="accountRemoveForm" action="../action/accountRemoveAction.jsp">
        <table>
            <tr>
                <td>비밀번호</td>
                <td><input type="password" name="pw" placeholder="비밀번호"></td>
            </tr>
        </table>
        <input type="button" value="탈퇴하기" onclick="accountRemoveEvent()">
        <input type="button" value="취소" onclick="closeEvent()">
    </form>

    <script>
        function accountRemoveEvent() {
            var accountRemoveForm = document.accountRemoveForm
            var pw = document.getElementsByName("pw")[0].value

            if (!pw) {
                alert("비밀번호를 입력해주세요")
            } else if (confirm("정말 탈퇴하시겠습니까?")) {
                accountRemoveForm.submit()
            }
        }

        function closeEvent() {
            location.href="infoPage.jsp"
        }
    </script>
</body>