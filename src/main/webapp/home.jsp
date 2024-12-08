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
    <link rel="stylesheet" href="style_Home.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
        }
        .modal-content {
            background-color: #fff;
            margin: 10% auto;
            padding: 20px;
            border-radius: 8px;
            width: 50%;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .form-group input[type="text"],
        .form-group input[type="file"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-group button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <%
        User user = (User) request.getSession().getAttribute("user");
        if(user==null) response.sendRedirect("login.jsp");
    %>
    <header>
        <div class="header-left">
            <button class="menu-button"><i class="material-icons">menu</i></button>
            <img src="https://www.gstatic.com/youtube/img/creator/yt_studio_logo.png" alt="O-Tracking" class="logo">
        </div>
        <div class="header-right">
            <button class="create-button" id="openModal"><i class="material-icons">video_call</i> CREATE</button>
            <i class="material-icons">help_outline</i>
            <i class="material-icons">notifications</i>
            <div class="user-avatar">A</div>
        </div>
    </header>
    <div class="container">
        <nav class="sidebar">
            <ul>
                <li class="active"><i class="material-icons">dashboard</i> Dashboard</li>
                <li><i class="material-icons">content_copy</i> Content</li>
                <li><i class="material-icons">analytics</i> Analytics</li>
            </ul>
        </nav>
        <main class="content">
            <h1>Overview</h1>
            <div class="dashboard-grid">
                <% List<Project> projects = (List<Project>) request.getAttribute("projects");%>
                <% for(Project project : projects){ %>
                    <div class="card" data-video-id="dQw4w9WgXcQ">
                        <a href="project-detail?id=<%=project.getId()%>">
                            <img src="https://img.youtube.com/vi/dQw4w9WgXcQ/0.jpg" alt="Video Thumbnail" class="thumbnail">
                            <div class="video-content">
                                <h2 class="video-title"><%=project.getName()%></h2>
                                <p class="video-description"><%=project.getDescription()%></p>
                            </div>
                            <div class="video-tracking">
                                <div class="progress-bar">
                                    <div class="progress"></div>
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
                        <option value="2">YOLOv6</option>
                        <option value="3">YOLOv7</option>
                        <option value="4">YOLOv8</option>
                        <option value="5">YOLOv9</option>
                        <option value="6">YOLOv10</option>
                        <option value="7">YOLOv11</option>
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


    <script>
        // JavaScript to handle modal
        const modal1 = document.getElementById("createModal");
        const openModalBtn = document.getElementById("openModal");
        const closeModalBtn = document.getElementById("closeModal");

        openModalBtn.onclick = function() {
            modal1.style.display = "block";
        };

        closeModalBtn.onclick = function() {
            modal1.style.display = "none";
        };

        window.onclick = function(event) {
            if (event.target === modal) {
                modal1.style.display = "none";
            }
        };
    </script>
</body>
</html>
