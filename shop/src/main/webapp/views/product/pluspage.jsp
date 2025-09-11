<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-sm-9">
  <h2>상품 검색</h2>
  <p>원하는 상품의 검색 조건을 입력하세요.</p>

  <%-- 검색 정보를 서버로 보낼 form --%>

  <form action="<c:url value="/product/search"/>" method="GET" class="form-inline" onsubmit="return validateForm()">
    <div class="form-group mx-sm-3 mb-2">
      <label for="productName" class="sr-only">상품 이름</label>
      <input type="text" class="form-control" id="productName" name="productName" placeholder="상품 이름">
    </div>
    <div class="form-group mx-sm-3 mb-2">
      <label for="startPrice" class="sr-only">최소 가격</label>
      <input type="number" class="form-control" id="startPrice" name="startPrice" placeholder="최소 가격">
    </div>
    <div class="form-group mx-sm-3 mb-2">
      <label for="endPrice" class="sr-only">최대 가격</label>
      <input type="number" class="form-control" id="endPrice" name="endPrice" placeholder="최대 가격">
    </div>
    <button type="submit">검색</button>
  </form>
</div>

<%-- ================== [새로운 코드 추가] ================== --%>
<script>
  function validateForm() {
    const productName = document.getElementById('productName').value;
    const startPrice = document.getElementById('startPrice').value;
    const endPrice = document.getElementById('endPrice').value;

    // [수정] || (OR) 연산자를 사용하여 세 개의 입력창 중 하나라도 비어있는지 확인합니다.
    if (productName.trim() === '' || startPrice.trim() === '' || endPrice.trim() === '') {
      // 하나라도 비어있으면 경고창을 띄웁니다.
      alert('모든 검색 조건을 입력해야 합니다.');
      // false를 반환하여 form 전송을 막습니다.
      return false;
    }

    // 세 칸이 모두 채워져 있을 경우에만 true를 반환하여 form을 전송합니다.
    return true;
  }
</script>