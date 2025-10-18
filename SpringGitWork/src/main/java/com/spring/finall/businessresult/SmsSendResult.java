package com.spring.finall.businessresult;

public class SmsSendResult {
	private boolean success;
	private String status; // 예: "FAIL", "TOO_MANY_REQUESTS" 등
	private String token; // 성공 시 토큰
	private long cooldownStartTime;
	private long cooldownDuration;

	private long verifiedTTL;
	private long ttlStartTime;

	private SmsSendResult(boolean success, String status, String token) {
		this.success = success;
		this.status = status;
		this.token = token;

	}

	private SmsSendResult(boolean success, String status, String token, long cooldownStartTime, long cooldownDuration) {
		this.success = success;
		this.status = status;
		this.token = token;
		this.cooldownStartTime = System.currentTimeMillis();
		this.cooldownDuration = 60 * 1000;

	}

	private SmsSendResult(boolean success, String status, long verifiedTTL, long ttlStartTime) {
		this.success = success;
		this.status = status;
		this.verifiedTTL = verifiedTTL;
		this.ttlStartTime = ttlStartTime;
	}

	public static SmsSendResult success(String token, long cooldownStartTime, long cooldownDuration) {
		return new SmsSendResult(true, "SUCCESS", token, cooldownStartTime, cooldownDuration);
	}

	public static SmsSendResult fail() {
		return new SmsSendResult(false, "FAIL", null);
	}

	public static SmsSendResult tooManyRequests() {
		return new SmsSendResult(false, "TOO_MANY_REQUESTS", null);
	}

	public static SmsSendResult tooSoon() {
		return new SmsSendResult(false, "TOO_SOON", null);
	}

	public static SmsSendResult unauthorized() {
		return new SmsSendResult(false, "UNAUTHORIZED", null);
	}

	public static SmsSendResult setVerified(long verifiedTTL, long ttlStartTime) {
		return new SmsSendResult(true, "SUCCESS", verifiedTTL, ttlStartTime);
	}

	public static SmsSendResult expired() {
		return new SmsSendResult(false, "EXPIRED", null);
	}

	public static SmsSendResult invalidTOKEN() {
		return new SmsSendResult(false, "INVALID_TOKEN", null);
	}

	// INVALID_CODE
	public static SmsSendResult invalidCODE() {
		return new SmsSendResult(false, "INVALID_TOKEN", null);
	}

	public boolean isSuccess() {
		return success;
	}

	public String getStatus() {
		return status;
	}

	public String getToken() {
		return token;
	}

	// ✅ 추가된 부분
	public long getCooldownStartTime() {
		return cooldownStartTime;
	}

	public long getCooldownDuration() {
		return cooldownDuration;
	}

	// ✅ 추가된 부분
	public long getVerifiedTTL() {
		return verifiedTTL;
	}

	public void setVerifiedTTL(long verifiedTTL) {
		this.verifiedTTL = verifiedTTL;
	}

	public long getTtlStartTime() {
		return ttlStartTime;
	}

	public void setTtlStartTime(long ttlStartTime) {
		this.ttlStartTime = ttlStartTime;
	}

}
