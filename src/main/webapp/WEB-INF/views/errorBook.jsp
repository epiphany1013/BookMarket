<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet">
    <title>예외처리</title>
</head>
<body>

<nav class="navbar navbar-expand navbar-dark bg-dark">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-barnd" href="../home">Home</a>
        </div>
    </div>
</nav>
<div class="jumbotron">
    <div class="container">
        <h2 class="alert alert-danger">
            해당 도서가 존재하지 않습니다.<br>
            도서 ID : ${invalidBookId}
        </h2>
    </div>
</div>
<div class="container">
    <p>
        <a href="<c:url value="/books"/>" class="btn btn-primary">
            도서목록 &raquo;</a>
        </a>
    </p>
</div>

</body>
</html>
