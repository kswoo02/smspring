<%@ page contentType="text-html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- [추가 1] 카테고리 선택 시 ID를 표시하는 jQuery 스크립트 --%>
<script>
    $(function(){
    // id가 'cate'인 select 요소의 값이 변경될 때마다 이벤트를 실행합니다.
    $('#cate').on('change', function() {
    // 현재 선택된 option의 value 값(카테고리 ID)을 가져옵니다.
    let selectedId = $(this).val();

    // id가 'cateIdDisplay'인 div를 찾아서 그 안의 텍스트를 변경합니다.
    if (selectedId) {
    $('#cateIdDisplay').text('선택된 ID: ' + selectedId);
    } else {
    $('#cateIdDisplay').text('');
    }
    });
    });
</script>

    <div class="container-fluid">

    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Product Add</h1>
    </div>

    <div class="row">
        <div class="col-xl-10 col-lg-7">
            <div class="card shadow mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold text-primary">Product Register</h6>
                </div>
                <div class="card-body">
                    <form action="/product/registerimpl" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="name">Name:</label>
                            <input type="text" class="form-control" placeholder="Enter name" id="name" name="productName">
                        </div>
                        <div class="form-group">
                            <label for="price">Price:</label>
                            <input type="number" class="form-control" placeholder="Enter price" id="price" name="productPrice">
                        </div>
                        <div class="form-group">
                            <label for="rate">Discount Rate:</label>
                            <input type="number" min="0" step="0.1" class="form-control" placeholder="Enter discount rate" id="rate" name="discountRate">
                        </div>
                        <div class="form-group">
                            <label for="pimg">Product Image:</label>
                            <input type="file" class="form-control" placeholder="Select image" id="pimg" name="productImgFile">
                        </div>
                        <div class="form-group">
                            <label for="cate">Cate Id:</label>
                            <select class="form-control" name="cateId" id="cate">
                                    <%-- [추가 2] 사용자 안내를 위한 기본 선택 옵션 --%>
                                <option value="" disabled selected>-- 카테고리를 선택하세요 --</option>
                                <c:forEach var="ca" items="${cate}">
                                    <option value="${ca.cateId}">${ca.cateName}</option>
                                </c:forEach>
                            </select>
                                <%-- [추가 3] 선택된 ID가 표시될 div 영역 --%>
                            <div id="cateIdDisplay" class="mt-2 text-primary font-weight-bold">
                                    <%-- 여기에 선택된 카테고리의 ID가 표시됩니다. --%>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Register</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>