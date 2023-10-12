<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: gh
  Date: 2023/09/25
  Time: 12:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="<c:url value="/resources/css/bootstrap.min.css"/>"
          rel="stylesheet">
    <title>도서 목록</title>
</head>
<body>
<nav class="navbar navbar-expand navbar-dark bg-dark">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="./home">Home</a>
        </div>
    </div>
</nav>
<div class="jumbotron">
    <div class="container">
        <h1 class="display-3"> 도서 목록</h1>
    </div>
</div>
<div class="container">
    <div class="row" align="center">
        <c:forEach items="${bookList}" var="book">
            <div class="col-md-4">
                <c:choose>
                    <c:when test="${book.getBookImage() == null}">
                        <%--                        <img src="<c:url value="/Users/gh/Documents/code/java/BookMarket/src/main/webapp/resources/images/${book.getBookId()}.jpeg"/>"--%>
                        <%--                             style="width:60%"/>--%>
                        <%--            // java파일에서는 경로를 절대경로로 적어주어야하고, jsp에서는 상대경로로 적어주어야 한다.--%>

                        <img src="<c:url value="/resources/images/${book.getBookId()}.jpeg"/>"
                             style="width:60%"/>
                    </c:when>
                    <c:otherwise>
                        <img src="<c:url value="/resources/images/${book.getBookImage().getOriginalFilename()}"/>"
                             style="width:60%"/>
                    </c:otherwise>
                </c:choose>
                <h3>${book.name}</h3>
                <p>${book.author}</p>
                <br>${book.publisher} | ${book.releaseDate}
                <p align=left>${fn:substring(book.description, 0, 100)}...
                <p>${book.unitPrice}원
                <p><a href="<c:url value="/books/book?id=${book.bookId}"/>"
                      class="btn btn-Secondary" role="button">상세정보 &raquo;</a>
            </div>
        </c:forEach>
    </div>
    <hr>
    <footer>
        <p>&copy; BookMarket</p>
    </footer>
</div>
</body>
</html>
