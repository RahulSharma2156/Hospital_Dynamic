<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff & Doctor Registration | CityCare Hospital</title>
    <!-- Google Fonts & Font Awesome -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        :root {
            --primary: #0284c7;
            --primary-hover: #0369a1;
            --primary-light: #e0f2fe;
            --secondary: #0d9488;
            --dark: #0f172a;
            --dark-muted: #475569;
            --light-bg: #f0f9ff;
            --border-color: #cbd5e1;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Plus Jakarta Sans', sans-serif; }
        body {
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px 15px;
        }

        .register-container {
            background: #ffffff;
            width: 100%;
            max-width: 580px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(2, 132, 199, 0.15);
            border: 1px solid #bae6fd;
            padding: 40px;
        }

        .brand-header {
            text-align: center;
            margin-bottom: 28px;
        }

        .logo-badge {
            width: 56px;
            height: 56px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 14px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-size: 26px;
            margin-bottom: 12px;
        }

        .brand-title {
            font-family: 'Outfit', sans-serif;
            font-size: 24px;
            font-weight: 800;
            color: var(--dark);
        }

        .brand-subtitle {
            font-size: 13px;
            color: var(--dark-muted);
            margin-top: 4px;
        }

        .form-grid-2 {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .input-group {
            margin-bottom: 16px;
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

        .input-group input, .input-group select {
            padding: 12px 14px;
            border: 1.5px solid var(--border-color);
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            transition: all 0.2s;
            background: #fff;
        }

        .input-group input:focus, .input-group select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px var(--primary-light);
        }

        .btn-register {
            width: 100%;
            padding: 14px;
            background: var(--primary);
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-top: 10px;
            transition: 0.2s;
        }

        .btn-register:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
        }

        .alert-error {
            background: #fee2e2;
            color: #991b1b;
            padding: 12px;
            border-radius: 8px;
            font-size: 13px;
            margin-bottom: 18px;
            border: 1px solid #f87171;
            text-align: center;
            font-weight: 600;
        }

        .footer-text {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: var(--dark-muted);
        }

        .footer-text a {
            color: var(--primary);
            font-weight: 700;
            text-decoration: none;
        }

        .footer-text a:hover {
            text-decoration: underline;
        }

        @media (max-width: 600px) {
            .form-grid-2 { grid-template-columns: 1fr; }
            .register-container { padding: 25px; }
        }
    </style>
</head>
<body>

    <div class="register-container">
        <div class="brand-header">
            <div class="logo-badge"><i class="fa-solid fa-hospital"></i></div>
            <h1 class="brand-title">Create Staff Account</h1>
            <p class="brand-subtitle">Hospital Doctors, Nurses & Clinical Staff Portal</p>
        </div>

        <!-- Error Alert -->
        <% 
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <div class="alert-error">
                <i class="fa-solid fa-triangle-exclamation"></i> 
                <%= "exists".equals(error) ? "Staff Code or Email already registered!" : "Registration failed! Please try again." %>
            </div>
        <% } %>

        <form action="Register_Servlet" method="POST">
            <div class="input-group">
                <label><i class="fa-solid fa-user-doctor"></i> Full Name</label>
                <input type="text" name="full_name" placeholder="e.g. Dr. Rajesh Sharma" required>
            </div>

            <div class="form-grid-2">
                <div class="input-group">
                    <label><i class="fa-solid fa-id-badge"></i> Staff ID / Code</label>
                    <input type="text" name="staff_code" placeholder="e.g. STF-1005" required>
                </div>
                <div class="input-group">
                    <label><i class="fa-solid fa-briefcase"></i> Role</label>
                    <select name="role" required>
                        <option value="Doctor">Doctor</option>
                        <option value="Nurse">Nurse</option>
                        <option value="Administrator">Administrator</option>
                        <option value="Lab Tech">Lab Tech</option>
                    </select>
                </div>
            </div>

            <div class="form-grid-2">
                <div class="input-group">
                    <label><i class="fa-solid fa-envelope"></i> Official Email</label>
                    <input type="email" name="email" placeholder="doctor@citycare.com" required>
                </div>
                <div class="input-group">
                    <label><i class="fa-solid fa-stethoscope"></i> Department</label>
                    <select name="department_id" required>
                        <option value="1">Cardiology</option>
                        <option value="2">Neurology</option>
                        <option value="3">Orthopedics</option>
                        <option value="4">Pediatrics</option>
                        <option value="7">General Medicine</option>
                    </select>
                </div>
            </div>

            <div class="form-grid-2">
                <div class="input-group">
                    <label><i class="fa-solid fa-lock"></i> Password</label>
                    <input type="password" name="password" placeholder="Create password" required minlength="4">
                </div>
                <div class="input-group">
                    <label><i class="fa-solid fa-shield-halved"></i> Confirm Password</label>
                    <input type="password" name="confirm_password" placeholder="Repeat password" required minlength="4">
                </div>
            </div>

            <button type="submit" class="btn-register">
                <i class="fa-solid fa-user-plus"></i> Register & Create Account
            </button>
        </form>

        <div class="footer-text">
            Already have an account? <a href="login.jsp">Staff Login here</a> | <a href="index.jsp">Back to Home</a>
        </div>
    </div>

</body>
</html>
