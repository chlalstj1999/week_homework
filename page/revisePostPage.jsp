<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%  
    String postIdx = request.getParameter("postIdx");
    String title = null;
    String content = null;

    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/homework1", "stageus", "1234");

    String sql = "SELECT title, content FROM post WHERE idx=?;";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, postIdx);

    ResultSet result = query.executeQuery();

    if (result.next()) {
        title = result.getString(1);
        content = result.getString(2);
    }
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
    <h1>게시글 수정</h1>
    <form name="revisePostForm" action="../action/revisePostAction.jsp">
        <table>
            <tr>
                <td><input id="title" type="text" placeholder="제목" name="title" maxlength=50 value="<%=title%>"></td>
            </tr>
            <tr>
                <td><textarea placeholder="내용" name="content"><%=content%></textarea></td>
            </tr>
        </table>
        <input type="submit" value="수정하기">
        <input type="hidden" name="postIdx" value="<%=postIdx%>">
    </form>
    <input type="button" value="닫기" onclick="closeEvent()">

    <script>
        function closeEvent() {
            if (confirm("수정이 되지 않습니다")) {
                location.href="postContentPage.jsp?postIdx=<%=postIdx%>"
            }
        }
    </script>
</body>