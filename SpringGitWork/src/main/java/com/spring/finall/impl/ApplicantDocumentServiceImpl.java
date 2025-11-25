package com.spring.finall.impl;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.finall.exception.applicantDocumentException.ApplicantDocumentException;
import com.spring.finall.service.ApplicantDocumentService;

@Service
public class ApplicantDocumentServiceImpl implements ApplicantDocumentService {

	@Autowired
	private ApplicantDocumentServiceDAO applicantDocumentServiceDAO;

	@Override
	public Map<String, Object> getAppicantDocumentCountByTodayAndWeek(LocalDate startOfWeek, LocalDate endOfWeek) {

		return applicantDocumentServiceDAO.getAppicantDocumentCountByTodayAndWeek(startOfWeek, endOfWeek);
	}

	@Override
	public List<Map<String, Object>> getUnreadDocumentList(String stDate, String edDate) {
		// TODO Auto-generated method stub
		return applicantDocumentServiceDAO.getUnreadDocumentList(stDate,edDate);
	}

	@Override
	public String getFilePathByTeacherId(Long teacherId) {
		// TODO Auto-generated method stub
		return applicantDocumentServiceDAO.getFilePathByTeacherId(teacherId);
	}

	@Override
	@Transactional
	public boolean updateDocumentStatus(Long teacherId, String status) {

		boolean 업데이트성공했니 = false;

		try {
			업데이트성공했니 = applicantDocumentServiceDAO.updateDocumentStatus(teacherId, status);

			if (!업데이트성공했니) {

				ApplicantDocumentException applicantDocumentException = new ApplicantDocumentException("DB상 업데이트 실패",
						4001);
				throw applicantDocumentException;
			}

		} catch (Exception e) {
			ApplicantDocumentException applicantDocumentException = new ApplicantDocumentException(
					"DB접근 코드 혹은 코드 자체의 이상한 에러", 5001);
			throw applicantDocumentException;
		}

		return 업데이트성공했니;
	}

	@Override
	public List<Map<String, Object>> getReadedDocumentList() {
		// TODO Auto-generated method stub
		return applicantDocumentServiceDAO.getReadedDocumentList();
	}

}
