<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Inter', 'Segoe UI', system-ui, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        overflow: hidden;
        position: relative;
    }

    /* Animated background particles */
    .bg-animation {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        z-index: 0;
        pointer-events: none;
    }

    .particle {
        position: absolute;
        width: 4px;
        height: 4px;
        background: rgba(255, 255, 255, 0.3);
        border-radius: 50%;
        animation: float 15s infinite ease-in-out;
    }

    @keyframes float {
        0%, 100% { transform: translateY(0) translateX(0); opacity: 0; }
        10% { opacity: 1; }
        90% { opacity: 1; }
        100% { transform: translateY(-100vh) translateX(50px); opacity: 0; }
    }

    /* Floating shapes in background */
    .shape {
        position: absolute;
        opacity: 0.1;
        animation: floatShape 20s infinite ease-in-out;
    }

    .shape-1 {
        width: 300px;
        height: 300px;
        background: white;
        border-radius: 50%;
        top: -100px;
        left: -100px;
    }

    .shape-2 {
        width: 200px;
        height: 200px;
        background: white;
        border-radius: 50%;
        bottom: -50px;
        right: -50px;
        animation-delay: 5s;
    }

    @keyframes floatShape {
        0%, 100% { transform: translate(0, 0) rotate(0deg); }
        33% { transform: translate(30px, -30px) rotate(120deg); }
        66% { transform: translate(-20px, 20px) rotate(240deg); }
    }

    /* Login Container */
    .login-container {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        padding: 45px 40px;
        border-radius: 25px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        width: 90%;
        max-width: 420px;
        text-align: center;
        position: relative;
        z-index: 1;
        animation: slideIn 0.8s cubic-bezier(0.4, 0, 0.2, 1);
    }

    @keyframes slideIn {
        from {
            opacity: 0;
            transform: translateY(50px) scale(0.9);
        }
        to {
            opacity: 1;
            transform: translateY(0) scale(1);
        }
    }

    /* Logo/Icon */
    .login-icon {
        width: 80px;
        height: 80px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 40px;
        margin: 0 auto 25px;
        animation: bounce 2s ease-in-out infinite;
    }

    @keyframes bounce {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-15px); }
    }

    /* Header */
    .login-container h2 {
        font-size: 28px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        margin-bottom: 10px;
        animation: fadeIn 0.8s ease-out 0.2s backwards;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(-20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .login-subtitle {
        color: #666;
        font-size: 14px;
        margin-bottom: 30px;
        animation: fadeIn 0.8s ease-out 0.3s backwards;
    }

    /* Error Message */
    .error {
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        color: white;
        padding: 12px 15px;
        border-radius: 12px;
        margin-bottom: 20px;
        font-size: 14px;
        font-weight: 600;
        animation: shakeError 0.5s ease-out;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }

    @keyframes shakeError {
        0%, 100% { transform: translateX(0); }
        25% { transform: translateX(-10px); }
        75% { transform: translateX(10px); }
    }

    /* Form */
    form {
        animation: fadeIn 0.8s ease-out 0.4s backwards;
    }

    .input-group {
        position: relative;
        margin-bottom: 20px;
        animation: slideRight 0.6s ease-out backwards;
    }

    .input-group:nth-child(1) { animation-delay: 0.5s; }
    .input-group:nth-child(2) { animation-delay: 0.6s; }

    @keyframes slideRight {
        from {
            opacity: 0;
            transform: translateX(-30px);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }

    .input-icon {
        position: absolute;
        left: 15px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 20px;
        opacity: 0.5;
        transition: all 0.3s ease;
    }

    input[type="text"],
    input[type="password"] {
        width: 100%;
        padding: 14px 14px 14px 50px;
        border: 2px solid #e5e7eb;
        border-radius: 12px;
        font-size: 16px;
        transition: all 0.3s ease;
        background: white;
        color: #333;
    }

    input[type="text"]:focus,
    input[type="password"]:focus {
        outline: none;
        border-color: #667eea;
        box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        transform: translateY(-2px);
    }

    input[type="text"]:focus ~ .input-icon,
    input[type="password"]:focus ~ .input-icon {
        opacity: 1;
        color: #667eea;
        transform: translateY(-50%) scale(1.1);
    }

    input[type="text"]:hover,
    input[type="password"]:hover {
        border-color: #764ba2;
    }

    /* Submit Button */
    .submit-btn {
        width: 100%;
        padding: 15px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 12px;
        font-size: 16px;
        font-weight: 700;
        cursor: pointer;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        margin-top: 10px;
        position: relative;
        overflow: hidden;
        text-transform: uppercase;
        letter-spacing: 1px;
        animation: fadeIn 0.8s ease-out 0.7s backwards;
    }

    .submit-btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
        transition: left 0.6s;
    }

    .submit-btn:hover::before {
        left: 100%;
    }

    .submit-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 12px 30px rgba(102, 126, 234, 0.5);
    }

    .submit-btn:active {
        transform: translateY(-1px);
    }

    /* Additional Info */
    .login-footer {
        margin-top: 25px;
        font-size: 13px;
        color: #666;
        animation: fadeIn 0.8s ease-out 0.8s backwards;
    }

    /* Loading Animation */
    .loading {
        display: none;
        margin-top: 15px;
    }

    .loading-spinner {
        border: 3px solid #f3f3f3;
        border-top: 3px solid #667eea;
        border-radius: 50%;
        width: 30px;
        height: 30px;
        animation: spin 1s linear infinite;
        margin: 0 auto;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .login-container {
            padding: 35px 25px;
            margin: 0 20px;
        }

        .login-container h2 {
            font-size: 24px;
        }

        .login-icon {
            width: 60px;
            height: 60px;
            font-size: 30px;
        }
    }

    /* Flower cursor effect */
    .flower {
        position: fixed;
        pointer-events: none;
        z-index: 9999;
        animation: flowerFall 3s ease-out forwards;
    }

    @keyframes flowerFall {
        0% {
            transform: translateY(0) rotate(0deg) scale(1);
            opacity: 1;
        }
        100% {
            transform: translateY(100vh) rotate(720deg) scale(0.5);
            opacity: 0;
        }
    }
    </style>
</head>
<body>
    <!-- Animated Background -->
    <div class="bg-animation">
        <div class="particle" style="left: 10%; animation-delay: 0s;"></div>
        <div class="particle" style="left: 20%; animation-delay: 2s;"></div>
        <div class="particle" style="left: 30%; animation-delay: 4s;"></div>
        <div class="particle" style="left: 40%; animation-delay: 1s;"></div>
        <div class="particle" style="left: 50%; animation-delay: 3s;"></div>
        <div class="particle" style="left: 60%; animation-delay: 5s;"></div>
        <div class="particle" style="left: 70%; animation-delay: 2.5s;"></div>
        <div class="particle" style="left: 80%; animation-delay: 4.5s;"></div>
        <div class="particle" style="left: 90%; animation-delay: 1.5s;"></div>
    </div>

    <!-- Floating Shapes -->
    <div class="shape shape-1"></div>
    <div class="shape shape-2"></div>

    <!-- Login Container -->
    <div class="login-container">
        <div class="login-icon">🔐</div>
        <h2>Welcome Back!</h2>
        <p class="login-subtitle">Please login to your account</p>

        <% String error = (String) request.getAttribute("errorMessage"); %>
        <% if (error != null) { %>
            <div class="error">
                <span>⚠️</span>
                <span><%= error %></span>
            </div>
        <% } %>

        <form action="login" method="post" id="loginForm">
            <div class="input-group">
                <input type="text" name="username" placeholder="Enter Username" required autocomplete="username">
                <span class="input-icon">👤</span>
            </div>

            <div class="input-group">
                <input type="password" name="password" placeholder="Enter Password" required autocomplete="current-password">
                <span class="input-icon">🔒</span>
            </div>

            <button type="submit" class="submit-btn">
                🚀 Login
            </button>

            <div class="loading" id="loading">
                <div class="loading-spinner"></div>
            </div>
        </form>

        <div class="login-footer">
            Secure login powered by Employee Management System
        </div>
    </div>

    <script>
        // Flower cursor effect
        const flowerEmojis = ['🌸', '🌺', '🌼', '🌻', '🌷', '🌹', '💐', '🏵️', '💮'];
        let lastFlowerTime = 0;
        const flowerDelay = 50;

        document.addEventListener('mousemove', function(e) {
            const currentTime = Date.now();

            if (currentTime - lastFlowerTime > flowerDelay) {
                const flower = document.createElement('div');
                flower.className = 'flower';
                flower.textContent = flowerEmojis[Math.floor(Math.random() * flowerEmojis.length)];
                flower.style.left = e.pageX + 'px';
                flower.style.top = e.pageY + 'px';
                flower.style.fontSize = (Math.random() * 20 + 15) + 'px';

                document.body.appendChild(flower);

                lastFlowerTime = currentTime;

                setTimeout(() => {
                    flower.remove();
                }, 3000);
            }
        });

        // Form submission animation
        const form = document.getElementById('loginForm');
        const loading = document.getElementById('loading');

        form.addEventListener('submit', function(e) {
            const username = form.querySelector('input[name="username"]').value;
            const password = form.querySelector('input[name="password"]').value;

            if (username && password) {
                loading.style.display = 'block';
            }
        });

        // Input validation feedback
        const inputs = document.querySelectorAll('input[required]');

        inputs.forEach(input => {
            input.addEventListener('blur', function() {
                if (!this.value.trim()) {
                    this.style.borderColor = '#ef4444';
                    this.style.animation = 'shake 0.5s';

                    setTimeout(() => {
                        this.style.animation = '';
                    }, 500);
                }
            });

            input.addEventListener('input', function() {
                if (this.style.borderColor === 'rgb(239, 68, 68)') {
                    this.style.borderColor = '#e5e7eb';
                }
            });
        });

        // Add shake animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                25% { transform: translateX(-10px); }
                75% { transform: translateX(10px); }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>
