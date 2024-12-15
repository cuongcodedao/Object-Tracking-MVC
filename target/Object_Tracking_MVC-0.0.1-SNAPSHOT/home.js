document.addEventListener('DOMContentLoaded', function() {
    const editModal = document.getElementById('editModal');
    const deleteModal = document.getElementById('deleteModal');
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
            const projectId = card.getAttribute('data-project-id');
            const projectName = card.querySelector('.video-title').textContent;
            const projectDescription = card.querySelector('.video-description').textContent;

            editProjectId.value = projectId;
            editProjectName.value = projectName;
            editProjectDescription.value = projectDescription;

            showModal(editModal);
        });
    });

    document.querySelectorAll('.delete-btn').forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            currentProjectId = this.closest('.card').getAttribute('data-project-id');
            showModal(deleteModal);
        });
    });

    // Edit form submit handler
    editForm.addEventListener('submit', function(e) {
        e.preventDefault();
        const projectId = editProjectId.value;
        const card = document.querySelector(`.card[data-project-id="${projectId}"]`);
        card.querySelector('.video-title').textContent = editProjectName.value;
        card.querySelector('.video-description').textContent = editProjectDescription.value;

        hideModal(editModal);
    });


    confirmDeleteBtn.addEventListener('click', function() {
        const card = document.querySelector(`.card[data-project-id="${currentProjectId}"]`);
        card.remove();
        hideModal(deleteModal);
    });

    cancelDeleteBtn.addEventListener('click', function() {
        hideModal(deleteModal);
    });

    window.addEventListener('click', function(event) {
        if (event.target.classList.contains('close') || event.target === editModal || event.target === deleteModal) {
            hideModal(editModal);
            hideModal(deleteModal);
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
