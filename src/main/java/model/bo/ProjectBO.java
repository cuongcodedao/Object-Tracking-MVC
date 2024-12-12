package model.bo;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

import javax.servlet.http.Part;

import model.bean.Project;
import model.bean.YoloVersion;
import model.dao.ProjectDAO;

public class ProjectBO {
    private static Set<Track> tracks = new HashSet<>();
	private ProjectDAO projectDAO = new ProjectDAO();
	public Project create(String uploadPath, Part part, int user_id, String name, String description, int yolover) {
        File uploadDir = new File(uploadPath);
        String fileName =UUID.randomUUID().toString() + part.getSubmittedFileName();
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        String filePath = uploadPath + File.separator + fileName;
        
        try {
			part.write(filePath);
			String videoOutputPath = uploadPath + File.separator + "output_"+ fileName;
			Project project = new Project(user_id, name, description, filePath, videoOutputPath, 0, selectYolo(yolover));
			int id = projectDAO.createProject(project);
			return projectDAO.getById(id);
		} catch (IOException e) {
			e.printStackTrace();
		}
        return null;
	}
    public void tracking(int project_id){
        Project project = projectDAO.getById(project_id);
        for(Track track: tracks){
            if(track.getProject_id()==project_id){
                if(!track.isAlive()) track.start();
                return;
            }
        }
        Track track = new Track(project.getOriginVideoPath(), project.getProcessedVideoPath(), project_id, project.getYolo_version());
        tracks.add(track);
        track.start();
    }

    public void cancelTracking(int project_id){
        for(Track track: tracks){
            if(track.getProject_id()==project_id){
                if(track.isAlive()) track.interrupt();
                return;
            }
        }
    }

    private YoloVersion selectYolo(int yoloId){
        return switch (yoloId) {
            case 1 -> YoloVersion.YOLOV5;
            case 2 -> YoloVersion.YOLOV6;
            case 3 -> YoloVersion.YOLOV7;
            case 4 -> YoloVersion.YOLOV8;
            case 5 -> YoloVersion.YOLOV9;
            case 6 -> YoloVersion.YOLOV10;
            case 7 -> YoloVersion.YOLOV11;
            default -> null;
        };
    }
	
	public Project getById(int id) {
		return projectDAO.getById(id);
	}
	
	public List<Project> getAllByUserId(int userId){
		return projectDAO.getAllByUserId(userId);
	}


}
class Track extends Thread {
    private String inputPath;
    private String outputPath;
    private int project_id;
    private YoloVersion yolover;

    public int getProject_id(){
        return this.project_id;
    }

    private ProjectDAO projectDAO = new ProjectDAO();
    private static String pythonScriptPath = "C:\\Users\\Dang Van Cuong\\LTM-workspace\\Object_Tracking_MVC\\python.py";
//    private static String pythonScriptPath = "C:\\Users\\USER\\Desktop\\LTM\\python.py";

    public Track(String inputPath, String outputPath, int id, YoloVersion yolover) {
    	this.inputPath = inputPath;
    	this.outputPath = outputPath;
    	this.project_id = id;
        this.yolover = yolover;
    }

    @Override
    public void run() {
        try {
            ProcessBuilder pb = new ProcessBuilder(
                "python",
                    pythonScriptPath,
                    inputPath,
                    outputPath,
                    yolover.getPath()
            );
            pb.redirectErrorStream(true);
            Process process = pb.start();

            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line;

            double lastReportedProgress = 0.0; // Tiến độ lần cuối được cập nhật
            long lastReportedTime = System.currentTimeMillis(); // Thời điểm lần cuối được cập nhật

            while ((line = reader.readLine()) != null) {
                System.out.println(line);

                if (line.startsWith("PROGRESS:")) {
                    String progressStr = line.replace("PROGRESS:", "").trim().replace("%", "");
                    try {
                        double progress = Double.parseDouble(progressStr);

                        long currentTime = System.currentTimeMillis();
                        if ((currentTime - lastReportedTime) >= 7_000 || progress == 100.0) {
                            updateProgress(progress, project_id);
                            lastReportedProgress = progress;
                            lastReportedTime = currentTime;
                        }

                    } catch (NumberFormatException e) {
                        System.err.println("Không thể phân tích tiến độ: " + line);
                    }
                }
            }

            int exitCode = process.waitFor();
            if (exitCode == 0) {
                System.out.println("Xử lý video hoàn tất. Video lưu tại: " + outputPath);
                updateProgress(100.0, project_id); // Tiến độ hoàn tất
            } else {
                System.out.println("Đã xảy ra lỗi trong quá trình xử lý.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    private void updateProgress(double progress, int id) {
    	projectDAO.updateProgress(progress, id);
    }
}