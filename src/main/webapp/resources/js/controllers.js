function addToCart(action) {
    document.addForm.action = action;
    document.addForm.submit();
    alert("도서가 장바구니에 추가되었습니다!");
}


// function removeFromCart(action) {
//     document.removeForm.action = action;
//     document.removeForm.submit();
//     // window.location.reload();
// }
function removeFromCart(action) {
    document.removeForm.action = action;
    document.removeForm.submit();
    // window.location.reload();
    setTimeout(function() {
        window.location.reload();
    }, 200); // 500ms 후에 페이지 새로고침
}


// function clearCart() {
//     document.clearForm.submit();
//     // window.location.reload();
// }

//window.location.reload()로 새로고침을 바로 해버릴 경우 요청처리가 되지 않은 상태에서 새로고침이 먼저 되어버리는 문제 발생,
//로깅 확인 결과 처리에 20ms를 넘는 경우가 없기 때문에 이보다 큰 값으로 시간차를 두고 새로고침을 해주면 문제해결 된다.

function clearCart() {
    document.clearForm.submit();
    setTimeout(function() {
        window.location.reload();
    }, 200); // 500ms 후에 페이지 새로고침
}

