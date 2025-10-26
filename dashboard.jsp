<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Dashboard</title>
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
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .nav-right {
        display: flex;
        gap: 12px;
        flex-wrap: wrap;
    }

    .nav-btn {
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

    .nav-btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
        transition: left 0.6s;
    }

    .nav-btn:hover::before {
        left: 100%;
    }

    .nav-btn:hover {
        transform: translateY(-3px) scale(1.05);
        box-shadow: 0 12px 24px rgba(102, 126, 234, 0.4);
    }

    .nav-btn.logout {
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
    }

    .nav-btn.logout:hover {
        box-shadow: 0 12px 24px rgba(245, 87, 108, 0.4);
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

    /* Stats Cards */
    .stats-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }

    .stat-card {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        padding: 25px;
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        animation: slideUp 0.6s ease-out backwards;
    }

    .stat-card:nth-child(1) { animation-delay: 0.3s; }
    .stat-card:nth-child(2) { animation-delay: 0.4s; }
    .stat-card:nth-child(3) { animation-delay: 0.5s; }

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

    .stat-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 16px 48px rgba(0, 0, 0, 0.15);
    }

    .stat-label {
        font-size: 14px;
        color: #666;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .stat-value {
        font-size: 36px;
        font-weight: 700;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        margin-top: 10px;
    }

    /* Search and Filter Bar */
    .search-filter-container {
        display: flex;
        gap: 15px;
        margin-bottom: 30px;
        animation: slideUp 0.6s ease-out 0.6s backwards;
        flex-wrap: wrap;
        align-items: center;
    }

    .search-box {
        flex: 1;
        min-width: 300px;
        padding: 16px 24px;
        border: none;
        border-radius: 16px;
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        font-size: 16px;
        transition: all 0.3s ease;
    }

    .search-box:focus {
        outline: none;
        box-shadow: 0 12px 40px rgba(102, 126, 234, 0.3);
        transform: translateY(-2px);
    }

    .filter-group {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
    }

    .filter-select {
        padding: 14px 20px;
        border: none;
        border-radius: 16px;
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        font-size: 15px;
        font-weight: 600;
        color: #667eea;
        cursor: pointer;
        transition: all 0.3s ease;
        min-width: 160px;
    }

    .filter-select:hover {
        box-shadow: 0 12px 40px rgba(102, 126, 234, 0.3);
        transform: translateY(-2px);
    }

    .filter-select:focus {
        outline: none;
        box-shadow: 0 12px 40px rgba(102, 126, 234, 0.4);
    }

    .sort-btn {
        padding: 14px 24px;
        border: none;
        border-radius: 16px;
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        font-size: 15px;
        font-weight: 600;
        color: #667eea;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .sort-btn:hover {
        box-shadow: 0 12px 40px rgba(102, 126, 234, 0.3);
        transform: translateY(-2px);
    }

    .sort-btn.active {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
    }

    .clear-filters {
        padding: 14px 24px;
        border: none;
        border-radius: 16px;
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        color: white;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .clear-filters:hover {
        transform: translateY(-2px);
        box-shadow: 0 12px 24px rgba(245, 87, 108, 0.4);
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

    /* Table Container */
    .table-container {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        border-radius: 24px;
        overflow: hidden;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
        animation: slideUp 0.6s ease-out 0.7s backwards;
    }

    /* Table */
    table {
        width: 100%;
        border-collapse: collapse;
    }

    thead {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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

    tbody tr:nth-child(1) { animation-delay: 0.8s; }
    tbody tr:nth-child(2) { animation-delay: 0.85s; }
    tbody tr:nth-child(3) { animation-delay: 0.9s; }
    tbody tr:nth-child(4) { animation-delay: 0.95s; }
    tbody tr:nth-child(5) { animation-delay: 1s; }

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
        background: linear-gradient(90deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
        transform: scale(1.01);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    /* Highlight newest entry */
    tbody tr:first-child {
        background: linear-gradient(90deg, rgba(16, 185, 129, 0.08) 0%, rgba(5, 150, 105, 0.08) 100%);
        border-left: 4px solid #10b981;
    }

    tbody tr:first-child td:last-child {
        position: relative;
    }

    tbody tr:first-child td:last-child::after {
        content: '🆕 LATEST';
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        color: white;
        padding: 6px 14px;
        border-radius: 8px;
        font-size: 11px;
        font-weight: 700;
        letter-spacing: 1px;
        animation: pulse 2s ease-in-out infinite;
        white-space: nowrap;
        z-index: 1;
    }

    @keyframes pulse {
        0%, 100% { opacity: 1; transform: translateY(-50%) scale(1); }
        50% { opacity: 0.8; transform: translateY(-50%) scale(1.05); }
    }

    tbody tr:first-child:hover {
        background: linear-gradient(90deg, rgba(16, 185, 129, 0.12) 0%, rgba(5, 150, 105, 0.12) 100%);
    }

    tbody tr:first-child td:last-child .btn-group {
        margin-right: 120px;
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
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-radius: 8px;
        font-weight: 600;
        font-size: 13px;
    }

    /* Department Badge */
    .dept-badge {
        display: inline-block;
        padding: 6px 14px;
        background: rgba(102, 126, 234, 0.1);
        color: #667eea;
        border-radius: 8px;
        font-weight: 600;
        font-size: 13px;
    }

    /* Salary Display */
    .salary {
        font-weight: 700;
        color: #10b981;
        font-size: 16px;
    }

    /* Action Buttons */
    .btn-group {
        display: flex;
        gap: 10px;
    }

    .btn {
        padding: 10px 20px;
        border-radius: 10px;
        color: white;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        font-size: 13px;
        position: relative;
        overflow: hidden;
    }

    .btn::before {
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

    .btn:hover::before {
        width: 300px;
        height: 300px;
    }

    .btn span {
        position: relative;
        z-index: 1;
    }

    .btn.update {
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
    }

    .btn.update:hover {
        transform: translateY(-3px) scale(1.05);
        box-shadow: 0 8px 20px rgba(16, 185, 129, 0.4);
    }

    .btn.delete {
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
    }

    .btn.delete:hover {
        transform: translateY(-3px) scale(1.05);
        box-shadow: 0 8px 20px rgba(239, 68, 68, 0.4);
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
            min-width: 800px;
        }

        .stats-container {
            grid-template-columns: 1fr;
        }
    }

    /* Empty State */
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        color: #666;
    }

    .empty-state h3 {
        font-size: 24px;
        margin-bottom: 10px;
        color: #333;
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
            <div class="logo">E</div>
            <div class="nav-title">Employee Dashboard</div>
        </div>
        <div class="nav-right">
            <a class="nav-btn" href="employee?action=add">➕ Add Employee</a>
            <a class="nav-btn" href="employee?action=history">📋 History</a>
            <a class="nav-btn logout" href="logout">🚪 Logout</a>
        </div>
    </div>

    <!-- Main Container -->
    <div class="container">
        <!-- Current Date/Time Display -->
        <div class="current-info" style="background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(20px); padding: 20px 30px; border-radius: 20px; box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1); margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; animation: slideUp 0.6s ease-out 0.2s backwards; flex-wrap: wrap; gap: 15px;">
            <div style="display: flex; align-items: center; gap: 15px;">
                <span style="font-size: 30px;">📅</span>
                <div>
                    <div style="font-size: 14px; color: #666; font-weight: 600; text-transform: uppercase; letter-spacing: 1px;">Current Date & Time</div>
                    <div id="currentDateTime" style="font-size: 20px; font-weight: 700; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; margin-top: 5px;"></div>
                </div>
            </div>
            <div style="display: flex; align-items: center; gap: 10px; padding: 12px 20px; background: linear-gradient(135deg, #10b981 0%, #059669 100%); border-radius: 12px; color: white; font-weight: 600;">
                <span>⏰</span>
                <span id="currentTime"></span>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-label">Total Employees</div>
                <div class="stat-value" id="totalCount">0</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Active Today</div>
                <div class="stat-value" id="activeCount">0</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Departments</div>
                <div class="stat-value" id="deptCount">0</div>
            </div>
        </div>

        <!-- Search and Filter Bar -->
        <div class="search-filter-container">
            <input type="text" class="search-box" id="searchInput" placeholder="🔍 Search employees by name, department, or ID...">

            <div class="filter-group">
                <select class="filter-select" id="departmentFilter">
                    <option value="">All Departments</option>
                </select>

                <select class="filter-select" id="salaryFilter">
                    <option value="">All Salaries</option>
                    <option value="0-30000">₹0 - ₹30,000</option>
                    <option value="30000-50000">₹30,000 - ₹50,000</option>
                    <option value="50000-75000">₹50,000 - ₹75,000</option>
                    <option value="75000-100000">₹75,000 - ₹1,00,000</option>
                    <option value="100000-999999999">₹1,00,000+</option>
                </select>

                <button class="sort-btn" id="sortByName">
                    <span>📝</span> Sort by Name
                </button>

                <button class="sort-btn" id="sortBySalary">
                    <span>💰</span> Sort by Salary
                </button>

                <button class="sort-btn" id="sortByDate">
                    <span>📅</span> Sort by Date
                </button>

                <button class="clear-filters" id="clearFilters">
                    🔄 Reset
                </button>
            </div>
        </div>

        <!-- Table Container -->
        <div class="table-container">
            <table id="employeeTable">
                <thead>
                    <tr>
                        <th>Employee ID</th>
                        <th>Name</th>
                        <th>Salary</th>
                        <th>Department</th>
                        <th>Joining Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<String[]> data = (List<String[]>) request.getAttribute("employeeData");
                        if (data != null && !data.isEmpty()) {
                            for(String[] row : data) {
                    %>
                    <tr>
                        <td><span class="emp-id"><%= row[0] %></span></td>
                        <td><strong><%= row[1] %></strong></td>
                        <td><span class="salary">₹<%= row[2] %></span></td>
                        <td><span class="dept-badge"><%= row[3] %></span></td>
                        <td><%= row[4] %></td>
                        <td>
                            <div class="btn-group">
                                <a class="btn update" href="employee?action=update&id=<%=row[0]%>">
                                    <span>✏️ Update</span>
                                </a>
                                <a class="btn delete" href="employee?action=delete&id=<%=row[0]%>" onclick="return confirm('Are you sure you want to delete this employee?')">
                                    <span>🗑️ Delete</span>
                                </a>
                            </div>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="6">
                            <div class="empty-state">
                                <h3>No Employees Found</h3>
                                <p>Start by adding your first employee to the system.</p>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // Update current date and time
        function updateDateTime() {
            const now = new Date();

            const dateOptions = {
                weekday: 'long',
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            };
            const dateStr = now.toLocaleDateString('en-US', dateOptions);

            const timeStr = now.toLocaleTimeString('en-US', {
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit',
                hour12: true
            });

            document.getElementById('currentDateTime').textContent = dateStr;
            document.getElementById('currentTime').textContent = timeStr;
        }

        // Update immediately and then every second
        updateDateTime();
        setInterval(updateDateTime, 1000);

        // Flower cursor effect
        const flowerEmojis = ['🌸', '🌺', '🌼', '🌻', '🌷', '🌹', '💐', '🏵️', '💮'];
        let lastFlowerTime = 0;
        const flowerDelay = 50; // milliseconds between flowers

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

                // Remove flower after animation
                setTimeout(() => {
                    flower.remove();
                }, 3000);
            }
        });

        // Store original rows for filtering
        let allRows = [];
        const tableBody = document.querySelector('#employeeTable tbody');
        const rows = document.querySelectorAll('#employeeTable tbody tr');

        // Store original data
        rows.forEach(row => {
            if (row.cells.length > 1) {
                allRows.push({
                    element: row,
                    id: row.cells[0].textContent.trim(),
                    name: row.cells[1].textContent.trim(),
                    salary: parseFloat(row.cells[2].textContent.replace(/[₹,]/g, '')),
                    department: row.cells[3].textContent.trim(),
                    date: row.cells[4].textContent.trim(),
                    addedTime: new Date(row.cells[4].textContent) // For sorting by most recent
                });
            }
        });

        // Sort by most recent first (newest at top)
        allRows.sort((a, b) => b.addedTime - a.addedTime);
        allRows.forEach(row => tableBody.appendChild(row.element));

        // Calculate stats
        const totalCount = allRows.length;
        const departments = new Set(allRows.map(row => row.department));

        document.getElementById('totalCount').textContent = totalCount;
        document.getElementById('activeCount').textContent = totalCount;
        document.getElementById('deptCount').textContent = departments.size;

        // Populate department filter
        const deptFilter = document.getElementById('departmentFilter');
        departments.forEach(dept => {
            const option = document.createElement('option');
            option.value = dept;
            option.textContent = dept;
            deptFilter.appendChild(option);
        });

        // Filter and search functionality
        function applyFilters() {
            const searchText = document.getElementById('searchInput').value.toLowerCase();
            const deptValue = document.getElementById('departmentFilter').value;
            const salaryRange = document.getElementById('salaryFilter').value;

            let filteredRows = allRows;

            // Search filter
            if (searchText) {
                filteredRows = filteredRows.filter(row =>
                    row.id.toLowerCase().includes(searchText) ||
                    row.name.toLowerCase().includes(searchText) ||
                    row.department.toLowerCase().includes(searchText)
                );
            }

            // Department filter
            if (deptValue) {
                filteredRows = filteredRows.filter(row => row.department === deptValue);
            }

            // Salary range filter
            if (salaryRange) {
                const [min, max] = salaryRange.split('-').map(Number);
                filteredRows = filteredRows.filter(row =>
                    row.salary >= min && row.salary <= max
                );
            }

            // Hide all rows first
            allRows.forEach(row => row.element.style.display = 'none');

            // Show filtered rows
            filteredRows.forEach(row => row.element.style.display = '');

            // Update active count
            document.getElementById('activeCount').textContent = filteredRows.length;
        }

        // Sort functionality
        let sortOrder = {
            name: 'asc',
            salary: 'asc',
            date: 'asc'
        };

        function sortTable(sortBy, button) {
            // Remove active class from all sort buttons
            document.querySelectorAll('.sort-btn').forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');

            const order = sortOrder[sortBy];

            allRows.sort((a, b) => {
                let valA, valB;

                if (sortBy === 'name') {
                    valA = a.name.toLowerCase();
                    valB = b.name.toLowerCase();
                } else if (sortBy === 'salary') {
                    valA = a.salary;
                    valB = b.salary;
                } else if (sortBy === 'date') {
                    valA = new Date(a.date);
                    valB = new Date(b.date);
                }

                if (order === 'asc') {
                    return valA > valB ? 1 : -1;
                } else {
                    return valA < valB ? 1 : -1;
                }
            });

            // Toggle sort order
            sortOrder[sortBy] = order === 'asc' ? 'desc' : 'asc';

            // Reorder DOM elements
            allRows.forEach(row => tableBody.appendChild(row.element));

            applyFilters();
        }

        // Event listeners
        document.getElementById('searchInput').addEventListener('input', applyFilters);
        document.getElementById('departmentFilter').addEventListener('change', applyFilters);
        document.getElementById('salaryFilter').addEventListener('change', applyFilters);

        document.getElementById('sortByName').addEventListener('click', function() {
            sortTable('name', this);
        });

        document.getElementById('sortBySalary').addEventListener('click', function() {
            sortTable('salary', this);
        });

        document.getElementById('sortByDate').addEventListener('click', function() {
            sortTable('date', this);
        });

        document.getElementById('clearFilters').addEventListener('click', function() {
            document.getElementById('searchInput').value = '';
            document.getElementById('departmentFilter').value = '';
            document.getElementById('salaryFilter').value = '';
            document.querySelectorAll('.sort-btn').forEach(btn => btn.classList.remove('active'));

            // Reset sort orders
            sortOrder = { name: 'asc', salary: 'asc', date: 'asc' };

            applyFilters();
        });
    </script>
</body>
</html>
