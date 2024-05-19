<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    request.setCharacterEncoding("utf-8");

    String postIdx = request.getParameter("postIdx");
    String commentIdx = request.getParameter("commentIdx");
    String comment = null;

    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/homework1", "stageus", "1234");

    String sql = "SELECT content FROM comment WHERE idx=?;";
    
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, commentIdx);

    ResultSet result = query.executeQuery();

    result.next();
    comment = result.getString(1);
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        #comment {
            width: 700px;
        }
    </style>
</head>
<body>
    <form name="reviseCommentForm" action="../action/reviseCommentAction.jsp">
        <input id="comment" type="text" name="comment" placeholder="댓글" value="<%=comment%>">
        <input type="button" value="확인" onclick="reviseCommentEvent()">
        <input type="hidden" name="commentIdx" value="<%=commentIdx%>">
        <input type="hidden" name="postIdx" value="<%=postIdx%>">
    </form>
    </table>
    <script>
        function reviseCommentEvent() {
            var form = document.reviseCommentForm
            var comment = document.getElementsByName("comment")[0].value

            if (!comment) {
                alert("내용을 입력해주세요")
            } else {
                form.submit()
            }
        }
    </script>
</body>