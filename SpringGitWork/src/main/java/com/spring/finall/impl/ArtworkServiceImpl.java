package com.spring.finall.impl;

import java.io.File;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.spring.finall.exception.artworkexception.ArtWorkCompleteException;
import com.spring.finall.exception.artworkexception.ArtWorkDelteFileException;
import com.spring.finall.service.ArtworkService;

@Service("ArtworkService")
public class ArtworkServiceImpl implements ArtworkService {

	@Autowired
	private ArtworkServiceDAO artworkServiceDAO;

	
	
	
	@Override
	public List<Map<String, Object>> findDraftByUserCode(int userCode) {
		// TODO Auto-generated method stub
		return artworkServiceDAO.findDraftByUserCode(userCode);
	}

	@Override
	public int insertDraftArtwork(int user_code) {
		// TODO Auto-generated method stub
		return artworkServiceDAO.getArtWorkId(user_code);
	}

	@Override
	public int currentDraftArtWorkId(int userCode) {
		// TODO Auto-generated method stub
		return artworkServiceDAO.currentDraftArtWorkId(userCode);
	}

	@Override
	public Map<String, Object> artWorkDraftUploadImage(int userCode, MultipartFile file) {

		String finalFileName = helperArtWorkDraftUploadImage(userCode, file);
		String uploadDirName = "/userArtwork/";
		Map<String, Object> executeQueryInfo = new HashMap<>();

		try {
			if (finalFileName != null) {
				int currentDraftArtWorkId = currentDraftArtWorkId(userCode);
				executeQueryInfo = artworkServiceDAO.insertDraftArtworkImage(currentDraftArtWorkId, uploadDirName,
						finalFileName);
			}
		} catch (Exception e) {
			helperArtWorkDraftDeleteImage(finalFileName);
			executeQueryInfo.put("success", false);
		}

		return executeQueryInfo;
	}

	public String helperArtWorkDraftUploadImage(int userCode, MultipartFile file) {

		String originalFilename = null;
		String formattedTime = null;
		long millis = 0L;
		String finalFileName = null;

		try {
			// 🔹 저장 경로
			String uploadDir = "C:/userArtwork/";
			File dir = new File(uploadDir);
			if (!dir.exists()) {
				dir.mkdirs();
			}

			// 🔹 원본 파일명
			originalFilename = file.getOriginalFilename();
			if (originalFilename == null || originalFilename.trim().isEmpty()) {
				originalFilename = "unnamed";
			}
			originalFilename = originalFilename.replaceAll("\\s+", "_");

			// 🔹 시간 관련 정보
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmss");
			formattedTime = sdf.format(new Date());
			millis = System.currentTimeMillis();

			// 🔹 최종 파일명 조합
			finalFileName = String.format("%d_%s_%d_%s", userCode, formattedTime, millis, originalFilename);

			// 🔹 파일 저장
			File savedFile = new File(uploadDir + finalFileName);
			file.transferTo(savedFile);

			return finalFileName;

		} catch (Exception e) {
			e.printStackTrace();

			return null;
		}

	}

	@Override
	public Map<String, Object> deleteArtWorkDraftImage(int userCode, String fordName, String fileName)
			throws ArtWorkDelteFileException {

		Map<String, Object> executeQueryInfo = new HashMap<>();
		executeQueryInfo.put("delte-status", false);
		try {

			Map<String, Object> fileDelteInfo = helperArtWorkDraftDeleteImage(fileName);

			boolean fileDelStatus = (boolean) fileDelteInfo.get("delte-status");

			if (!fileDelStatus) {
				return executeQueryInfo;
			}

			int currentDraftArtWorkId = artworkServiceDAO.currentDraftArtWorkId(userCode);

			int affectedRow = artworkServiceDAO.deleteArtWorkDraftImage(currentDraftArtWorkId, fordName, fileName);

			if (affectedRow <= 0) {

				executeQueryInfo.put("faile-reason", "파일은 삭제되었으나 DB delete문 반영실패");
			} else {
				executeQueryInfo.put("delte-status", true);
			}

		} catch (ArtWorkDelteFileException artWorkDelteFileException) {
			executeQueryInfo.put("status-error", "파일 삭제 실패");

		} catch (Exception e) {
			executeQueryInfo.put("status-error", "파일은 삭제 했으나 DB의 정보 delte문은 실패");

		}

		return executeQueryInfo;
	}

	public Map<String, Object> helperArtWorkDraftDeleteImage(String fileName) {
		// 🔹 저장 경로
		String uploadDir = "C:/userArtwork/";
		File file = new File(uploadDir + fileName);
		Map<String, Object> fileDelteInfo = new HashMap<>();
		fileDelteInfo.put("delte-status", false);
		try {
			if (file.exists()) {
				boolean deleted = file.delete();
				if (deleted) {
					fileDelteInfo.put("delte-status", true);
					return fileDelteInfo;
				} else {

					fileDelteInfo.put("faile-reason", "알수없는 사유");
					return fileDelteInfo;
				}
			} else {
				fileDelteInfo.put("faile-reason", "해당 파일을 찾을 수 없습니다.");
				return fileDelteInfo;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ArtWorkDelteFileException("파일삭제 실패");

		}
	}

	@Override
	@Transactional
	public Map<String, Object> completeDraftArtWork(String content, int userCode) {

		Map<String, Object> map = new HashMap<>();
		map.put("completeDraftArtWork-status", false);
	

		//SQLException
		//SQLSyntaxErrorException
		
		
		try {
			int currentDraftArtWorkId = artworkServiceDAO.currentDraftArtWorkId(userCode);
			if (currentDraftArtWorkId == 0) {
				map.put("faile-reason", "본인 소유권이 아닌 초안을 완성하려함");
				throw new ArtWorkCompleteException("본인 소유권이 아닌 초안을 완성하려함", 500);
			}

			int affectedRow = artworkServiceDAO.updateArtWorkStatus(content, userCode,currentDraftArtWorkId);
			if (affectedRow == 0) {
				map.put("faile-reason", "DB is_draft 컬럼 업데이트문 실패");
				throw new ArtWorkCompleteException("DB is_draft 컬럼 업데이트문 실패", 500);
			}
		}catch(Exception sqlException) {
			
			System.out.println(sqlException);
			map.put("faile-reason", "DB 쿼리문 자체의 문제");
			throw new ArtWorkCompleteException("DB is_draft 컬럼 업데이트문 실패", 500);
		}
		
		
		
		
		map.put("completeDraftArtWork-status", true);

		return map;
	}

	@Override
	public Map<String, Object> getArtWorkList(int offset) {
		
		return artworkServiceDAO.getArtWorkList(offset);
	}

	@Override
	public Map<String, Object> getArtWorkDetail(int artWorkId) {
		// TODO Auto-generated method stub
		return  artworkServiceDAO.getArtWorkDetail(artWorkId);
	}

}
