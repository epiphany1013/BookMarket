<!DOCTYPE html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>Cart</title>
    <link href="<c:url value="/resources/css/bootstrap.min.css"/>"
          rel="stylesheet">
    <script src="<c:url value="/resources/js/controllers.js"/>"></script>
</head>
<body>
<nav class="navbar navbar-expand navbar-dark bg-dark">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="../">Home</a>
        </div>
    </div>
</nav>
<div class="jumbotron">
    <div class="container">
        <h1 class="display-3">장바구니</h1>
    </div>
</div>
<div class="container">
    <div>
        <form:form name="clearForm" method="delete">
            <a href="javascript:clearCart()" class="btn btn-danger pull-left">장바구니 삭제하기</a>
        </form:form>
        <a href="<c:url value="/order?cartId=${cartId}"/>" class="btn btn-success float-right">주문하기</a>
    </div>
    <div style="padding-top: 50px">
        <table class="table table-hover">
            <tr>
                <th>도서</th>
                <th>가격</th>
                <th>수량</th>
                <th>소계</th>
                <th>비고</th>
            </tr>
            <form:form name="removeForm" method="put">
                <%--                            PUT method로는 왜 안됐는지 찾을것 ,CartController에서 처리 메소드도 PutMapping으로 했는데 처리가 안돼서 둘 다 get, GetMapping으로 바꾸니 처리됨.--%>
                <%--                put method여서 안되었던 것이 아니라 controllers.js파일에서 새로고침을 바로 들어가서 요청처리가 되지 않았을 때 새로고침이 수행되어서 그랬음. put이든 get이든 둘 다 됨. 된다고 착각한 이유는 새로고침을 코드상으로 안하고--%>
                <%--                수동으로 F5를 눌러서 삭제가 되니 된다고 착각했던 것.--%>
                <%--                            <form:form name="removeForm" method="post">--%>
                <%--                                <input type="hidden" name="_method" value="put"/>--%>
                <c:forEach items="${cart.cartItems}" var="item">
                    <tr>
                        <td>${item.value.book.bookId}-${item.value.book.name}</td>
                        <td>${item.value.book.unitPrice}</td>
                        <td>${item.value.quantity}</td>
                        <td>${item.value.totalPrice}</td>
                        <td><a href="javascript:removeFromCart('../cart/remove/${item.value.book.bookId}')"
                               class="badge badge-danger">삭제</a></td>
                            <%--                        .. 처럼 상대경로 인식 가능, 아래는 절대 경로로 적었는데 경로 같음.--%>
                            <%--                        <td><a href="javascript:removeFromCart('http://localhost:8080/BookMarket/cart/remove/${item.value.book.bookId}')" class="badge badge-danger">삭제</a></td>--%>
                    </tr>
                </c:forEach>
            </form:form>
            <tr>
                <th></th>
                <th></th>
                <th>총액</th>
                <th>${cart.grandTotal}</th>
                <th></th>
            </tr>
        </table>
        <a href="<c:url value="/books"/>" class="btn btn-secondary">&laquo; 쇼핑 계속하기</a>
    </div>
    <hr>
    <footer>
        <p>&copy; BookMarket</p>
    </footer>
</div>
</body>
</html>