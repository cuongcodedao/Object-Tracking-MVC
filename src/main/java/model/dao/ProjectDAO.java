package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.bean.Project;
import model.bean.ProjectStatus;
import model.bean.YoloVersion;

public class ProjectDAO {
	static final String DB_URL = "jdbc:mysql://localhost/objecttracking";
	static final String USER = "root";
	static final String PASS = "123456";
//	static final String PASS = "Nmdung04@";
	private Connection conn;

	public ProjectDAO() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public int createProject(Project project){
		PreparedStatement st = null;
		String sql = "insert into project(user_id, input_path, output_path, progress, name, description, yolo_version, status) values(?, ?, ?, 0, ?, ?, ?, ?)";
		if(conn!=null) {
			try {
				st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				st.setInt(1, project.getUser_id());
				st.setString(2, project.getOriginVideoPath());
				st.setString(3, project.getProcessedVideoPath());
				st.setString(4, project.getName());
				st.setString(5, project.getDescription());
				st.setString(6, project.getYolo_version().name());
				st.setString(7, project.getStatus().name());
				st.executeUpdate();
				ResultSet rs = st.getGeneratedKeys();
				while(rs.next()) {
					return (int) rs.getInt(1);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return 0;
	}
	public void updateProgress(double progress, int id) {
		PreparedStatement st = null;
		String sql = "update project set progress = ? where id = ?";
		if(conn!=null) {
			try {
				st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				st.setDouble(1, progress);
				st.setInt(2, id);
				st.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}
	public boolean updateProject(Project project) {
		PreparedStatement st = null;
		String sql = "UPDATE project SET user_id = ?, input_path = ?, output_path = ?, name = ?, description = ?, yolo_version = ?, status = ?, progress = ? WHERE id = ?";
		boolean updated = false;

		if (conn != null) {
			try {
				st = conn.prepareStatement(sql);
				st.setInt(1, project.getUser_id());
				st.setString(2, project.getOriginVideoPath());
				st.setString(3, project.getProcessedVideoPath());
				st.setString(4, project.getName());
				st.setString(5, project.getDescription());
				st.setString(6, project.getYolo_version().name());
				st.setString(7, project.getStatus().name());
				st.setDouble(8, project.getProgress());
				st.setInt(9, project.getId());

				int rowsAffected = st.executeUpdate();
				updated = rowsAffected > 0;

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					if (st != null) st.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return updated;
	}
	public boolean deleteProject(int id) {
		PreparedStatement st = null;
		String sql = "DELETE FROM project WHERE id = ?";
		boolean deleted = false;

		if (conn != null) {
			try {
				st = conn.prepareStatement(sql);
				st.setInt(1, id);

				int rowsAffected = st.executeUpdate();
				deleted = rowsAffected > 0;

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					if (st != null) st.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return deleted;
	}



	public void updateStatus(ProjectStatus status, int id) {
		PreparedStatement st = null;
		String sql = "update project set status = ? where id = ?";
		if(conn!=null) {
			try {
				st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				st.setString(1, status.name());
				st.setInt(2, id);
				st.executeUpdate();

			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

	public Project getById(int id) {
	    PreparedStatement st = null;
	    ResultSet rs = null;
	    String sql = "SELECT * FROM project WHERE id = ?";
	    Project project = null;
	    
	    if (conn != null) {
	        try {
	            st = conn.prepareStatement(sql);
	            st.setInt(1, id);
	            rs = st.executeQuery();
	            
	            if (rs.next()) {
	                int userId = rs.getInt("user_id");
	                String name = rs.getString("name");
	                String description = rs.getString("description");
	                String originVideoPath = rs.getString("input_path");
	                String processedVideoPath = rs.getString("output_path");
	                double progress = rs.getDouble("progress");
					YoloVersion yoloVersion = YoloVersion.valueOf(rs.getString("yolo_version"));
					ProjectStatus status = ProjectStatus.valueOf(rs.getString("status"));

	                project = new Project(userId, name ,description, originVideoPath, processedVideoPath, progress, yoloVersion, status);
	                project.setId(id);
	                
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            try {
	                if (rs != null) rs.close();
	                if (st != null) st.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	    
	    return project;
	}
	
	public List<Project> getAllByUserId(int userId) {
	    PreparedStatement st = null;
	    ResultSet rs = null;
	    String sql = "SELECT * FROM project WHERE user_id = ?";
	    List<Project> projects = new ArrayList<Project>();
	    
	    if (conn != null) {
	        try {
	            st = conn.prepareStatement(sql);
	            st.setInt(1, userId);
	            rs = st.executeQuery();
	            
	            while (rs.next()) {
	            	int id = rs.getInt("id");
	                int user_Id = rs.getInt("user_id");
	                String name = rs.getString("name");
	                String description = rs.getString("description");
	                String originVideoPath = rs.getString("input_path");
	                String processedVideoPath = rs.getString("output_path");
	                double progress = rs.getDouble("progress");
					YoloVersion yoloVersion = YoloVersion.valueOf(rs.getString("yolo_version"));
					ProjectStatus status = ProjectStatus.valueOf(rs.getString("status"));

					Project project = new Project(id, user_Id, name ,description, originVideoPath, processedVideoPath, progress, yoloVersion, status);
	                projects.add(project);
	                
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            try {
	                if (rs != null) rs.close();
	                if (st != null) st.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	    
	    return projects;
	}
}
