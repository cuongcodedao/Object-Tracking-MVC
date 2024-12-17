<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.bean.Project" %>
<%@ page import="model.bean.ProjectStatus" %>
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
            position: relative;
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
            display: none;
            margin-top: 10px;
            font-size: 16px;
        }
        .progress-container.active{
            display: block;
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

        .tracking-btn, .cancel-btn {
            border: none;
            border-radius: 20px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            color: #fff;
            font-weight: bold;
            position: absolute;
            right: 20px;
            top: 20px;
        }

        .tracking-btn {
            background-color: #007bff;
        }

        .cancel-btn {
            background-color: #f15a5a;
        }

        .tracking-btn:hover, .cancel-btn:hover {
            opacity: 0.9;
        }
        .logout {
            position: relative;
            padding: 10px 15px;
            color: #535252;
            text-decoration: none;
            font-weight: 500;
            border: thin solid transparent;
            vertical-align: center;
            display: flex;
            align-items: center;
            gap: 5px;
            margin: 0 5px;


        }
        .logout:hover {
            color: #000000;
            border: 2px solid #1a1a1a;
            border-radius: 20px;
            transition: all 0.3s ease-in;
        }

    </style>
</head>
<body onload="onload()">
    <header>
        <div class="header-left">
            <a href="home" class="logo" style="margin-left:15px; text-decoration: none; :hover{color: #7f56f3}"><span style="color: #7f56f3; font-size: 24px; font-weight: 500; text-decoration: none;">O-Tracking</span></a>
        </div>
        <div class="header-right">
            <i class="material-icons">notifications</i>
            <a href="logout" class="logout"><span class="material-icons">logout</span>Log out</a>
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

        	<% Project project = (Project) request.getAttribute("project"); %>
            <div class="caption">
                <a href="home" class="return"><i class="fa fa-chevron-left" aria-hidden="true"></i></a>
                <h1 class="project-heading">Project Detail</h1>
            </div>

            <div class="video-container project-id" id="<%=project.getId() %>">
                <button type="button" class="<%=project.getStatus()==ProjectStatus.TRACKING?"cancel-btn":"tracking-btn" %>" onclick="trackingCancelToggle(this)"><%=project.getStatus()==ProjectStatus.TRACKING?"Cancel":"Track" %></button>
                <h1 class="project-name"><%=project.getName() %></h1>
                <video id="video-player" width="640" height="360" controls>
                    <source id="video-source" src="videos/<%=project.getStatus()==ProjectStatus.FINISHED?project.getProcessedVideoPath():project.getOriginVideoPath() %>" type="video/mp4">
                    Trình duyệt không hỗ trợ xem video.
                </video>
                <div class="progress-container <%=project.getStatus()==ProjectStatus.TRACKING?"active":""%>">
                    <p>Tiến độ xử lý: <span id="progress"><%=project.getProgress()%>%</span></p>
                    <div class="progress-bar">
                        <div class="progress" id="progress-bar" style="width: <%=project.getProgress()+"%"%>"></div>
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
        const progressContainer = document.querySelector(".progress-container");
        var intervalId;
        function trackingCancelToggle(element) {
            const xhr = new XMLHttpRequest();
            const url = element.classList.contains("tracking-btn")
                ? 'project-detail?mod=tracking&id=' + projectId
                : 'project-detail?mod=cancel&id=' + projectId;

            xhr.open("GET", url, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    if (element.classList.contains("tracking-btn")) {
                        element.classList.remove("tracking-btn");
                        progressContainer.classList.add("active");
                        element.classList.add("cancel-btn");
                        element.textContent = "Cancel";
                        clearInterval(intervalId);
                        intervalId = setInterval(fetchProjectStatus, 5000);
                    } else {
                        element.classList.remove("cancel-btn");
                        element.classList.add("tracking-btn");
                        element.textContent = "Track";
                        progressContainer.classList.remove("active");
                        clearInterval(intervalId);
                    }
                }
            };
            xhr.send();
        }



        function fetchProjectStatus() {
            fetch('project-progress?id=' + projectId)
                .then(response => response.json())
                .then(data => {
                    progressElement.textContent = data.progress + '%';
                    progressBar.style.width = data.progress + '%';
                    if (data.processedVideoPath) {
                        videoSourceElement.src = "videos/" + data.processedVideoPath;
                        if (data.progress == 100){
                            videoPlayer.load();
                        }
                    }

                    if (data.progress == 100 && data.status=="FINISHED") {
                        clearInterval(intervalId);
                        window.location.reload();
                    }

                })
                .catch(error => {
                    console.error("Lỗi khi lấy tiến độ:", error);
                    progressElement.textContent = "Lỗi kết nối.";
                });
        }
        function onload() {
            element = document.querySelector(".cancel-btn");
            if(element){
                intervalId = setInterval(fetchProjectStatus, 5000);
            }
        }
    </script>
</body>
</html>
