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
        .logout {
            position: relative;
            padding: 10px 15px;
            color: #606060;
            text-decoration: none;
            font-weight: 500;
        }
        .logout:hover {
            color: #065fd4;
            transition: all 0.3s ease-in;
        }
        .card-link {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: flex-start;
            text-decoration: none;
        }
        .video-content {
            align-self: flex-start;
        }
        .card {
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
            overflow: hidden;
            transition: all 0.3s cubic-bezier(.25,.8,.25,1);
        }

        .card:hover {
            box-shadow: 0 10px 18px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
            scale: 1.01;
        }
        .card h2 {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 16px;
            text-decoration: none;
            text-transform: capitalize;
            color: #1a1a1a;
        }
        .card p {
            font-size: 14px;
            color: #606060;
            margin-bottom: 8px;
            text-decoration: none;
        }
        .card h3 {
            font-size: 24px;
            font-weight: 400;
            margin-bottom: 16px;
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
            <span style="color: #7f56f3; font-size: 24px; font-weight: 500;">O-Tracking</span>
        </div>
        <div class="header-right">
            <button class="create-button" id="openModal"><i class="material-icons">video_call</i> CREATE</button>
            <i class="material-icons">notifications</i>
            <a href="#" class="logout">Log out</a>
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
                                <button type="button" class="delete-btn"><i class="fa fa-trash" aria-hidden="true"></i></button>
<%--                                <button type="button" ><i class="fa fa-trash" aria-hidden="true"></i></button>--%>

                                <button id = "editBtn" class = "edit-btn" type="button" ><svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
                                    <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325"/>
                                </svg></button>
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
