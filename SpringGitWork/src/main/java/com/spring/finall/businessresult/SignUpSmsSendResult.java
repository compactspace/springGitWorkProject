package com.spring.finall.businessresult;

public class SignUpSmsSendResult {
	
	private boolean success;
	private String status; // 예: "FAIL", "TOO_MANY_REQUESTS" 등
	private String token; // 성공 시 토큰
	private long cooldownStartTime;
	private long cooldownDuration;

	private long verifiedTTL;
	private long ttlStartTime;

	private SignUpSmsSendResult(boolean success, String status, String token) {
		this.success = success;
		this.status = status;
		this.token = token;

	}

	private SignUpSmsSendResult(boolean success, String status, String token, long cooldownStartTime, long cooldownDuration) {
		this.success = success;
		this.status = status;
		this.token = token;
		this.cooldownStartTime = System.currentTimeMillis();
		this.cooldownDuration = 60 * 1000;

	}

	private SignUpSmsSendResult(boolean success, String status, long verifiedTTL, long ttlStartTime) {
		this.success = success;
		this.status = status;
		this.verifiedTTL = verifiedTTL;
		this.ttlStartTime = ttlStartTime;
	}

	public static SignUpSmsSendResult success(String token, long cooldownStartTime, long cooldownDuration) {
		return new SignUpSmsSendResult(true, "SUCCESS", token, cooldownStartTime, cooldownDuration);
	}

	public static SignUpSmsSendResult fail() {
		return new SignUpSmsSendResult(false, "FAIL", null);
	}

	public static SignUpSmsSendResult tooManyRequests() {
		return new SignUpSmsSendResult(false, "TOO_MANY_REQUESTS", null);
	}

	public static SignUpSmsSendResult tooSoon() {
		return new SignUpSmsSendResult(false, "TOO_SOON", null);
	}

	public static SignUpSmsSendResult unauthorized() {
		return new SignUpSmsSendResult(false, "UNAUTHORIZED", null);
	}

	public static SignUpSmsSendResult setVerified(long verifiedTTL, long ttlStartTime) {
		return new SignUpSmsSendResult(true, "SUCCESS", verifiedTTL, ttlStartTime);
	}

	public static SignUpSmsSendResult expired() {
		return new SignUpSmsSendResult(false, "EXPIRED", null);
	}

	public static SignUpSmsSendResult invalidTOKEN() {
		return new SignUpSmsSendResult(false, "INVALID_TOKEN", null);
	}

	// INVALID_CODE
	public static SignUpSmsSendResult invalidCODE() {
		return new SignUpSmsSendResult(false, "INVALID_TOKEN", null);
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
