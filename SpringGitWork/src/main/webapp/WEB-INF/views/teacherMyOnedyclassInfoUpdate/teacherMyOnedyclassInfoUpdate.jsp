<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원데이 클래스 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<sec:csrfMetaTags />

<style>
body {
  font-family: 'Noto Sans KR', sans-serif;
  background-color: #f8f9fa;
  padding: 30px;
}

.form-container {
  max-width: 800px;
  margin: 0 auto;
  background: #fff;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 3px 10px rgba(0,0,0,0.1);
}

.form-group {
  margin-bottom: 18px;
}

.form-group label {
  font-weight: 600;
  display: block;
  margin-bottom: 6px;
}

.form-group input[type="text"],
.form-group textarea,
.form-group input[type="number"] {
  width: 100%;
  padding: 8px 10px;
  border-radius: 6px;
  border: 1px solid #ccc;
  transition: border-color 0.2s;
}

.form-group input:focus,
.form-group textarea:focus {
  border-color: #2a7ae2;
  outline: none;
}

.error-msg {
  display: none;
  color: red;
  font-size: 0.9em;
  margin-top: 2px;
}

button {
  background-color: #2a7ae2;
  color: white;
  border: none;
  padding: 10px 18px;
  border-radius: 6px;
  cursor: pointer;
  transition: 0.2s;
}

button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

button:hover:not(:disabled) {
  background-color: #1e5bb8;
}

/* 모달 스타일 */
.modal-overlay {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0,0,0,0.5);
  z-index: 999;
}

.modal {
  background: #fff;
  width: 400px;
  padding: 20px;
  border-radius: 8px;
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}

.modal p {
  margin-bottom: 20px;
  font-size: 1.1em;
}

.modal-buttons {
  text-align: right;
}

.modal-buttons button {
  margin-left: 10px;
}
</style>
</head>
<body>

<div class="form-container">
  <h2>원데이 클래스 정보 수정</h2>

  <form id="editForm">
    <div class="form-group">
      <label>클래스명</label>
      <input type="text" name="onedayclass_name">
      <div><span class="error-msg">2자 이상 20자 이하로 입력해주세요</span></div>
    </div>

    <div class="form-group">
      <label>가격</label>
      <input type="text" name="onedayclass_price">
      <div><span class="error-msg">숫자만 입력해주세요</span></div>
    </div>

    <div class="form-group">
      <label>클래스 설명</label>
      <textarea name="onedayclass_info" rows="4"></textarea>
      <div><span class="error-msg">10자 이상 200자 이하로 입력해주세요</span></div>
    </div>

    <div class="form-group">
      <label>주소</label>
      <input type="text" name="address">
      <div><span class="error-msg">5자 이상 200자 이하로 입력해주세요</span></div>
    </div>

    <div class="form-group">
      <label>주차 가능 여부</label>
      <input type="text" name="park">
      <div><span class="error-msg">가능 또는 불가능으로만 입력해주세요</span></div>
    </div>

    <div class="form-group">
      <label>수업 시간</label>
      <input type="text" name="playtime">
      <div><span class="error-msg">숫자만 입력해주세요 (분 단위)</span></div>
    </div>

    <div class="form-group">
      <label>최대 인원</label>
      <input type="text" name="maximum_guests">
      <div><span class="error-msg">숫자만 입력해주세요</span></div>
    </div>

    <button id="updateBtn" disabled>수정하기</button>
  </form>
</div>

<!-- 모달 -->
<div class="modal-overlay">
  <div class="modal">
    <p>정보 반영은 이미 결제가 완료된 고객들에게는 반영되지 않습니다.<br>동의 하십니까?</p>
    <div class="modal-buttons">
      <button id="modalNo">아니오</button>
      <button id="modalYes">예</button>
    </div>
  </div>
</div>

<script type="text/javascript">
var contextPath = "${pageContext.request.contextPath}";
var originalData = {};
var rawData = "${myOneDayClassInfo}";
originalData = parseServerData(rawData);
var currentDataBackup = { ...originalData }; // 복원용


const token = $("meta[name='_csrf']").attr("content");
const header = $("meta[name='_csrf_header']").attr("content");


$.ajaxSetup({
  beforeSend: function(xhr) {
    xhr.setRequestHeader(header, token);
  }
});  







// 초기값 세팅
$(document).ready(function() {
  for (var key in originalData) {
    var field = $("[name='" + key + "']");
    if (field.length > 0) {
      field.val(originalData[key]);
    }
  }
  $("#updateBtn").prop("disabled", true);
});

// 입력 유효성 & 변경 감지
$("#editForm input, #editForm textarea").on("input change", function() {
  validateInputs();
  checkChanges();
});

// 입력 필드별 제약조건 처리
function validateInputs() {
  var valid = true;

  var name = $("[name='onedayclass_name']");
  var info = $("[name='onedayclass_info']");
  var address = $("[name='address']");
  var price = $("[name='onedayclass_price']");
  var park = $("[name='park']");
  var playtime = $("[name='playtime']");
  var maxGuests = $("[name='maximum_guests']");

  // 클래스명
  var nameVal = name.val().trim();
  if (!nameVal || nameVal.length < 2 || nameVal.length > 20) {
    valid = false;
    name.css("border-color", "red");
    name.next("div").find("span.error-msg").show();
  } else {
    name.css("border-color", "#ccc");
    name.next("div").find("span.error-msg").hide();
  }

  // 클래스 설명
  var infoVal = info.val().trim();
  if (!infoVal || infoVal.length < 10 || infoVal.length > 200) {
    valid = false;
    info.css("border-color", "red");
    info.next("div").find("span.error-msg").show();
  } else {
    info.css("border-color", "#ccc");
    info.next("div").find("span.error-msg").hide();
  }

  // 주소
  var addrVal = address.val().trim();
  if (!addrVal || addrVal.length < 5 || addrVal.length > 200) {
    valid = false;
    address.css("border-color", "red");
    address.next("div").find("span.error-msg").show();
  } else {
    address.css("border-color", "#ccc");
    address.next("div").find("span.error-msg").hide();
  }

  // 가격
  var priceVal = price.val().replace(/[^0-9]/g, "");
  price.val(priceVal);
  if (priceVal === "" || parseInt(priceVal, 10) <= 0) {
    valid = false;
    price.css("border-color", "red");
    price.next("div").find("span.error-msg").show();
  } else {
    price.css("border-color", "#ccc");
    price.next("div").find("span.error-msg").hide();
  }

  // 주차
  var parkVal = park.val().trim();
  if (parkVal !== "가능" && parkVal !== "불가능") {
    valid = false;
    park.css("border-color", "red");
    park.next("div").find("span.error-msg").show();
  } else {
    park.css("border-color", "#ccc");
    park.next("div").find("span.error-msg").hide();
  }

  // 수업 시간
  var playtimeVal = playtime.val().replace(/[^0-9]/g, "");
  if (playtimeVal !== "") playtime.val(playtimeVal + "분");
  if (playtimeVal === "" || parseInt(playtimeVal, 10) <= 0) {
    valid = false;
    playtime.css("border-color", "red");
    playtime.next("div").find("span.error-msg").show();
  } else {
    playtime.css("border-color", "#ccc");
    playtime.next("div").find("span.error-msg").hide();
  }

  // 최대 인원
  var maxVal = maxGuests.val().replace(/[^0-9]/g, "");
  if (maxVal !== "") maxGuests.val(maxVal + "명");
  if (maxVal === "" || parseInt(maxVal, 10) <= 0) {
    valid = false;
    maxGuests.css("border-color", "red");
    maxGuests.next("div").find("span.error-msg").show();
  } else {
    maxGuests.css("border-color", "#ccc");
    maxGuests.next("div").find("span.error-msg").hide();
  }

  return valid;
}

// 변경 감지
function checkChanges() {
  var valid = validateInputs();
  var anyChanged = false;

  for (var key in originalData) {
    var field = $("[name='" + key + "']");
    if (field.length === 0) continue;
    var currentVal = field.val();
    var originalVal = (originalData[key] == null ? "" : String(originalData[key]));
    if (currentVal !== originalVal) {
      anyChanged = true;
      break;
    }
  }

  $("#updateBtn").prop("disabled", !(anyChanged && valid));
}

// 수정 버튼 클릭 → 모달 띄우기
$("#updateBtn").on("click", function(e) {
  e.preventDefault();
  if (!validateInputs()) {
    alert("입력값을 다시 확인하세요.");
    return;
  }
  $(".modal-overlay").show();
});

// 모달 예/아니오 버튼
$("#modalNo").on("click", function() {
  $(".modal-overlay").hide();
  // 입력값 복원
  for (var key in currentDataBackup) {
    $("[name='" + key + "']").val(currentDataBackup[key]);
  }
  checkChanges();
});

$("#modalYes").on("click", function() {
  $(".modal-overlay").hide();
  // 변경 데이터 수집
  var changedData = {};
  for (var key in originalData) {
    var newVal = $("[name='" + key + "']").val();
    var originalVal = (originalData[key] == null ? "" : String(originalData[key]));
    if (newVal !== originalVal) {
      changedData[key] = newVal;
    }
  }

  if ($.isEmptyObject(changedData)) {
    alert("변경된 내용이 없습니다.");
    return;
  }

  console.log(JSON.stringify(changedData));

  $.ajax({
    url: contextPath + "/api/teacher/update-onedayclassinfo",
    method: "POST",
    contentType: "application/json",
    data: JSON.stringify(changedData),
    success: function() {
      alert("수정 완료!");
      
    },
    
    
    error: function(err) {
      alert("수정 실패");
      console.log(err);
    }
  }); 
});

// 서버 문자열 파싱 함수
function parseServerData(str) {
  if (!str) return {};
  var jsonStr = str
    .replace(/^OneDayClassVO\s*{/, "{")
    .replace(/([a-zA-Z0-9_]+)=/g, '"$1":')
    .replace(/'/g, '"')
    .replace(/}$/, "}");
  try {
    return JSON.parse(jsonStr);
  } catch (e) {
    console.log("파싱 실패", e);
    return {};
  }
}
</script>

</body>
</html>