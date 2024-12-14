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

    // Edit button click handler
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

    // Delete button click handler
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
        // Here you would typically send an AJAX request to update the project
        // For demonstration, we'll just update the card content
        const projectId = editProjectId.value;
        const card = document.querySelector(`.card[data-project-id="${projectId}"]`);
        card.querySelector('.video-title').textContent = editProjectName.value;
        card.querySelector('.video-description').textContent = editProjectDescription.value;

        hideModal(editModal);
    });

    // Confirm delete handler
    confirmDeleteBtn.addEventListener('click', function() {
        // Here you would typically send an AJAX request to delete the project
        // For demonstration, we'll just remove the card from the DOM
        const card = document.querySelector(`.card[data-project-id="${currentProjectId}"]`);
        card.remove();
        hideModal(deleteModal);
    });

    // Cancel delete handler
    cancelDeleteBtn.addEventListener('click', function() {
        hideModal(deleteModal);
    });

    // Close modal when clicking on the close button or outside the modal
    window.addEventListener('click', function(event) {
        if (event.target.classList.contains('close') || event.target === editModal || event.target === deleteModal) {
            hideModal(editModal);
            hideModal(deleteModal);
        }
    });
});