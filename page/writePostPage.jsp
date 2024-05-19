<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    String categoryIdx = request.getParameter("categoryIdx");
    String categoryName = request.getParameter("categoryName");
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        tr {
            border: 1px solid black;
        }

        #title{
            width: 500px;
        }

        textarea {
            width: 500px;
            height: 500px;

        }
    </style>
</head>
<body>
    <form name="writePostForm" action="../action/writePostAction.jsp">
        <input type="hidden" name="categoryIdx" value="<%=categoryIdx%>">
        <input type="hidden" name="categoryName" value="<%=categoryName%>">
        <table>
            <tr>
                <td><input id="title" type="text" placeholder="제목" name="title" maxlength=50></td>
            </tr>
            <tr>
                <td><textarea placeholder="내용" name="content"></textarea></td>
            </tr>
        </table>
        <input type="button" value="작성하기" onclick="inputCheckEvent()">
    </form>
    <script>
        function inputCheckEvent() {
            var writePostForm = document.writePostForm

            if (!writePostForm.title.value) {
                alert("제목을 입력해주세요")
            } else if (writePostForm.title.value.length > 50) {
                alert("제목은 50글자를 초과할 수 없습니다")
            } else if (!writePostForm.content.value) {
                alert("내용을 입력해주세요")
            } else if (writePostForm.content.value > 2000) {
                alert("내용은 2000자를 초과할 수 없습니다")
            } else {
                writePostForm.submit()
            }
        }
    </script>
</body>