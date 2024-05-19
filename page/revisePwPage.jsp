<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%
    Integer accountIdx = (Integer) session.getAttribute("account_idx");
    boolean isLogin = false;
    String errorMessage = null;

    try {
        if (accountIdx == null) {
            throw new Exception("로그인 후 이용해주세요");
        } else {
            isLogin = true;
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
        <h1> 비밀번호 변경 </h1>
        <form name="revisePwForm" action="../action/revisePwAction.jsp">
            <table>
                <tr>
                    <td>현재 비밀번호</td>
                    <td><input type="password" id="before_pw" placeholder="현재 비밀번호"></td>
                </tr>
                <tr>
                    <td>변경할 비밀번호</td>
                    <td><input type="password" id="after_pw" placeholder="변경할 비밀번호"></td>
                </tr>
                <tr>
                    <td>비밀번호 확인</td>
                    <td><input type="password" id="after_pwCheck" placeholder="변경할 비밀번호 확인"></td>
                </tr>
            </table>
            <input type="button" value="비밀번호 변경" onclick="revisePwEvent()">
            <input type="button" value="취소" onclick="closeEvent()">
        </form>

        <script>
            function revisePwEvent() {
                var beforePw = document.getElementById("before_pw").value
                var afterPw = document.getElementById("after_pw").value
                var afterPwCheck = document.getElementById("after_pwCheck").value
                var pwPattern = /^(?=.*[a-zA-Z])(?=.*\d).{8,15}$/

                if (!beforePw) {
                    alert("현재 비밀번호를 입력해주세요")
                } else if (!afterPw) {
                    alert("변경할 비밀번호를 입력해주세요")
                } else if (!afterPwCheck) {
                    alert("비밀번호 확인란을 채워주세요")
                } else if (!pwPattern.test(afterPw)) {
                    alert("비밀번호는 영문자와 숫자를 하나 이상 포함하고 8 ~ 15자리여야 합니다")
                } else if (afterPw != afterPwCheck) {
                    alert("비밀번호를 동일하게 입력해주세요")
                } else {
                    location.href = "../action/revisePwAction.jsp?before_pw=" + beforePw + "&after_pw=" + afterPw
                }
            }

            function closeEvent() {
                location.href="infoPage.jsp"
            }
        </script>
    <% } else { %>
        <script>
            alert("<%=errorMessage%>")
            location.href = "../index.jsp"
        </script>
    <% } %>
</body>