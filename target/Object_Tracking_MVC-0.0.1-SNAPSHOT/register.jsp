<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign up</title>
    <link rel="stylesheet" href="style_Login.css">
</head>
<body>
<main>
    <div class="login-card">
        <div class="login-icon">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                <path d="M15 3H7C5.89543 3 5 3.89543 5 5V19C5 20.1046 5.89543 21 7 21H15C16.1046 21 17 20.1046 17 19V5C17 3.89543 16.1046 3 15 3Z" stroke="currentColor" stroke-width="2"/>
                <path d="M11 8L13 10L11 12" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
            </svg>
        </div>
        <h1>Sign up with email</h1>
        <p class="subtitle">Make a new doc to bring your words, data,<br>and teams together. For free</p>

        <form class="login-form" action="register" method="post" onsubmit="return validatePasswords();">
            <div class="form-group">
                <input type="text" id="username" name="username" placeholder="Username" required>
            </div>
            <div class="form-group">
                <div class="password-input">
                    <input type="password" id="password" name="password" placeholder="Password" required>
                    <button type="button" class="toggle-password" onclick="togglePasswordVisibility('password')">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                            <path d="M12 5C5.63636 5 2 12 2 12C2 12 5.63636 19 12 19C18.3636 19 22 12 22 12C22 12 18.3636 5 12 5Z" stroke-width="1.5"/>
                            <path d="M12 15C13.6569 15 15 13.6569 15 12C15 10.3431 13.6569 9 12 9C10.3431 9 9 10.3431 9 12C9 13.6569 10.3431 15 12 15Z" stroke-width="1.5"/>
                        </svg>
                    </button>
                </div>
            </div>
            <div class="form-group">
                <div class="password-input">
                    <input type="password" id="retype-password" name="retype-password" placeholder="Retype Password" required>
                    <button type="button" class="toggle-password" onclick="togglePasswordVisibility('retype-password')">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                            <path d="M12 5C5.63636 5 2 12 2 12C2 12 5.63636 19 12 19C18.3636 19 22 12 22 12C22 12 18.3636 5 12 5Z" stroke-width="1.5"/>
                            <path d="M12 15C13.6569 15 15 13.6569 15 12C15 10.3431 13.6569 9 12 9C10.3431 9 9 10.3431 9 12C9 13.6569 10.3431 15 12 15Z" stroke-width="1.5"/>
                        </svg>
                    </button>
                </div>
            </div>
            <button type="submit" class="login-button">Sign up</button>
        </form>
    </div>
</main>

<script>
    const urlParams = new URLSearchParams(window.location.search);
    const error = urlParams.get("error");
    if(error){
        alert(error);
    }

    function togglePasswordVisibility(fieldId) {
        const field = document.getElementById(fieldId);
        field.type = field.type === "password" ? "text" : "password";
    }

    function validatePasswords() {
        const password = document.getElementById("password").value;
        const retypePassword = document.getElementById("retype-password").value;

        if (password !== retypePassword) {
            alert("Passwords do not match. Please try again.");
            return false;
        }
        return true;
    }

</script>
</body>
</html>
