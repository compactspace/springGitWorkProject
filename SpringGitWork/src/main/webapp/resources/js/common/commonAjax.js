/**
 * 글로벌 Ajax 공통 함수
 * options: $.ajax 옵션
 * errorHandlers: {
 *    client: function(res, xhr) {},
 *    server: function(res, xhr) {}
 * }
 */
 
 
 function ajaxRequest(options, errorHandlers = {}) {
  const defaults = {
    type: "GET",
    dataType: "json",
    contentType: "application/json; charset=utf-8",


    error: function (xhr, status, error) {
   //   console.warn("❌ Ajax 오류:", status, error);

      // JSON 안전 파싱
      let res = {};
      try {
        res = xhr.responseJSON || JSON.parse(xhr.responseText);
      } catch (e) {
        res = { code: xhr.status, message: xhr.statusText, data: null };
      }

      // 4xx: 클라이언트 / 비즈니스 오류
      if (xhr.status >= 400 && xhr.status < 500) {
        if (errorHandlers.client) {
          errorHandlers.client(res, xhr);
        } else {
          alert(`클라이언트 오류: ${res.message} (코드: ${res.code})`);
        }
      }
      // 5xx: 서버 내부 오류
      else if (xhr.status >= 500) {
        if (errorHandlers.server) {
          errorHandlers.server(res, xhr);
        } else {
          alert(`서버 오류: ${res.message} (코드: ${res.code})`);
        }
      }
      // 기타
      else {
        alert(`알 수 없는 오류: ${error}`);
      }
    },
    complete: function () {
      console.log("📌 요청 완료");
    },
  };

  // defaults + options 병합
  const settings = $.extend(true, {}, defaults, options);

  return $.ajax(settings);
}

