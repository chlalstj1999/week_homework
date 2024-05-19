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
            <h1>내 정보 수정</h1>
        <form name="reviseForm" action="../action/infoReviseAction.jsp">
            <table>
                <tr>
                    <td>이름 : </td>
                    <td><input type="text" name="name" value=<%= name %> onChange="changeCheckEvent()"></td>
                </tr>
                <tr>
                    <td>이메일 : </td>
                    <td>
                    <input type="text" name="email" value=<%=email %> onChange="changeEmailEvent()">
                    <input type="button" id="emailCheckBtn" value="이메일 중복확인" onclick="emailCheckEvent()">
                    <input type="hidden" name="emailDuplication" value="emailCheck">
                    </td>
                </tr>
                <tr>
                    <td>생년월일 : </td>
                    <td><input type="text" name="birth" value=<%=birth %> onChange="changeCheckEvent()"></td>
                </tr>
                <tr>
                    <td>성별 : </td>
                    <td><input type="text" name="gender" value=<%=gender%> onChange="changeCheckEvent()"></td>
                </tr>
                <tr>
                    <td>전화번호 : </td>
                    <td>
                        <input type="text" name="phonenumber" value=<%=phonenumber%> onChange="changePhonenumberEvent()">
                        <input type="button" id="phonenumberCheckBtn" value="핸드폰번호 중복확인" onclick="phonenumberCheckEvent()">
                        <input type="hidden" name="phonenumberDuplication" value="phonenumberCheck">       
                    </td>
                </tr>
            </table>
            <input type="button" id="reviseBtn" value="수정하기" onclick="reviseEvent()" disabled>
        </form>
        <input type="button" value="닫기" onclick="closeEvent()">

        <script>
            var reviseForm = document.reviseForm

            function changeCheckEvent() {
                var reviseBtn = document.getElementById("reviseBtn")

                reviseBtn.disabled = false
            }

            function changeEmailEvent() {
                var emailDuplication = document.getElementsByName("emailDuplication")[0]
                var reviseBtn = document.getElementById("reviseBtn")

                reviseBtn.disabled = false
                emailDuplication.value = "emailUncheck"
            }

            function changePhonenumberEvent() {
                var phonenumberDuplication = document.getElementsByName("phonenumberDuplication")[0]
                var reviseBtn = document.getElementById("reviseBtn")

                reviseBtn.disabled = false
                phonenumberDuplication.value = "phonnumberUncheck"
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
                }
            }

            function phonenumberCheckEvent() {
                var phonenumberValue = document.getElementsByName("phonenumber")[0].value

                if (!phonenumberValue) {
                    alert("이메일을 입력해주세요")
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
            }
            
            function reviseEvent() {
                var isValidDate = false
                checkValidDate(isValidDate)

                var birthPattern = /^\d{4}-\d{2}-\d{2}$/

                if (!reviseForm.name.value) {
                    alert("이름을 입력해주세요!")
                } else if (!reviseForm.email.value) {
                    alert("이메일을 입력해주세요!")
                } else if (reviseForm.emailDuplication.value != "emailCheck"){
                    alert("이메일 중복체크를 해주세요!")
                } else if (!reviseForm.birth.value) {
                    alert("생년월일을 입력해주세요!")
                } else if (!birthPattern.test(reviseForm.birth.value)) {
                    alert("생년월일을 확인해주세요")
                } else if (!isValidDate) {
                    alert("생년월일을 다시 한 번 확인해주세요(1900~2023년)")
                } else if (!reviseForm.gender.value) {
                    alert("성별을 입력해주세요!")
                } else if (reviseForm.gender.value != 'M' && reviseForm.gender.value != 'W') {
                    alert("성별 입력을 다시 확인해주세요!")
                } else if (!reviseForm.phonenumber.value) {
                    alert("전화번호를 입력해주세요!")
                } else if (reviseForm.phonenumberDuplication.value != "phonenumberCheck") {
                    alert("전화번호 중복체크를 해주세요!")
                } else {
                    reviseForm.submit()
                }
            }

            function closeEvent() {
                if (confirm("수정이 되지 않습니다")) {
                    location.href="infoPage.jsp"
                }
            }
        </script>
    <% } else { %>
        <script>
            alert("<%=errorMessage%>")
            location.href = "../index.jsp"
        </script>
    <% } %>
</body>