<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.bean.Project" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - Video Playback</title>
    <link rel="stylesheet" href="style_Home.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        /* Styling for video section */
        .video-container {
            margin: 20px auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .video-container h1 {
            margin-bottom: 10px;
        }

        #video-player {
            display: block;
            margin: 20px auto;
            max-width: 100%;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .progress-container {
            margin-top: 10px;
            font-size: 16px;
        }

        .progress-bar {
            width: 100%;
            background-color: #e0e0e0;
            border-radius: 4px;
            overflow: hidden;
            margin-top: 5px;
        }

        .progress-bar .progress {
            width: 0%;
            height: 10px;
            background-color: #007bff;
            transition: width 0.5s ease-in-out;
        }

        .action-links {
            margin-top: 15px;
        }

        .action-links a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }

        .action-links a:hover {
            text-decoration: underline;
        }
        .return {
            font-size: 30px;
            color: #1a1a1a;
        }
        .caption {
            display: flex;
            justify-content: flex-start;
            gap: 30px;
            align-items: center;
        }
        .project-heading {
            margin: 20px;
            font-size: 24px;
        }
        .return:hover {
            color: #1a1a1a;
            vertical-align: center;
        }
    </style>
</head>
<body>
    <header>
        <div class="header-left">
            <button class="menu-button"><i class="material-icons">menu</i></button>
            <span style="color: #7f56f3; font-size: 24px; font-weight: 500;">O-Tracking</span>
        </div>
        <div class="header-right">
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

        	<% Project project = (Project) request.getAttribute("project"); %>
            <div class="caption">
                <a href="home" class="return"><i class="fa fa-chevron-left" aria-hidden="true"></i></a>
                <h1 class="project-heading">Project Detail</h1>
            </div>
            <div class="video-container project-id" id="<%=project.getId() %>">
                <h1 class="project-name"><%=project.getName() %></h1>
                <video id="video-player" width="640" height="360" controls>
                    <source id="video-source" src="" type="video/mp4">
                    Trình duyệt không hỗ trợ xem video.
                </video>
                <div class="progress-container">
                    <p>Tiến độ xử lý: <span id="progress">Đang chờ...</span></p>
                    <div class="progress-bar">
                        <div class="progress" id="progress-bar"></div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        const urlParams = new URLSearchParams(window.location.search);
        const projectId = document.querySelector(".project-id").id;
        const progressElement = document.getElementById("progress");
        const progressBar = document.getElementById("progress-bar");
        const videoSourceElement = document.getElementById("video-source");
        const videoPlayer = document.getElementById("video-player");
        const nameProject = document.querySelector(".project-name");

        function fetchProjectStatus() {
            fetch('project-progress?id=' + projectId)
                .then(response => response.json())
                .then(data => {
                    // Update progress
                    progressElement.textContent = data.progress + '%';
                    progressBar.style.width = data.progress + '%';
                    // Update video source if processing is done
                    if (data.processedVideoPath && videoSourceElement.src !== "videos/" + data.processedVideoPath) {
                        videoSourceElement.src = "videos/" + data.processedVideoPath;
                        if (data.progress == 100) videoPlayer.load();
                    }

                    // Stop polling when progress reaches 100%
                    if (data.progress == 100) {
                        clearInterval(intervalId);
                    }
                })
                .catch(error => {
                    console.error("Lỗi khi lấy tiến độ:", error);
                    progressElement.textContent = "Lỗi kết nối.";
                });
        }
        fetchProjectStatus();
        const intervalId = setInterval(fetchProjectStatus, 5000);
    </script>
</body>
</html>
