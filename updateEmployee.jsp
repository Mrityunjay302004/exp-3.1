<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*, controller.DBConnection" %>
<%
    int empId = Integer.parseInt(request.getParameter("id"));
    String name = "", dept = "", joining = "";
    double salary = 0;

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement("SELECT * FROM employees WHERE EmpID=?")) {
        ps.setInt(1, empId);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            name = rs.getString("Name");
            salary = rs.getDouble("Salary");
            dept = rs.getString("Department");
            joining = rs.getDate("JoiningDate").toString();
        }
    } catch(Exception e) { e.printStackTrace(); }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Employee</title>
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
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 20px;
        overflow: hidden;
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

    /* Form Container */
    .form-container {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        padding: 30px 35px;
        border-radius: 25px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        width: 100%;
        max-width: 480px;
        max-height: 90vh;
        position: relative;
        z-index: 1;
        animation: slideIn 0.8s cubic-bezier(0.4, 0, 0.2, 1);
    }

    @keyframes slideIn {
        from {
            opacity: 0;
            transform: translateY(50px) scale(0.95);
        }
        to {
            opacity: 1;
            transform: translateY(0) scale(1);
        }
    }

    /* Header Section */
    .form-header {
        text-align: center;
        margin-bottom: 25px;
        animation: fadeIn 0.8s ease-out 0.2s backwards;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(-20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .form-icon {
        width: 60px;
        height: 60px;
        background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
        border-radius: 15px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 30px;
        margin: 0 auto 15px;
        animation: bounce 2s ease-in-out infinite;
    }

    @keyframes bounce {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-10px); }
    }

    .form-header h2 {
        font-size: 26px;
        background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        margin-bottom: 8px;
    }

    .form-header p {
        color: #666;
        font-size: 13px;
    }

    .emp-id-badge {
        display: inline-block;
        padding: 6px 14px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-radius: 8px;
        font-weight: 600;
        font-size: 12px;
        margin-top: 8px;
    }

    /* Form Elements */
    form {
        animation: fadeIn 0.8s ease-out 0.4s backwards;
    }

    .form-group {
        margin-bottom: 18px;
        animation: slideRight 0.6s ease-out backwards;
    }

    .form-group:nth-child(1) { animation-delay: 0.5s; }
    .form-group:nth-child(2) { animation-delay: 0.6s; }
    .form-group:nth-child(3) { animation-delay: 0.7s; }
    .form-group:nth-child(4) { animation-delay: 0.8s; }

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

    label {
        display: block;
        margin-bottom: 6px;
        font-weight: 600;
        color: #333;
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    input, select {
        width: 100%;
        padding: 12px 16px;
        border: 2px solid #e5e7eb;
        border-radius: 12px;
        font-size: 15px;
        transition: all 0.3s ease;
        background: white;
        color: #333;
    }

    input:focus, select:focus {
        outline: none;
        border-color: #f59e0b;
        box-shadow: 0 0 0 4px rgba(245, 158, 11, 0.1);
        transform: translateY(-2px);
    }

    input:hover, select:hover {
        border-color: #d97706;
    }

    /* Submit Button */
    .submit-btn {
        width: 100%;
        padding: 14px;
        background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
        color: white;
        border: none;
        border-radius: 12px;
        font-size: 15px;
        font-weight: 700;
        cursor: pointer;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        margin-top: 8px;
        position: relative;
        overflow: hidden;
        text-transform: uppercase;
        letter-spacing: 1px;
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
        box-shadow: 0 12px 30px rgba(245, 158, 11, 0.5);
    }

    .submit-btn:active {
        transform: translateY(-1px);
    }

    /* Back Link */
    .back-link {
        display: block;
        text-align: center;
        margin-top: 18px;
        color: #667eea;
        text-decoration: none;
        font-weight: 600;
        font-size: 14px;
        transition: all 0.3s ease;
        animation: fadeIn 0.8s ease-out 0.9s backwards;
    }

    .back-link:hover {
        color: #764ba2;
        transform: translateX(-5px);
    }

    /* Input Icons */
    .input-wrapper {
        position: relative;
    }

    .input-icon {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 20px;
        opacity: 0.5;
    }

    input[type="text"],
    input[type="number"],
    input[type="date"],
    select {
        padding-right: 45px;
    }

    /* Value changed indicator */
    input.changed {
        border-color: #10b981;
        background: rgba(16, 185, 129, 0.05);
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .form-container {
            padding: 25px 20px;
            max-height: 95vh;
        }

        .form-header h2 {
            font-size: 22px;
        }

        .form-group {
            margin-bottom: 15px;
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

    <!-- Form Container -->
    <div class="form-container">
        <!-- Header -->
        <div class="form-header">
            <div class="form-icon">✏️</div>
            <h2>Update Employee</h2>

            <span class="emp-id-badge">ID: <%= empId %></span>
        </div>

        <!-- Form -->
        <form action="employee" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= empId %>">

            <div class="form-group">
                <label>👤 Employee Name</label>
                <div class="input-wrapper">
                    <input type="text" name="name" value="<%= name %>" placeholder="Enter full name" required data-original="<%= name %>">
                    <span class="input-icon">✏️</span>
                </div>
            </div>

            <div class="form-group">
                <label>💰 Salary</label>
                <div class="input-wrapper">
                    <input type="number" step="0.01" name="salary" value="<%= salary %>" placeholder="Enter salary amount" required data-original="<%= salary %>">
                    <span class="input-icon">₹</span>
                </div>
            </div>

            <div class="form-group">
                <label>🏢 Department</label>
                <div class="input-wrapper">
                    <input type="text" name="department" value="<%= dept %>" placeholder="Enter department name" required data-original="<%= dept %>">
                    <span class="input-icon">📁</span>
                </div>
            </div>

            <div class="form-group">
                <label>📅 Joining Date</label>
                <div class="input-wrapper">
                    <input type="date" name="joiningDate" value="<%= joining %>" required data-original="<%= joining %>">
                    <span class="input-icon">🗓️</span>
                </div>
            </div>

            <button type="submit" class="submit-btn">
                ✅ Update Employee
            </button>
        </form>

        <a href="employee" class="back-link">⬅️ Back to Dashboard</a>
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

        // Track changes in input fields
        const inputs = document.querySelectorAll('input[data-original]');

        inputs.forEach(input => {
            input.addEventListener('input', function() {
                if (this.value !== this.getAttribute('data-original')) {
                    this.classList.add('changed');
                } else {
                    this.classList.remove('changed');
                }
            });
        });

        // Form validation and animations
        const form = document.querySelector('form');
        const requiredInputs = document.querySelectorAll('input[required]');

        form.addEventListener('submit', function(e) {
            let isValid = true;

            requiredInputs.forEach(input => {
                if (!input.value.trim()) {
                    isValid = false;
                    input.style.borderColor = '#ef4444';
                    input.style.animation = 'shake 0.5s';

                    setTimeout(() => {
                        input.style.animation = '';
                    }, 500);
                }
            });

            if (!isValid) {
                e.preventDefault();
            }
        });

        // Reset border color on input
        requiredInputs.forEach(input => {
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
