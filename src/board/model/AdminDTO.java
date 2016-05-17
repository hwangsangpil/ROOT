package board.model;

import java.io.BufferedInputStream;


import java.io.FileInputStream;
import java.io.IOException;

import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;

public class AdminDTO {
	int seqNo;
	String adminId, adminPw, adminName, adminEmail, adminPhone, crtDate, udtDate, adminBranch, adminRole;
	StoreDTO storeDto;
	
	

	public AdminDTO(){
		storeDto = new StoreDTO();
	}
	
	public String getAdminBranch() {
		return adminBranch;
	}

	public void setAdminBranch(String adminBranch) {
		this.adminBranch = adminBranch;
	}

	public StoreDTO getStoreDto() {
		return storeDto;
	}

	public void setStoreDto(StoreDTO storeDto) {
		this.storeDto = storeDto;
	}

	public int getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(int seqNo) {
		this.seqNo = seqNo;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminPw() {
		return adminPw;
	}
	public void setAdminPw(String adminPw) {
		this.adminPw = adminPw;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getAdminEmail() {
		return adminEmail;
	}
	public void setAdminEmail(String adminEmail) {
		this.adminEmail = adminEmail;
	}
	public String getAdminPhone() {
		return adminPhone;
	}
	public void setAdminPhone(String adminPhone) {
		this.adminPhone = adminPhone;
	}
	public String getAdminRole() {
		return adminRole;
	}
	public void setAdminRole(String adminRole) {
		this.adminRole = adminRole;
	}
	public String getCrtDate() {
		return crtDate;
	}
	public void setCrtDate(String crtDate) {
		this.crtDate = crtDate;
	}
	public String getUdtDate() {
		return udtDate;
	}
	public void setUdtDate(String udtDate) {
		this.udtDate = udtDate;
	}
}
