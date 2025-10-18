package com.spring.finall.reqDto.wrapperRequest;



import com.spring.finall.reqDto.workImageRequest.WorkImageDTO;
import com.spring.finall.reqDto.workRequest.WorkDTO;

public class WorkAndWorkImageRequestDTO {
    private WorkDTO work;
    private WorkImageDTO workImage;

    public WorkAndWorkImageRequestDTO() {}

    public WorkAndWorkImageRequestDTO(WorkDTO work, WorkImageDTO workImage) {
        this.work = work;
        this.workImage = workImage;
    }

    public WorkDTO getWork() {
        return work;
    }

    public void setWork(WorkDTO work) {
        this.work = work;
    }

    public WorkImageDTO getWorkImage() {
        return workImage;
    }

    public void setWorkImage(WorkImageDTO workImage) {
        this.workImage = workImage;
    }
}


