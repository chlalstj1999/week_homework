<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    String postIdx = request.getParameter("postIdx");
    Integer accountIdx = (Integer) session.getAttribute("account_idx");
    Integer postAccountIdx = null;
    Integer commentAccountIdx = null;
    String name = null;
    String title = null;
    String content = null;
    String createdAt = null;
    String categoryIdx = null;
    String categoryName = null;
    boolean isSame = false;
    boolean isLogin = false;
    String errorMessage = null;
    ResultSet result2 = null;

    try {
        if (accountIdx == null) {
            throw new Exception("로그인 후 이용해주세요");
        } else {
            isLogin = true;
        }

        Class.forName("org.mariadb.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/homework1", "stageus", "1234");

        String sql = "SELECT * FROM post WHERE idx=?;";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, postIdx);

        ResultSet result = query.executeQuery();

        if (result.next()) {
            postAccountIdx = result.getInt(2);
            title = result.getString(3);
            content = result.getString(4);
            createdAt = result.getString(5);
            categoryIdx = result.getString(6);
            content = content.replace("\n", "<br>");
        } else {
            throw new Exception("존재하지 않는 게시물입니다");
        } 

                
        sql = "SELECT name FROM account WHERE idx=?;";
        query = connect.prepareStatement(sql);
        query.setInt(1, postAccountIdx);

        result = query.executeQuery();

        result.next();
        name = result.getString(1);

        if (accountIdx == postAccountIdx) {
            isSame = true;
        }

        sql = "SELECT name FROM category WHERE idx=?;";
        query = connect.prepareStatement(sql);
        query.setString(1, categoryIdx);

        result = query.executeQuery();

        result.next();
        categoryName = result.getString(1);

        sql = "SELECT account.name, comment.content, comment.created_at, comment.account_idx, comment.idx FROM comment JOIN account ON comment.account_idx = account.idx WHERE comment.post_idx = ? ORDER BY comment.created_at DESC;";
        query = connect.prepareStatement(sql);
        query.setString(1, postIdx);

        result2 = query.executeQuery();
    } catch (Exception e) {
        errorMessage = e.getMessage();
    }
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
    <% if (isLogin) { %>
        <% if (errorMessage == null) { %>
            <a href="postListPage.jsp?categoryIdx=<%=categoryIdx%>&categoryName=<%=categoryName%>">목록</a>
            <% if (isSame) { %>
                        <input type="button" value="수정" onclick="revisePostEvent()">
                        <input type="button" value="삭제" onclick="deletePostEvent()">
            <% } %>
            
            <h3><%=title%></h3>
            <p><%=content%></p>
            <div>작성자: <%=name%></div>
            <div>작성시간: <%=createdAt%></div>

            <form name="writeCommentForm" action="../action/writeCommentAction.jsp">
                <input id="comment" type="text" id="comment" placeholder="댓글">
                <input type="hidden" name="postIdx" value="<%=postIdx%>">
                <input type="button" value="댓글 쓰기" onclick="writeCommentEvent()">
            </form>
            <table>
                <% 
                while(result2.next()) {
                    commentAccountIdx = result2.getInt(4);
                    String commentIdx = result2.getString(5);
                %>
                    <tr>
                        <td><%=result2.getString(1)%></td>
                        <td><%=result2.getString(2)%></td>
                        <td><%=result2.getString(3)%></td>
                        <% 
                        if (accountIdx == commentAccountIdx) { 
                        %>
                        <td>
                            <input type="button" value="수정" onclick="reviseCommentEvent('<%=commentIdx%>')">
                            <input type="button" value="삭제" onclick="deleteCommentEvent('<%=commentIdx%>')">
                        </td>
                        <% } %>
                    </tr>
                <%
                } 
                %>
            </table>

            <script>
                function revisePostEvent() {
                    location.href="revisePostPage.jsp?postIdx=<%=postIdx%>"
                }

                function deletePostEvent() {
                    if (confirm("정말 삭제하시겠습니까?")) {
                        location.href="../action/deletePostAction.jsp?postIdx=<%=postIdx%>&categoryIdx=<%=categoryIdx%>"
                    }
                }

                function writeCommentEvent() {
                    var comment = document.getElementById("comment").value

                    if (!comment) {
                        alert("내용을 입력해주세요")
                    } else {
                        location.href = "../action/writeCommentAction.jsp?postIdx=<%=postIdx%>&comment=" + comment
                    }
                }

                function reviseCommentEvent(commentIdx) {
                    location.href="reviseCommentPage.jsp?postIdx=<%=postIdx%>&commentIdx="+ commentIdx
                }

                function deleteCommentEvent(commentIdx) {
                    if (confirm("정말 삭제하시겠습니까?")) {
                        location.href="../action/deleteCommentAction.jsp?postIdx=<%=postIdx%>&commentIdx="+ commentIdx
                    }
                }
            </script>
        <% } else { %>
            <script>
                alert("<%=errorMessage%>")
            </script>
        <% } %>
    <% } else { %>
        <script>
            alert("<%=errorMessage%>")
            location.href = "../index.jsp"
        </script>
    <% } %>
</body>