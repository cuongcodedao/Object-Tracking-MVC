document.addEventListener('DOMContentLoaded', function() {
    const editModal = document.getElementById('editModal');
    const deleteModal = document.getElementById('deleteModal');
    const createModal = document.getElementById('createModal');
    const editForm = document.getElementById('editForm');
    const editProjectId = document.getElementById('editProjectId');
    const editProjectName = document.getElementById('editProjectName');
    const editProjectDescription = document.getElementById('editProjectDescription');
    const confirmDeleteBtn = document.getElementById('confirmDelete');
    const cancelDeleteBtn = document.getElementById('cancelDelete');

    let currentProjectId = null;

    function showModal(modal) {
        modal.style.display = 'block';
        setTimeout(() => modal.classList.add('show'), 10);
    }

    function hideModal(modal) {
        modal.classList.remove('show');
        setTimeout(() => modal.style.display = 'none', 300);
    }

    document.querySelectorAll('.edit-btn').forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            const card = this.closest('.card');
            const projectId = card.querySelector("input[type='hidden']").value;
            const projectName = card.querySelector('.video-title').textContent;
            const projectDescription = card.querySelector('.video-description').textContent;

            editProjectId.value = projectId;
            editProjectName.value = projectName;
            editProjectDescription.value = projectDescription;
            editProjectName.setAttribute('required', 'required');
            editForm.action = "project?mod=edit&id=" + projectId;


            showModal(editModal);
        });
    });

    document.querySelectorAll('.delete-btn').forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            const card = this.closest('.card');
            currentProjectId = card.querySelector("input[type='hidden']").value;
            showModal(deleteModal);
        });
    });





    confirmDeleteBtn.addEventListener('click', function() {
        fetch("project?mod=delete&id=" + currentProjectId, {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
            },
            body: "id=" + currentProjectId,
        })
            .then(response => {

                if (!response.ok) {
                    throw new Error(`Server returned error: ${response.status}`);
                }


                window.location.reload();
            })
            .catch(error => console.error("Error:", error));


    });

    cancelDeleteBtn.addEventListener('click', function() {
        hideModal(deleteModal);
    });

    window.addEventListener('click', function(event) {
        if (event.target.classList.contains('close') || event.target === editModal || event.target === deleteModal) {
            hideModal(editModal);
            hideModal(deleteModal);
            hideModal(createModal);
        }
    });
});







const modal = document.getElementById("videoModal");
const span = document.getElementsByClassName("close")[0];
const cards = document.getElementsByClassName("card");
const iframe = document.getElementById("videoIframe");

for (let card of cards) {
    card.addEventListener('click', function(event) {
        if (!event.target.classList.contains('start-tracking')) {
            const videoId = this.getAttribute("data-video-id");
            iframe.src = "https://www.youtube.com/embed/" + videoId;
            modal.style.display = "block";
        }
    });
}
span.onclick = function() {
    modal.style.display = "none";
    iframe.src = "";
}
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
        iframe.src = "";
    }
}
const startButtons = document.getElementsByClassName("start-tracking");
function simulateTracking(button, progressBar) {
    let progress = 0;
    button.disabled = true;
    button.textContent = 'Tracking...';

    const interval = setInterval(function() {
        progress += 1;
        progressBar.style.width = progress + '%';
        if (progress >= 100) {
            clearInterval(interval);
            button.textContent = 'Tracking Complete';
            button.disabled = false;
        }
    }, 50);
}


for (let button of startButtons) {
    button.addEventListener('click', function() {
        const card = this.closest('.card');
        const progressBar = card.querySelector('.progress');
        simulateTracking(this, progressBar);
    });
}
