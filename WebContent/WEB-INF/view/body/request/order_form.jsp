<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.onlynum{
	ime-mode:inactive;
}
</style>
<script type="text/javascript" src="/HealthJJang/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#errordiv").hide();
	$("#errorPassword").hide();
	$(".onlynum").keyup(function(){$(this).val( $(this).val().replace(/[^0-9]/g,"") );} );
	$(".onlyeng").keyup(function(){$(this).val( $(this).val().replace(/[^\!-z]/g,"") );} );
	$("#passwordCheck").on("keyup",function(){
		if(this.value != $("#password").val()){
			$("#errorPassword").html("<span style='font-size:small;color:red;'>비밀번호가 같지 않습니다.</span>");
			$("#errorPassword").show();
		}else{
			$("#errorPassword").html("<span style='font-size:small;color:green;'>비밀번호가 같습니다.</span>");
			$("#errorPassword").show();
		}
	});
	$("#phone2").on("keyup",function(){
		if(this.value.length > 4){
			alert("전화번호는 4자리 이하입니다.");
			$("#phone2").val("");
		}
		
	});
	$("#phone3").on("keyup",function(){
		if(this.value.length > 4){
			alert("전화번호는 4자리 이하입니다.");
			$("#phone3").val("");
		}
		
	});
});
function error(){
	var memberNo = "${sessionScope.member.memberNo}";
	
	var password = $("#password").val();
	var passwordCheck = $("#passwordCheck").val();
	var buyerName = $("#buyerName").val();
	var postCode = $("#sample3_postcode").val();
	var address = $("#sample3_address").val();
	var phone2 = $("#phone2").val();
	var phone3 = $("#phone3").val();
	errorMessage = "";
if(memberNo != ""){
	if(postCode == ""){
		errorMessage = errorMessage+"<span style='font-size: small;color: red;'>우편번호를 입력하세요.</span><br>";
	}
	if(address == ""){
		errorMessage = errorMessage+"<span style='font-size: small;color: red;'>주소를 입력하세요.</span><br>";
	}
	if(phone2 == ""||phone3 == ""){
		errorMessage = errorMessage+"<span style='font-size: small;color: red;'>전화번호를 입력하세요.</span><br>";
	}
	if(errorMessage ==""){
		return true;
	}else{
		$("#errordiv").html(errorMessage);
		
		$("#errordiv").show();
		
		return false;
	}
	}
	
	if(buyerName == ""){
		errorMessage = errorMessage+"<span style='font-size: small;color: red;'>이름을 입력하세요</span><br>";
	}
	if(postCode == ""){
		errorMessage = errorMessage+"<span style='font-size: small;color: red;'>우편번호를 입력하세요.</span><br>";
	}
	if(address == ""){
		errorMessage = errorMessage+"<span style='font-size: small;color: red;'>주소를 입력하세요.</span><br>";
	}
	if(phone2 == ""||phone3 == ""){
		errorMessage = errorMessage+"<span style='font-size: small;color: red;'>전화번호를 입력하세요.</span><br>";
	}
	if(password == ""){
		errorMessage = errorMessage+"<span style='font-size: small;color: red;'>비밀번호를 입력하세요.</span><br>";
	}
	if(password.length >=7){
		errorMessage = errorMessage+"<span style='font-size: small;color: red;'>비밀번호는 8자 이하입니다.</span><br>";
		
	}
	if(passwordCheck == ""){
		errorMessage = errorMessage+"<span style='font-size: small;color: red;'>비밀번호 확인을 입력하세요.</span><br>";
	}
	if(errorMessage ==""){
		return true;
	}else{
		$("#errordiv").html(errorMessage);
		
		$("#errordiv").show();
		
		return false;
	}
		
	
}
</script>
<h2>배송입력칸</h2>
<form action="/HealthJJang/addOrderation.do" onsubmit="return error();">
<div id="errordiv"></div>
주문상품 <input type="text" name="productName" readonly="readonly" value="${requestScope.result.productName}" style="text-align: right;background-color: #A4A4A4;"><br>
주문수량 <input type="text" name="productAmount" readonly="readonly" value="${requestScope.result.userAmount}" style="text-align: right;background-color: #A4A4A4;"><br>
주문가격 <input type="text" name="price" readonly="readonly" value="${requestScope.result.price}" style="text-align: right;background-color: #A4A4A4;"><br>
분류  <input type="text" name="code" readonly="readonly" value="${requestScope.result.category}" style="text-align: right;background-color: #A4A4A4;"><br>

<c:choose>
<c:when test="${sessionScope.member.memberNo == null }">
주문자 이름 <input type="text" name="buyerName" id="buyerName"><br>
</c:when>
<c:otherwise>
주문자 이름 <input type="text" readonly="readonly" value="${sessionScope.member.memberName}" name="buyerName" style="text-align: right;background-color: #A4A4A4;"><br>
</c:otherwise>
</c:choose>


우편번호:<input type="text" name="postalNumber" id="sample3_postcode" placeholder="우편번호"> -
<input type="button" onclick="sample3_execDaumPostcode()" value="우편번호 찾기"><br>

<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
</div>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="sample3_address" name="orderationAddress" class="d_form large" placeholder="주소">
 
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function sample3_execDaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample3_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample3_address').value = fullAddr;

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script>
&nbsp;&nbsp;<br>연락처 <select name="phone1"><option>010</option><option>011</option><option>016</option><option>017</option></select>
&nbsp; <input class="onlynum" type="text" id="phone2" name="phone2" style="ime-mode:inactive;" size="4"> &nbsp; <input type="text" id="phone3" style="ime-mode:inactive;" class="onlynum" name="phone3" size="4"><br>
<c:choose>
<c:when test="${sessionScope.member == null }">
<strong>비밀번호를 입력하세요</strong><br>
비밀번호 : <input type="password" name="password" id="password"><br>
비밀번호 확인 : <input type="password" id="passwordCheck">
</c:when>
<c:otherwise>
<input type="hidden" name="memberNo" value="${sessionScope.member.memberNo }">
</c:otherwise>
</c:choose>
<div id="errorPassword"></div>
<input type="submit" value="구매하기" >
<input type="hidden" name="productNo" value="${requestScope.result.productNo}">
</form>