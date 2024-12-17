<%@ page import="model.bean.User" %>
<%@ page import="model.bean.Project" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Object Tracking</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style_Home.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <%
        User user = (User) request.getSession().getAttribute("user");
        if(user==null) response.sendRedirect("login.jsp");
    %>
    <header>
        <div class="header-left">
            <button class="menu-button"><i class="material-icons">menu</i></button>
            <span style="color: #7f56f3; font-size: 24px; font-weight: 500;">O-Tracking</span>
        </div>
        <div class="header-right">
            <button class="create-button" id="openModal"><i class="material-icons">video_call</i> CREATE</button>
            <i class="material-icons">notifications</i>
            <a href="#" class="logout"><span class="material-icons">logout</span>Log out</a>
            <div class="user-avatar">A</div>

        </div>
    </header>
    <div class="container">
        <nav class="sidebar">
            <ul>
                <li class="active"><i class="material-icons">dashboard</i> Dashboard</li>
            </ul>
        </nav>
        <main class="content">
            <h1>Overview</h1>
            <div class="dashboard-grid">
                <% List<Project> projects = (List<Project>) request.getAttribute("projects");%>
                <% for(Project project : projects){ %>
                    <div class="card" data-video-id="dQw4w9WgXcQ">
                        <a href="project-detail?id=<%=project.getId()%>" class="card-link">
                            <img src="https://img.youtube.com/vi/Yla5i5tzXKE/0.jpg" alt="Video Thumbnail" class="thumbnail">
                            <input type="hidden" id = "data-project-id" value="<%=project.getId()%>" >
                            <div class="video-content">
                                <h2 class="video-title"><%=project.getName()%></h2>
                                <p class="video-description"><%=project.getDescription()%></p>
                            </div>
                            <div class="video-tracking">
                                <div class="progress-bar">
                                    <div class="progress"></div>
                                </div>
                            </div>
                            <div class="action">
                                <div class="button delete-btn" id="deleteBtn" >
                                    <div class="button-wrapper">
                                        <div class="text">Delete</div>
                                        <span class="icon">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"><path fill="#ffffff" d="M135.2 17.7L128 32 32 32C14.3 32 0 46.3 0 64S14.3 96 32 96l384 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-96 0-7.2-14.3C307.4 6.8 296.3 0 284.2 0L163.8 0c-12.1 0-23.2 6.8-28.6 17.7zM416 128L32 128 53.2 467c1.6 25.3 22.6 45 47.9 45l245.8 0c25.3 0 46.3-19.7 47.9-45L416 128z"/></svg>
                                        </span>
                                    </div>
                                </div>

                                <div class="button edit-btn" id="editBtn" >
                                    <div class="button-wrapper">
                                        <div class="text">Edit</div>
                                        <span class="icon">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="#ffffff" d="M362.7 19.3L314.3 67.7 444.3 197.7l48.4-48.4c25-25 25-65.5 0-90.5L453.3 19.3c-25-25-65.5-25-90.5 0zm-71 71L58.6 323.5c-10.4 10.4-18 23.3-22.2 37.4L1 481.2C-1.5 489.7 .8 498.8 7 505s15.3 8.5 23.7 6.1l120.3-35.4c14.1-4.2 27-11.8 37.4-22.2L421.7 220.3 291.7 90.3z"/></svg>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                <%}%>

        </main>
    </div>
    
    <!-- Modal -->
    <div id="createModal" class="modal">
        <div class="modal-content">
            <span class="close" id="closeModal">&times;</span>
            <h2>Create New Project</h2>
            <form action="project?mod=create&user-id=<%= user.getId()%>" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="name">Project Name:</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="file">Upload Video:</label>
                    <input type="file" id="file" name="file" accept="video/*" required>
                </div>
                <div class="form-group">
                    <label for="yoloVersion">Select YOLO Model:</label>
                    <select id="yoloVersion" name="yoloVersion" required>
                        <option value="1">YOLOv5</option>
<%--                        <option value="2">YOLOv6</option>--%>
<%--                        <option value="3">YOLOv7</option>--%>
                        <option value="4">YOLOv8</option>
<%--                        <option value="5">YOLOv9</option>--%>
                        <option value="6">YOLOv10</option>
<%--                        <option value="7">YOLOv11</option>--%>
                    </select>
                </div>
                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" rows="10" cols="100"></textarea>
                </div>
                <div class="form-group">
                    <button type="submit">Submit</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Edit Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>Edit Project</h2>
            <form id="editForm" action="project?id=" method="post">
                <input type="hidden" id="editProjectId" name = "id">
                <div class="form-group">
                    <label for="editProjectName">Project Name</label>
                    <input type="text" id="editProjectName" name="name" required>
                </div>
                <div class="form-group">
                    <label for="editProjectDescription">Project Description</label>
                    <textarea id="editProjectDescription" name="description" required></textarea>
                </div>
                <button type="button" id = "saveBtn" class="btn btn-primary">Save Changes</button>
            </form>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>Confirm Deletion</h2>
            <p>Are you sure you want to delete this project?</p>
            <button id="confirmDelete" class="btn btn-danger">Delete</button>
            <button id="cancelDelete" class="btn">Cancel</button>
        </div>
    </div>

    <script>
        // JavaScript to handle modal
        const modal1 = document.getElementById("createModal");
        const openModalBtn = document.getElementById("openModal");
        const closeModalBtn = document.getElementById("closeModal");
        const editModal = document.getElementById("editModal");
        const editBtn = document.getElementById("editBtn");

        openModalBtn.onclick = function() {
            modal1.style.display = "block";
            modal1.classList.toggle("show")
        };

        closeModalBtn.onclick = function() {
            modal1.classList.remove('show');
            setTimeout(() => modal1.style.display = 'none', 300);

        };

        window.onclick = function(event) {
            if (event.target === modal1) {
                modal1.style.display = "none";
            }
        };

        document.getElementById("saveBtn").onclick = function() {
            if(document.getElementById("editProjectName").value === "" ){
                alert("Project name cannot be empty");
                return;
            }
            document.getElementById("editForm").submit();
        };


    </script>
<script src="home.js"></script>
</body>
</html>
