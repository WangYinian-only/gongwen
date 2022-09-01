package entity;

public class Doc {
	private int id;
	private String tipplace;
	private String ftipplace;
	private int deletestatus;
	private int callback;
	public int getCallback() {
		return callback;
	}
	public void setCallback(int callback) {
		this.callback = callback;
	}
	public int getDeletestatus() {
		return deletestatus;
	}
	public void setDeletestatus(int deletestatus) {
		this.deletestatus = deletestatus;
	}
	public String getFtipplace() {
		return ftipplace;
	}
	public void setFtipplace(String ftipplace) {
		this.ftipplace = ftipplace;
	}
	public String getTipplace() {
		return tipplace;
	}
	public void setTipplace(String tipplace) {
		this.tipplace = tipplace;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	private String title;
	private String owner;
	private String time;
	private String receiver;
	private int status;
	private int result;
	private String place;
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}

}
