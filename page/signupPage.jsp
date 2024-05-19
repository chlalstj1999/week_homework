<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h1>회원가입</h1>
    <form name="signupForm" action="../action/signupAction.jsp">
        <table>
            <tr>
                <td>이름</td>
                <td><input type="text" name="name" placeholder="이름"></td>
            </tr>
            <tr>
                <td>아이디</td>
                <td><input type="text" name="id" placeholder="아이디"></td>
                <td>
                    <input type="button" value="아이디 중복확인" onclick="idCheckEvent()">
                    <input type="hidden" name="idDuplication" value="idUncheck">
                </td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td><input type="password" name="pw" placeholder="비밀번호"></td>
            </tr>
            <tr>
                <td>비밀번호 확인</td>
                <td><input type="password" name="pwCheck" placeholder="비밀번호 확인"></td>
            </tr>
            <tr>
                <td>email</td>
                <td><input type="text" name="email" placeholder="이메일주소"></td>
                <td>
                    <input type="button" value="이메일 중복확인" onclick="emailCheckEvent()">
                    <input type="hidden" name="emailDuplication" value="eamilUncheck">
                </td>
            </tr>
            <tr>
                <td>생년월일</td>
                <td><input type="text" name="birth" placeholder="YYYY-MM-DD"></td>
            </tr>
            <tr>
                <td>성별</td>
                <td><input type="text" name="gender" placeholder="M or W"></td>
            </tr>
            <tr>
                <td>전화번호</td>
                <td><input type="text" name="phonenumber" placeholder="휴대전화번호"></td>
                <td>
                    <input type="button" value="핸드폰번호 중복확인" onclick="phonenumberCheckEvent()">
                    <input type="hidden" name="phonenumberDuplication" value="phonenumberUncheck">
                </td>
            </tr>
        </table>
        <input type="button" value="회원가입" onclick="checkEvent()">
    </form>

    <script>
        var signupForm = document.signupForm
        
        function idCheckEvent() {
            var pattern = /^[a-zA-Z0-9]*$/
            var idValue = document.getElementsByName("id")[0].value

            if (!idValue) {
                alert("아이디를 입력해주세요")
            } else if (idValue.length < 5 || idValue.length > 15) {
                alert("아이디는 5~15자를 사용해주세요")
            } else if (!pattern.test(idValue)) {
                alert("아이디는 영문자 또는 숫자만 가능합니다")
            } else {
                window.open("../action/idCheckAction.jsp?id=" + idValue, "idCheckWin", "width=500 height=200")
            }
        }

        function idDuplicate(isDuplicate) {
            var idDuplication = document.getElementsByName("idDuplication")[0]
            var idValue = document.getElementsByName("id")[0]

            if (isDuplicate) {
                idValue.value=""
                idDuplication.value="idUncheck"
            } else {
                idDuplication.value="idCheck"
                idValue.disabled = true
            }
        }

        function emailCheckEvent() {
            var pattern = /^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-z]{2,}$/
            var emailValue = document.getElementsByName("email")[0].value

            if (!emailValue) {
                alert("이메일을 입력해주세요")
            } else if (!pattern.test(emailValue)) {
                alert("이메일 형식을 다시 확인해주세요")
            } else {
                window.open("../action/emailCheckAction.jsp?email=" + emailValue, "emailCheckWin", "width=500 height=200")
            }
        }

        function emailDuplicate(isDuplicate) {
            var emailDuplication = document.getElementsByName("emailDuplication")[0]
            var emailValue = document.getElementsByName("email")[0]

            if (isDuplicate) {
                emailValue.value=""
                emailDuplication.value="emailUncheck"
            } else {
                emailDuplication.value="emailCheck"
                emailValue.disabled = true
            }
        }

        function phonenumberCheckEvent() {
            var phonenumberValue = document.getElementsByName("phonenumber")[0].value

            if (!phonenumberValue) {
                alert("핸드폰 번호를 입력해주세요")
            } else {
                window.open("../action/phonenumberCheckAction.jsp?phonenumber=" + phonenumberValue, "phonenumberCheckWin", "width=500 height=200")
            }
        }

        function phonenumberDuplicate(isDuplicate) {
            var phonenumberDuplication = document.getElementsByName("phonenumberDuplication")[0]
            var phonenumberValue = document.getElementsByName("phonenumber")[0]

            if (isDuplicate) {
                phonenumberValue.value=""
                phonenumberDuplication.value="phonenumberUncheck"
            } else {
                phonenumberDuplication.value="phonenumberCheck"
                phonenumberValue.disabled = true
            }
        } 

        function checkValidDate(isValidDate) {
            var birth = signupForm.birth.value
            var dateParts = birth.split("-")

            var year = parseInt(dateParts[0])
            var month = parseInt(dateParts[1])
            var day = parseInt(dateParts[2])

            if (1900 <= year && year <= 2023) {
                if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
                    if (1 <= day && day <= 31) {
                        isValidDate = true
                    }
                } else if (month == 4 || month == 6 || month == 9 || month == 11) {
                    if (1 <= day && day <= 30) {
                        isValidDate = true
                    }
                } else if (month == 2) {
                    if (1 <= day && day <= 29) {
                        isValidDate = true
                    }
                }
            } else {
                isValidDate = false
            }

            return isValidDate
        }

        function checkEvent() {
            var isValidDate = false
            isValidDate = checkValidDate(isValidDate)

            var pwPattern = /^(?=.*[a-zA-Z])(?=.*\d).{8,15}$/
            var birthPattern = /^\d{4}-\d{2}-\d{2}$/

            if (!signupForm.name.value) {
                alert("이름을 입력해주세요!")
            } else if (!signupForm.id.value) {
                alert("아이디를 입력해주세요!")
            } else if (signupForm.idDuplication.value != "idCheck") {
                alert("아이디 중복체크를 해주세요!")
            } else if (!signupForm.pw.value) {
                alert("비밀번호를 입력해주세요!")
            } else if (!pwPattern.test(signupForm.pw.value)) {
                alert("비밀번호는 영문자와 숫자를 하나 이상 포함하고 8 ~ 15자리여야 합니다")
            } else if (!signupForm.pwCheck.value) {
                alert("비밀번호 확인을 해주세요!")
            } else if (signupForm.pw.value != signupForm.pwCheck.value) {
                alert("비밀번호를 동일하게 입력해주세요!")
            } else if (!signupForm.email.value) {
                alert("이메일을 입력해주세요!")
            } else if (signupForm.emailDuplication.value != "emailCheck"){
                alert("이메일 중복체크를 해주세요!")
            } else if (!signupForm.birth.value) {
                alert("생년월일을 입력해주세요!")
            } else if (!birthPattern.test(signupForm.birth.value)) {
                alert("생년월일은 YYYY-MM-DD 형태로 입력해주세요")
            } else if (!isValidDate) {
                alert("생년월일을 다시 한 번 확인해주세요(1900~2023년)")
            } else if (!signupForm.gender.value) {
                alert("성별을 입력해주세요!")
            } else if (signupForm.gender.value != 'M' && signupForm.gender.value != 'W') {
                alert("성별 입력을 다시 확인해주세요!")
            } else if (!signupForm.phonenumber.value) {
                alert("전화번호를 입력해주세요!")
            } else if (signupForm.phonenumberDuplication.value != "phonenumberCheck") {
                alert("전화번호 중복체크를 해주세요!")
            } else {
                signupForm.id.disabled = false
                signupForm.email.disabled = false
                signupForm.phonenumber.disabled = false
                signupForm.submit()
            }
        }
    </script>
</body>