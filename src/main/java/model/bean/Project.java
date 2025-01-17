package model.bean;

public class Project {
	private int id;
	private int user_id;
	private String name;
	private YoloVersion yolo_version;
	private String description;
	private String originVideoPath;
	private String processedVideoPath;
	private ProjectStatus status;

	
	private double progress;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getOriginVideoPath() {
		return originVideoPath;
	}
	public void setOriginVideoPath(String originVideoPath) {
		this.originVideoPath = originVideoPath;
	}
	public String getProcessedVideoPath() {
		return processedVideoPath;
	}
	public void setProcessedVideoPath(String processedVideoPath) {
		this.processedVideoPath = processedVideoPath;
	}
	public Project(int user_id, String originVideoPath, String processedVideoPath) {
		this.user_id = user_id;
		this.originVideoPath = originVideoPath;
		this.processedVideoPath = processedVideoPath;
	}
	public Project(int user_id, String name, String description, String originVideoPath, String processedVideoPath, double progress, YoloVersion yolo_version, ProjectStatus projectStatus) {
		this.user_id = user_id;
		this.originVideoPath = originVideoPath;
		this.processedVideoPath = processedVideoPath;
		this.progress = progress;
		this.name = name;
		this.description = description;
		this.yolo_version = yolo_version;
		this.status = projectStatus;
	}
	
	public Project(int id, int user_id, String name, String description, String originVideoPath, String processedVideoPath, double progress, YoloVersion yolo_version, ProjectStatus projectStatus) {
		this.id = id;
		this.user_id = user_id;
		this.originVideoPath = originVideoPath;
		this.processedVideoPath = processedVideoPath;
		this.progress = progress;
		this.name = name;
		this.description = description;
		this.yolo_version = yolo_version;
		this.status = projectStatus;
	}
	
	public double getProgress() {
		return progress;
	}
	public void setProgress(double progress) {
		this.progress = progress;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}


    public YoloVersion getYolo_version() {
        return yolo_version;
    }

    public void setYolo_version(YoloVersion yolo_version) {
        this.yolo_version = yolo_version;
    }

	public ProjectStatus getStatus() {
		return status;
	}

	public void setStatus(ProjectStatus status) {
		this.status = status;
	}
}
