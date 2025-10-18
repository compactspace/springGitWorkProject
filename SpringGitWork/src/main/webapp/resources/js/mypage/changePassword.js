// changePassword.js

export function initLockPage(lockPage, attemptCnt) {
  console.log("lockPage: " + lockPage + " attemptCnt: " + attemptCnt);

  if (lockPage !== "null" && lockPage === "true" && attemptCnt >= 3) { 	
   
    const container = document.getElementById("lockpage-container");
    container.style.display = "block";
    container.innerText =
      "비밀번호 확인 시도가 3회를 초과했습니다.\n" +
      "잠시 후 다시 시도하시거나, 문제가 지속될 경우 관리자에게 문의해주세요.";
  }
}
export const removeCoolDown = (contextPath,cooldownStartTime,cooldownDuration) => {
  localStorage.removeItem("authToken");
  $.ajax({
    url: `${contextPath}/api/users/remove-smsCoolDown`,
    type: "POST",
    success: function (res) {
      console.log(res);
      if (res.success) {
        cooldownStartTime = null; // 세션에서 전달된 고정 시간 (ms)
        cooldownDuration = null;  // 쿨다운 기간 (ms)
      }
    },
  });
};

export function insertCurrentPasswordForm(containerId, contextPath) {



  const container = document.getElementById(containerId);
  if (!container) return;

  let html = "";
  html += "<h2>기존 비밀번호 확인</h2>";
   html += "<div id='currentPasswordMessageFaile' style='color:red; margin-top:10px;'></div>";
  html += "<div id='currentPasswordMessage' style='color:red; margin-top:10px;'></div>";
  html += "<div id='attemptCountMessage' style='color:gray; margin-top:5px;'></div>";
  html += "<form id='verifyCurrentPasswordForm'>";
  html +=
    "  <input type='password' name='currentPassword' placeholder='현재 비밀번호' required style='margin-bottom: 10px; padding: 8px; width: 100%;' />";
  html +=
    "  <button type='submit' style='padding: 10px; background-color: #6c757d; color: white; border: none; cursor: pointer; width: 100%;'>확인</button>";
  html += "</form>";

  container.innerHTML = html;

  const form = document.getElementById("verifyCurrentPasswordForm");
  form.addEventListener("submit", function (e) {
    e.preventDefault();

    const currentPassword = form.elements["currentPassword"].value;

    if (!currentPassword) {
      document.getElementById("currentPasswordMessage").innerText = "비밀번호를 입력해주세요.";
      return;
    }
    
    $.ajax({
      url: `${contextPath}/api/users/checkpassword`,
      type: "POST",
      data: { currentPassword: currentPassword },
      success: function (res) {
        const messageEl = document.getElementById("currentPasswordMessage");
        const failEL=document.getElementById("currentPasswordMessageFaile");
        const attemptEl = document.getElementById("attemptCountMessage");

        if (res.success) {
          const attemptCnt = res.data.attemptCnt;
          const status = res.data.status;

          if (status) {
            messageEl.style.color = "green";
            messageEl.innerText = "비밀번호 확인 성공!";
            attemptEl.innerText = "";
            // TODO: 다음 단계로 이동 처리
          } else {
            const remaining = 3 - attemptCnt;
            messageEl.style.color = "red";
            failEL.style.color = "red";
            failEL.innerText = "비밀번호가 일치하지 않습니다.";
            
            if (remaining > 0) {
              attemptEl.style.color = "gray";
              attemptEl.innerText = `확인 시도: ${attemptCnt}회 / 최대 3회까지 가능합니다.`;
            } else {
              attemptEl.style.color = "red";
              attemptEl.innerText = "확인 가능 횟수를 초과했습니다. 다시 시도할 수 없습니다.";
              form.querySelector("input[name='currentPassword']").disabled = true;
              form.querySelector("button[type='submit']").disabled = true;
            }
          }
        } else {
          messageEl.style.color = "red";
          messageEl.innerText = "오류가 발생했습니다. 다시 시도해주세요.";
          attemptEl.innerText = "";
        }
      },
      error: function () {
        const messageEl = document.getElementById("currentPasswordMessage");
        messageEl.style.color = "red";
        messageEl.innerText = "오류가 발생했습니다. 다시 시도해주세요.";
        document.getElementById("attemptCountMessage").innerText = "";
      },
    });
  });
}

export function insertPasswordChangeForm(containerId) {
  const container = document.getElementById(containerId);
  if (!container) return;

  let html = "";
  html += "<h2>비밀번호 변경</h2>";
  html += "<div id='verifiedMessage' style='color:red; margin-top:10px;'></div>";
  html += "<form id='passwordChangeForm' action='changePassword.do' method='post'>";
  html +=
    "  <input type='password' name='newPassword' placeholder='새 비밀번호' required style='margin-bottom: 10px; padding: 8px; width: 100%;' />";
  html +=
    "  <input type='password' name='confirmPassword' placeholder='비밀번호 확인' required style='margin-bottom: 10px; padding: 8px; width: 100%;' />";
  html +=
    "  <button type='submit' style='padding: 10px; background-color: #4285F4; color: white; border: none; cursor: pointer; width: 100%;'>변경하기</button>";
  html += "</form>";

  container.innerHTML = html;

  const form = document.getElementById("passwordChangeForm");
  form.addEventListener("submit", function (e) {
    e.preventDefault();

    const newPassword = form.elements["newPassword"].value;
    const confirmPassword = form.elements["confirmPassword"].value;

    if (newPassword !== confirmPassword) {
      document.getElementById("verifiedMessage").textContent = "비밀번호가 일치하지 않습니다.";
      return;
    }

    // TODO: AJAX 요청 등 비밀번호 변경 처리
    console.log("비밀번호 변경 요청:", newPassword);
  });
}

// 모듈 내부
let countdownIntervalId = null;

export function startVerificationCountdown(ttl, startTime) {
  const display = document.getElementById('currentPasswordMessage');
  const expireAt = startTime + (ttl * 1000);

  countdownIntervalId = setInterval(() => {
    const now = new Date().getTime();
    const remaining = Math.ceil((expireAt - now) / 1000);

    if (remaining > 0) {
      display.textContent = "인증번호 유효시간: " + remaining + "초 남음";
    } else {
      display.textContent = '';
      clearInterval(countdownIntervalId);
      countdownIntervalId = null;
      removeCoolDown(); // 세션 제거
    }
  }, 1000);
}

export function stopVerificationCountdown() {
  if (countdownIntervalId) {
    clearInterval(countdownIntervalId);
    countdownIntervalId = null;
    console.log('⏹️ 인증 타이머 중단됨');
  }
}

