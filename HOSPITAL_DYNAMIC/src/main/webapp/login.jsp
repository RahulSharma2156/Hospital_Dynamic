<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff & Doctor Login | CityCare Hospital</title>
    <!-- Google Fonts & Font Awesome -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <style>
        :root {
            --primary: #0284c7;
            --primary-hover: #0369a1;
            --primary-light: #e0f2fe;
            --secondary: #0d9488;
            --dark: #0f172a;
            --dark-muted: #475569;
            --border-color: #cbd5e1;
            --shadow-lg: 0 15px 35px rgba(2, 132, 199, 0.15);
            --radius-md: 12px;
            --radius-lg: 20px;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Plus Jakarta Sans', sans-serif; }
        
        body {
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .auth-card {
            background: #ffffff;
            border-radius: var(--radius-lg);
            padding: 40px;
            width: 100%;
            max-width: 460px;
            box-shadow: var(--shadow-lg);
            border: 1px solid #bae6fd;
        }

        .auth-header {
            text-align: center;
            margin-bottom: 26px;
        }

        .auth-logo {
            width: 56px;
            height: 56px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 14px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: #ffffff;
            font-size: 26px;
            margin-bottom: 12px;
        }

        .auth-header h2 {
            font-family: 'Outfit', sans-serif;
            font-size: 24px;
            font-weight: 800;
            color: var(--dark);
        }

        .auth-header p {
            font-size: 13px;
            color: var(--dark-muted);
            margin-top: 4px;
        }

        .input-group {
            margin-bottom: 18px;
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .input-group label {
            font-size: 13px;
            font-weight: 700;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .input-group input {
            padding: 13px 16px;
            border: 1.5px solid var(--border-color);
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            transition: all 0.2s;
            background: #fff;
        }

        .input-group input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px var(--primary-light);
        }

        .btn-submit {
            width: 100%;
            padding: 14px;
            background: var(--primary);
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-top: 10px;
            transition: 0.2s;
        }

        .btn-submit:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
        }

        .auth-links {
            text-align: center;
            margin-top: 24px;
            font-size: 14px;
            color: var(--dark-muted);
        }

        .auth-links a {
            text-decoration: none;
        }

        .alert-success {
            background-color: #d1fae5;
            color: #065f46;
            padding: 12px 14px;
            border-radius: 8px;
            margin-bottom: 18px;
            font-size: 13px;
            text-align: center;
            font-weight: 600;
            border: 1px solid #a7f3d0;
        }

        .alert-error {
            background-color: #fee2e2;
            color: #991b1b;
            padding: 12px 14px;
            border-radius: 8px;
            margin-bottom: 18px;
            font-size: 13px;
            text-align: center;
            font-weight: 600;
            border: 1px solid #fca5a5;
        }
    </style>
</head>
<body>

    <div class="auth-card">
        <div class="auth-header">
            <div class="auth-logo"><i class="fa-solid fa-hospital-user"></i></div>
            <h2>Staff Portal Login</h2>
            <p>Enter your Staff ID & Password to access dashboard</p>
        </div>

        <% 
            String msg = request.getParameter("msg"); 
            String code = request.getParameter("code");
            String error = request.getParameter("error"); 

            if ("registered".equals(msg)) { 
        %>
            <div class="alert-success">
                <i class="fa-solid fa-circle-check"></i> Staff account is ready. Use ID: <strong><%= (code != null ? code : "") %></strong> to login.
            </div>
        <% } else if ("logout".equals(msg)) { %>
            <div class="alert-success">
                <i class="fa-solid fa-right-from-bracket"></i> You have logged out successfully.
            </div>
        <% } %>

        <% if ("invalid".equals(error)) { %>
            <div class="alert-error">
                <i class="fa-solid fa-triangle-exclamation"></i> Invalid Staff ID / Email or Password!
            </div>
        <% } else if ("dberror".equals(error)) { %>
            <div class="alert-error">
                <i class="fa-solid fa-triangle-exclamation"></i> Database connection failed. Please check MySQL.
            </div>
        <% } else if ("registration_disabled".equals(error)) { %>
            <div class="alert-error">
                <i class="fa-solid fa-user-shield"></i> Account creation is disabled. Please use your assigned staff credentials.
            </div>
        <% } %>

        <!-- Form submits directly to Login_Servlet -->
        <form action="Login_Servlet" method="POST">
            <div class="input-group">
                <label><i class="fa-solid fa-id-badge"></i> Staff ID / Email Address</label>
                <input type="text" name="staff_code" placeholder="e.g. STF-1001 or email" required>
            </div>

            <div class="input-group">
                <label><i class="fa-solid fa-lock"></i> Account Password</label>
                <input type="password" name="password" placeholder="Enter your password" required>
            </div>

            <button type="submit" class="btn-submit">
                <i class="fa-solid fa-right-to-bracket"></i> Staff Login
            </button>
        </form>

        <div class="auth-links">
            Authorized staff only | <a href="index.jsp" style="color: var(--primary); font-weight: 600;">Home</a>
        </div>
    </div>

</body>
</html>
