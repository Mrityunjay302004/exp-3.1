<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Deleted Employees History</title>
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
        overflow-x: hidden;
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

    /* Navbar */
    .navbar {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        padding: 20px 40px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        z-index: 1000;
        animation: slideDown 0.6s ease-out;
    }

    @keyframes slideDown {
        from {
            transform: translateY(-100%);
            opacity: 0;
        }
        to {
            transform: translateY(0);
            opacity: 1;
        }
    }

    .nav-left {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .logo {
        width: 40px;
        height: 40px;
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: bold;
        font-size: 20px;
    }

    .nav-title {
        font-weight: 700;
        font-size: 24px;
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .back-btn {
        padding: 12px 24px;
        border-radius: 12px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        overflow: hidden;
        font-size: 14px;
    }

    .back-btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
        transition: left 0.6s;
    }

    .back-btn:hover::before {
        left: 100%;
    }

    .back-btn:hover {
        transform: translateY(-3px) scale(1.05);
        box-shadow: 0 12px 24px rgba(102, 126, 234, 0.4);
    }

    /* Main Container */
    .container {
        padding: 120px 40px 40px;
        max-width: 1600px;
        margin: 0 auto;
        position: relative;
        z-index: 1;
        animation: fadeIn 0.8s ease-out 0.2s both;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* Header Section */
    .page-header {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        padding: 30px;
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
        animation: slideUp 0.6s ease-out 0.3s backwards;
        display: flex;
        align-items: center;
        gap: 20px;
    }

    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(50px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .page-header-icon {
        width: 60px;
        height: 60px;
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        border-radius: 15px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 30px;
        animation: bounce 2s ease-in-out infinite;
    }

    @keyframes bounce {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-10px); }
    }

    .page-header-content h2 {
        font-size: 28px;
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        margin-bottom: 5px;
    }

    .page-header-content p {
        color: #666;
        font-size: 14px;
    }

    /* Stats Card */
    .stats-card {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        padding: 25px;
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
        animation: slideUp 0.6s ease-out 0.4s backwards;
        text-align: center;
    }

    .stat-value {
        font-size: 48px;
        font-weight: 700;
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        margin-bottom: 10px;
    }

    .stat-label {
        font-size: 14px;
        color: #666;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    /* Table Container */
    .table-container {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        border-radius: 24px;
        overflow: hidden;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
        animation: slideUp 0.6s ease-out 0.5s backwards;
    }

    /* Table */
    table {
        width: 100%;
        border-collapse: collapse;
    }

    thead {
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
    }

    th {
        padding: 20px 24px;
        text-align: left;
        color: white;
        font-weight: 600;
        text-transform: uppercase;
        font-size: 13px;
        letter-spacing: 1px;
        border: none;
    }

    tbody tr {
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
        animation: fadeInRow 0.5s ease-out backwards;
    }

    tbody tr:nth-child(1) { animation-delay: 0.6s; }
    tbody tr:nth-child(2) { animation-delay: 0.65s; }
    tbody tr:nth-child(3) { animation-delay: 0.7s; }
    tbody tr:nth-child(4) { animation-delay: 0.75s; }
    tbody tr:nth-child(5) { animation-delay: 0.8s; }

    @keyframes fadeInRow {
        from {
            opacity: 0;
            transform: translateX(-20px);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }

    tbody tr:hover {
        background: linear-gradient(90deg, rgba(239, 68, 68, 0.08) 0%, rgba(220, 38, 38, 0.08) 100%);
        transform: scale(1.01);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    td {
        padding: 20px 24px;
        border: none;
        color: #333;
        font-size: 15px;
    }

    /* Employee ID Badge */
    .emp-id {
        display: inline-block;
        padding: 6px 14px;
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        color: white;
        border-radius: 8px;
        font-weight: 600;
        font-size: 13px;
    }

    /* Department Badge */
    .dept-badge {
        display: inline-block;
        padding: 6px 14px;
        background: rgba(239, 68, 68, 0.15);
        color: #dc2626;
        border-radius: 8px;
        font-weight: 600;
        font-size: 13px;
    }

    /* Salary Display */
    .salary {
        font-weight: 700;
        color: #dc2626;
        font-size: 16px;
    }

    /* Deleted timestamp */
    .deleted-time {
        color: #999;
        font-size: 13px;
        font-style: italic;
    }

    /* Restore Button */
    .restore-form {
        display: inline;
    }

    .restore-btn {
        padding: 10px 20px;
        border-radius: 10px;
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        color: white;
        border: none;
        font-weight: 600;
        font-size: 13px;
        cursor: pointer;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        overflow: hidden;
    }

    .restore-btn::before {
        content: '';
        position: absolute;
        top: 50%;
        left: 50%;
        width: 0;
        height: 0;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.3);
        transform: translate(-50%, -50%);
        transition: width 0.6s, height 0.6s;
    }

    .restore-btn:hover::before {
        width: 300px;
        height: 300px;
    }

    .restore-btn span {
        position: relative;
        z-index: 1;
    }

    .restore-btn:hover {
        transform: translateY(-3px) scale(1.05);
        box-shadow: 0 8px 20px rgba(16, 185, 129, 0.4);
    }

    /* Empty State */
    .empty-state {
        text-align: center;
        padding: 80px 20px;
    }

    .empty-icon {
        font-size: 80px;
        margin-bottom: 20px;
        animation: float-icon 3s ease-in-out infinite;
    }

    @keyframes float-icon {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-20px); }
    }

    .empty-state h3 {
        font-size: 24px;
        margin-bottom: 10px;
        color: #333;
    }

    .empty-state p {
        color: #666;
        font-size: 16px;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .navbar {
            padding: 15px 20px;
            flex-direction: column;
            gap: 15px;
        }

        .container {
            padding: 180px 20px 40px;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            min-width: 900px;
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

    <!-- Navbar -->
    <div class="navbar">
        <div class="nav-left">
            <div class="logo">🗑️</div>
            <div class="nav-title">Deleted History</div>
        </div>
        <a class="back-btn" href="employee">⬅️ Back to Dashboard</a>
    </div>

    <!-- Main Container -->
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <div class="page-header-icon">📋</div>
            <div class="page-header-content">
                <h2>Deleted Employees History</h2>
                <p>View and restore previously deleted employee records</p>
            </div>
        </div>

        <!-- Stats Card -->
        <div class="stats-card">
            <div class="stat-value" id="deletedCount">0</div>
            <div class="stat-label">Total Deleted Records</div>
        </div>

        <!-- Table Container -->
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Employee ID</th>
                        <th>Name</th>
                        <th>Salary</th>
                        <th>Department</th>
                        <th>Joining Date</th>
                        <th>Deleted At</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<String[]> deleted = (List<String[]>) request.getAttribute("deletedData");
                        if (deleted != null && !deleted.isEmpty()) {
                            for(String[] row : deleted) {
                    %>
                    <tr>
                        <td><span class="emp-id"><%= row[0] %></span></td>
                        <td><strong><%= row[1] %></strong></td>
                        <td><span class="salary">₹<%= row[2] %></span></td>
                        <td><span class="dept-badge"><%= row[3] %></span></td>
                        <td><%= row[4] %></td>
                        <td><span class="deleted-time">🕒 <%= row[5] %></span></td>
                        <td>
                            <form class="restore-form" action="employee" method="post">
                                <input type="hidden" name="action" value="restore">
                                <input type="hidden" name="id" value="<%= row[0] %>">
                                <button type="submit" class="restore-btn">
                                    <span>♻️ Restore</span>
                                </button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="7">
                            <div class="empty-state">
                                <div class="empty-icon">🎉</div>
                                <h3>No Deleted Records</h3>
                                <p>Great! You haven't deleted any employee records yet.</p>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
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

        // Calculate deleted count
        const rows = document.querySelectorAll('tbody tr');
        const deletedCount = rows[0]?.cells.length === 7 ? rows.length : 0;
        document.getElementById('deletedCount').textContent = deletedCount;
    </script>
</body>
</html>
