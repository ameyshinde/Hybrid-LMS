package com.bean;

import java.sql.Date;
import java.time.LocalDate;

public class Notes {
	private int notesid;
	private String subjectcode;
	private String subject;
	private String filename;
	private String filetype;
	private Date Upload_date;
	private byte[] notes;

	public  java.sql.Date getCurrentDate() {
		java.util.Date today = new java.util.Date();
		return new java.sql.Date(today.getTime());
	}

	public int getNotesid() {
		return notesid;
	}

	public void setNotesid(int notesid) {
		this.notesid = notesid;
	}

	public String getSubjectcode() {
		return subjectcode;
	}

	public void setSubjectcode(String subjectcode) {
		this.subjectcode = subjectcode;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getFiletype() {
		return filetype;
	}

	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}

	public byte[] getNotes() {
		return notes;
	}

	public void setNotes(byte[] notes) {
		this.notes = notes;
	}

	public Notes(int notesid, String subjectcode, String subject,String filename, String filetype, byte[] notes) {
		super();
		this.notesid = notesid;
		this.subjectcode = subjectcode;
		this.subject = subject;
		this.filename = filename;
		this.filetype = filetype;
		this.notes = notes;
	}

}
