<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CityCare Super Specialty Hospital | Healthcare & Staff Portal</title>
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
            --secondary-hover: #0f766e;
            --dark: #0f172a;
            --dark-muted: #475569;
            --light-bg: #f8fafc;
            --border-color: #e2e8f0;
            --success: #10b981;
            --danger: #ef4444;
            --shadow-sm: 0 2px 8px rgba(15,23,42,0.05);
            --shadow-md: 0 8px 24px rgba(15,23,42,0.08);
            --shadow-lg: 0 16px 36px rgba(15,23,42,0.12);
            --shadow-hover: 0 20px 40px rgba(2,132,199,0.18);
            --radius-sm: 8px;
            --radius-md: 12px;
            --radius-lg: 20px;
            --radius-full: 9999px;
            --font-heading: 'Outfit', sans-serif;
            --font-body: 'Plus Jakarta Sans', sans-serif;
            --transition: all 0.3s cubic-bezier(0.16,1,0.3,1);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: var(--font-body); }
        body { background-color: var(--light-bg); color: var(--dark); line-height: 1.6; overflow-x: hidden; }
        .container { width: 90%; max-width: 1200px; margin: 0 auto; }
        h1, h2, h3, h4 { font-family: var(--font-heading); font-weight: 700; color: var(--dark); }
        p { color: var(--dark-muted); }
        a { text-decoration: none; transition: var(--transition); }

        /* Buttons */
        .btn { padding: 12px 24px; border-radius: var(--radius-sm); font-weight: 600; font-size: 15px; cursor: pointer; border: 2px solid transparent; display: inline-flex; align-items: center; justify-content: center; gap: 8px; transition: var(--transition); box-shadow: var(--shadow-sm); }
        .btn:hover { transform: translateY(-2px); box-shadow: var(--shadow-md); }
        .btn-primary { background-color: var(--primary); color: #ffffff; }
        .btn-primary:hover { background-color: var(--primary-hover); }
        .btn-secondary { background-color: var(--secondary); color: #ffffff; }
        .btn-secondary:hover { background-color: var(--secondary-hover); }
        .btn-outline { background-color: transparent; border-color: var(--primary); color: var(--primary); }
        .btn-outline:hover { background-color: var(--primary); color: #ffffff; }
        .btn-lg { padding: 14px 28px; font-size: 16px; border-radius: var(--radius-md); }
        .btn-sm { padding: 8px 16px; font-size: 13px; }
        .btn-full { width: 100%; }

        /* Header */
        .header { background-color: rgba(255,255,255,0.95); backdrop-filter: blur(12px); border-bottom: 1px solid var(--border-color); position: sticky; top: 0; z-index: 1000; }
        .nav-box { display: flex; justify-content: space-between; align-items: center; padding: 16px 0; }
        .logo { display: flex; align-items: center; gap: 12px; }
        .logo-icon { width: 44px; height: 44px; background: linear-gradient(135deg, var(--primary), var(--secondary)); border-radius: var(--radius-md); display: flex; align-items: center; justify-content: center; color: #ffffff; font-size: 22px; }
        .brand-name { font-size: 22px; font-weight: 800; color: var(--dark); line-height: 1; }
        .brand-sub { font-size: 11px; font-weight: 600; color: var(--primary); text-transform: uppercase; }
        .nav-links { display: flex; align-items: center; gap: 8px; }
        .nav-item { padding: 8px 16px; color: var(--dark-muted); font-weight: 600; font-size: 15px; border-radius: var(--radius-sm); display: flex; align-items: center; gap: 6px; }
        .nav-item:hover, .nav-item.active { color: var(--primary); background-color: var(--primary-light); }

        /* Hero */
        .hero { position: relative; padding: 70px 0 80px 0; background: linear-gradient(180deg, #f0f9ff 0%, #f8fafc 100%); overflow: hidden; }
        .hero-box { display: grid; grid-template-columns: 1.15fr 0.85fr; gap: 40px; align-items: center; position: relative; z-index: 2; }
        .badge-tag { display: inline-flex; align-items: center; gap: 8px; padding: 8px 16px; background-color: #e0f2fe; color: var(--primary-hover); border-radius: var(--radius-full); font-size: 13px; font-weight: 700; margin-bottom: 20px; border: 1px solid #bae6fd; }
        .hero-text h1 { font-size: 44px; color: var(--dark); margin-bottom: 18px; line-height: 1.2; }
        .hero-text p { font-size: 17px; margin-bottom: 28px; line-height: 1.6; }
        .hero-buttons { display: flex; gap: 16px; margin-bottom: 36px; }

        /* Stats Bar */
        .stats-bar { display: flex; align-items: center; justify-content: space-between; background: #ffffff; padding: 18px 24px; border-radius: var(--radius-md); box-shadow: var(--shadow-md); border: 1px solid var(--border-color); }
        .stat-item { display: flex; flex-direction: column; text-align: center; flex: 1; }
        .stat-number { font-size: 22px; font-weight: 800; color: var(--primary); }
        .stat-label { font-size: 12px; font-weight: 600; color: var(--dark-muted); }
        .stat-divider { width: 1px; height: 32px; background-color: var(--border-color); }

        /* Hero Card */
        .hero-card { background: #ffffff; border-radius: var(--radius-lg); padding: 34px 28px; box-shadow: var(--shadow-lg); border: 1px solid var(--border-color); transition: var(--transition); }
        .hero-card:hover { box-shadow: var(--shadow-hover); border-color: #bae6fd; }
        .card-header { display: flex; justify-content: space-between; align-items: flex-start; padding-bottom: 18px; border-bottom: 1px dashed var(--border-color); margin-bottom: 18px; gap: 12px; }
        .card-title { display: flex; align-items: center; gap: 12px; }
        .card-title-icon { width: 44px; height: 44px; background: var(--primary-light); color: var(--primary); border-radius: var(--radius-md); display: flex; align-items: center; justify-content: center; font-size: 20px; flex-shrink: 0; }
        .card-main-title { font-size: 18px; font-weight: 700; color: var(--dark); display: block; line-height: 1.2; }
        .card-subtitle-inline { font-size: 12px; color: var(--dark-muted); display: block; margin-top: 3px; }
        .badge-green { background-color: #d1fae5; color: #047857; padding: 4px 10px; border-radius: var(--radius-full); font-size: 11px; font-weight: 700; display: inline-flex; align-items: center; gap: 5px; }
        .status-dot { font-size: 7px; color: #10b981; }
        .staff-card-body { display: flex; flex-direction: column; gap: 16px; }
        .staff-features-list { display: flex; align-items: center; gap: 10px; font-size: 12px; color: var(--dark-muted); font-weight: 600; }
        .feature-item { display: flex; align-items: center; gap: 6px; background: #f8fafc; padding: 6px 10px; border-radius: var(--radius-sm); border: 1px solid #e2e8f0; flex: 1; justify-content: center; }
        .feature-item i { color: var(--primary); }
        .quick-actions-btns { display: flex; flex-direction: column; gap: 12px; }
        .card-footer-info { font-size: 11px; color: #94a3b8; text-align: center; font-weight: 600; margin-top: 2px; }

        /* Sections */
        .services, .doctors, .appointment, .track-section { padding: 80px 0; }
        .section-header { margin-bottom: 50px; text-align: center; }
        .section-badge { color: var(--primary); background-color: var(--primary-light); padding: 6px 14px; border-radius: var(--radius-full); font-size: 13px; font-weight: 700; display: inline-block; margin-bottom: 12px; text-transform: uppercase; }
        .section-title { font-size: 34px; margin-bottom: 12px; }
        .section-subtitle { font-size: 16px; color: var(--dark-muted); max-width: 650px; margin: 0 auto; }

        /* Services */
        .services-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(340px, 1fr)); gap: 30px; }
        .service-card { background-color: #ffffff; padding: 36px; border-radius: var(--radius-md); border: 1px solid var(--border-color); box-shadow: var(--shadow-sm); transition: var(--transition); display: flex; flex-direction: column; }
        .service-card:hover { transform: translateY(-8px); box-shadow: var(--shadow-hover); border-color: var(--primary); }
        .service-icon { width: 60px; height: 60px; border-radius: var(--radius-md); display: flex; align-items: center; justify-content: center; font-size: 28px; margin-bottom: 22px; }
        .icon-blue { background-color: #e0f2fe; color: var(--primary); }
        .icon-purple { background-color: #f3e8ff; color: #9333ea; }
        .icon-red { background-color: #ffe4e6; color: #e11d48; }
        .icon-teal { background-color: #ccfbf1; color: var(--secondary); }
        .icon-orange { background-color: #ffedd5; color: #ea580c; }
        .icon-green { background-color: #d1fae5; color: var(--success); }
        .service-card h3 { font-size: 20px; margin-bottom: 12px; }
        .service-card p { font-size: 14px; margin-bottom: 24px; flex-grow: 1; }
        .card-link { font-weight: 700; color: var(--primary); font-size: 14px; display: inline-flex; align-items: center; gap: 6px; }
        .highlight-card { border: 2px solid #fecdd3; background: linear-gradient(180deg, #ffffff 0%, #fff1f2 100%); position: relative; }
        .urgent-tag { position: absolute; top: 20px; right: 20px; background-color: var(--danger); color: #ffffff; padding: 4px 10px; border-radius: var(--radius-full); font-size: 11px; font-weight: 800; }

        /* Doctors */
        .doctors { background-color: #ffffff; }
        .doctors-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap: 30px; }
        .doctor-card { background-color: var(--light-bg); padding: 32px; border-radius: var(--radius-md); border: 1px solid var(--border-color); text-align: center; transition: var(--transition); }
        .doctor-card:hover { transform: translateY(-6px); box-shadow: var(--shadow-md); background-color: #ffffff; border-color: var(--primary); }
        .doctor-avatar { width: 90px; height: 90px; margin: 0 auto 20px auto; background: linear-gradient(135deg, #e0f2fe, #ccfbf1); border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 40px; color: var(--primary); position: relative; }
        .badge-status { position: absolute; bottom: -6px; background-color: #ffffff; padding: 3px 10px; border-radius: var(--radius-full); font-size: 11px; font-weight: 700; box-shadow: var(--shadow-sm); border: 1px solid var(--border-color); }
        .badge-status.online { color: var(--success); }
        .doctor-card h3 { font-size: 20px; margin-bottom: 6px; }
        .doctor-spec { color: var(--primary); font-weight: 700; font-size: 14px; margin-bottom: 6px; }
        .doctor-exp { font-size: 13px; color: var(--dark-muted); margin-bottom: 16px; }
        .doctor-meta { background-color: #ffffff; padding: 10px; border-radius: var(--radius-sm); font-size: 13px; color: var(--dark-muted); border: 1px dashed var(--border-color); }

        /* Appointment Form */
        .appointment { background-color: var(--light-bg); }
        .appointment-card { background-color: #ffffff; padding: 48px; border-radius: var(--radius-lg); box-shadow: var(--shadow-md); max-width: 900px; margin: 0 auto; border: 1px solid var(--border-color); }
        .form-grid-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .form-grid-3 { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 20px; }
        .input-group { margin-bottom: 20px; display: flex; flex-direction: column; gap: 8px; }
        .input-group label { font-size: 14px; font-weight: 700; color: var(--dark); display: flex; align-items: center; gap: 8px; }
        .input-group input, .input-group select { padding: 14px 16px; border-radius: var(--radius-sm); border: 1.5px solid var(--border-color); font-size: 15px; color: var(--dark); background-color: #ffffff; outline: none; transition: var(--transition); font-family: var(--font-body); }
        .input-group input:focus, .input-group select:focus { border-color: var(--primary); box-shadow: 0 0 0 4px var(--primary-light); }
        .margin-top-10 { margin-top: 10px; }
        .alert-banner-success { background-color: #d1fae5; color: #065f46; padding: 16px; border-radius: var(--radius-md); margin-bottom: 24px; text-align: center; font-weight: 700; font-size: 16px; border: 1px solid #a7f3d0; }

        /* Track Appointment */
        .track-section { background: linear-gradient(180deg, #ffffff 0%, #f0f9ff 100%); }
        .track-card { background: #ffffff; padding: 40px; border-radius: var(--radius-lg); box-shadow: var(--shadow-lg); max-width: 850px; margin: 0 auto; border: 2px solid #bae6fd; }
        .track-input-box { display: flex; gap: 12px; margin-top: 20px; }
        .track-input-box input { flex: 1; padding: 16px 20px; border: 2px solid var(--border-color); border-radius: var(--radius-md); font-size: 16px; outline: none; transition: var(--transition); font-family: var(--font-body); }
        .track-input-box input:focus { border-color: var(--primary); box-shadow: 0 0 0 4px var(--primary-light); }
        .track-hint { font-size: 13px; color: #64748b; margin-top: 12px; display: flex; align-items: center; justify-content: center; gap: 8px; }

        /* Footer */
        .footer { background-color: #0b1329; color: #ffffff; padding: 70px 0 0 0; }
        .footer-grid { display: grid; grid-template-columns: 1.5fr 1fr 1.2fr; gap: 40px; padding-bottom: 50px; }
        .footer-col h3 { color: #ffffff; font-size: 18px; margin-bottom: 20px; }
        .footer-desc { color: #94a3b8; font-size: 14px; line-height: 1.7; margin-top: 16px; }
        .footer-links { list-style: none; }
        .footer-links li { margin-bottom: 12px; }
        .footer-links a { color: #94a3b8; font-size: 14px; display: flex; align-items: center; gap: 8px; }
        .footer-links a:hover { color: #38bdf8; transform: translateX(4px); }
        .footer-col p { color: #94a3b8; font-size: 14px; margin-bottom: 12px; display: flex; align-items: flex-start; gap: 10px; }
        .footer-col p i { color: #38bdf8; margin-top: 4px; }
        .copyright { background-color: #020617; border-top: 1px solid #1e293b; padding: 20px 0; font-size: 14px; color: #64748b; }
        .copyright-flex { display: flex; justify-content: space-between; align-items: center; }
        .footer-sublinks a { color: #94a3b8; margin: 0 6px; }
        .footer-sublinks a:hover { color: #38bdf8; }

        /* Responsive */
        @media (max-width: 992px) {
            .hero-box { grid-template-columns: 1fr; }
            .footer-grid { grid-template-columns: 1fr 1fr; }
        }
        @media (max-width: 768px) {
            .form-grid-2, .form-grid-3 { grid-template-columns: 1fr; }
            .stats-bar { flex-direction: column; gap: 16px; }
            .stat-divider { width: 100%; height: 1px; }
            .footer-grid { grid-template-columns: 1fr; }
            .track-input-box { flex-direction: column; }
            .hero-text h1 { font-size: 30px; }
            .hero-buttons { flex-direction: column; }
        }
    </style>
</head>
<body>

    <!-- Header Navigation -->
    <header class="header">
        <div class="container nav-box">
            <a href="index.jsp" class="logo">
                <div class="logo-icon"><i class="fa-solid fa-hospital"></i></div>
                <div class="logo-text">
                    <span class="brand-name">CityCare</span>
                    <span class="brand-sub">Super Specialty Hospital</span>
                </div>
            </a>
            <nav class="nav-links">
                <a href="#home" class="nav-item active"><i class="fa-solid fa-house"></i> Home</a>
                <a href="#services" class="nav-item"><i class="fa-solid fa-stethoscope"></i> Services</a>
                <a href="#doctors" class="nav-item"><i class="fa-solid fa-user-doctor"></i> Doctors</a>
                <a href="#appointment" class="nav-item"><i class="fa-solid fa-calendar-check"></i> Book Visit</a>
                <a href="#track" class="nav-item" style="color: var(--secondary);"><i class="fa-solid fa-magnifying-glass"></i> Track Status</a>
                <a href="login.jsp" class="nav-item" style="color: var(--primary);"><i class="fa-solid fa-user-shield"></i> Staff Portal</a>
            </nav>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero" id="home">
        <div class="container hero-box">
            <div class="hero-text">
                <div class="badge-tag">
                    <i class="fa-solid fa-shield-halved"></i> 24/7 Advanced Emergency &amp; Clinical Excellence
                </div>
                <h1>Modern Healthcare For Your Entire Family</h1>
                <p>Providing state-of-the-art medical services, specialized clinical treatments, and seamless digital patient-staff management with compassion and care.</p>

                <div class="hero-buttons">
                    <a href="#appointment" class="btn btn-primary btn-lg">
                        <i class="fa-solid fa-calendar-plus"></i> Book Appointment
                    </a>
                    <a href="login.jsp" class="btn btn-secondary btn-lg">
                        <i class="fa-solid fa-user-shield"></i> Staff Portal
                    </a>
                </div>

                <div class="stats-bar">
                    <div class="stat-item">
                        <span class="stat-number">50+</span>
                        <span class="stat-label">Expert Doctors</span>
                    </div>
                    <div class="stat-divider"></div>
                    <div class="stat-item">
                        <span class="stat-number">15,000+</span>
                        <span class="stat-label">Happy Patients</span>
                    </div>
                    <div class="stat-divider"></div>
                    <div class="stat-item">
                        <span class="stat-number">24/7</span>
                        <span class="stat-label">ICU &amp; Emergency</span>
                    </div>
                    <div class="stat-divider"></div>
                    <div class="stat-item">
                        <span class="stat-number">99.2%</span>
                        <span class="stat-label">Care Satisfaction</span>
                    </div>
                </div>
            </div>

            <!-- Quick Staff Access Card -->
            <div class="hero-card">
                <div class="card-header">
                    <div class="card-title">
                        <div class="card-title-icon"><i class="fa-solid fa-id-badge"></i></div>
                        <div>
                            <span class="card-main-title">Staff Quick Access</span>
                            <span class="card-subtitle-inline">Doctors, Nurses &amp; Administrative Portal</span>
                        </div>
                    </div>
                    <span class="badge-green"><i class="fa-solid fa-circle status-dot"></i> Online System</span>
                </div>
                <div class="staff-card-body">
                    <div class="staff-features-list">
                        <span class="feature-item"><i class="fa-solid fa-shield-halved"></i> Secure Portal</span>
                        <span class="feature-item"><i class="fa-solid fa-clock-rotate-left"></i> 24/7 Access</span>
                    </div>
                    <div class="quick-actions-btns">
                        <a href="login.jsp" class="btn btn-primary btn-full">
                            <i class="fa-solid fa-right-to-bracket"></i> Staff Login
                        </a>
                    </div>
                    <div class="card-footer-info">
                        <i class="fa-solid fa-lock"></i> Authorized Personnel Access Only
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Medical Services Section -->
    <section class="services" id="services">
        <div class="container">
            <div class="section-header">
                <span class="section-badge">Medical Care</span>
                <h2 class="section-title">Our Specialty Departments</h2>
                <p class="section-subtitle">World-class treatments powered by modern medical technology and experienced specialists.</p>
            </div>
            <div class="services-grid">
                <div class="service-card">
                    <div class="service-icon icon-blue"><i class="fa-solid fa-heart-pulse"></i></div>
                    <h3>Cardiology &amp; Heart Care</h3>
                    <p>Advanced cardiac diagnostics, Angioplasty, ECG, Blood pressure management, and preventative heart care.</p>
                    <a href="#appointment" class="card-link">Book Cardiology Visit <i class="fa-solid fa-arrow-right"></i></a>
                </div>
                <div class="service-card">
                    <div class="service-icon icon-purple"><i class="fa-solid fa-brain"></i></div>
                    <h3>Neurology &amp; Brain Center</h3>
                    <p>Expert diagnosis and therapy for neurological disorders, brain health checkups, and migraine management.</p>
                    <a href="#appointment" class="card-link">Book Neurology Visit <i class="fa-solid fa-arrow-right"></i></a>
                </div>
                <div class="service-card highlight-card">
                    <div class="service-icon icon-red"><i class="fa-solid fa-truck-medical"></i></div>
                    <div class="urgent-tag">24x7 Ready</div>
                    <h3>Emergency &amp; Trauma Unit</h3>
                    <p>Immediate ambulance service, fully-equipped ICU units, critical care response, and emergency surgery.</p>
                    <a href="#appointment" class="card-link">Emergency Call: 102 <i class="fa-solid fa-phone"></i></a>
                </div>
                <div class="service-card">
                    <div class="service-icon icon-teal"><i class="fa-solid fa-baby"></i></div>
                    <h3>Pediatrics &amp; Child Care</h3>
                    <p>Comprehensive healthcare for infants and children, pediatric checkups, and vaccination schedules.</p>
                    <a href="#appointment" class="card-link">Book Pediatrics Visit <i class="fa-solid fa-arrow-right"></i></a>
                </div>
                <div class="service-card">
                    <div class="service-icon icon-orange"><i class="fa-solid fa-bone"></i></div>
                    <h3>Orthopedics &amp; Joint Care</h3>
                    <p>Bone fracture management, joint replacement procedures, arthritis care, and physiotherapy support.</p>
                    <a href="#appointment" class="card-link">Book Orthopedics Visit <i class="fa-solid fa-arrow-right"></i></a>
                </div>
                <div class="service-card">
                    <div class="service-icon icon-green"><i class="fa-solid fa-flask-vial"></i></div>
                    <h3>Diagnostic Pathology &amp; Imaging</h3>
                    <p>High-precision pathology lab tests, Digital X-Ray, CT Scan, Ultrasound, and instant digital reports.</p>
                    <a href="#appointment" class="card-link">Schedule Lab Test <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </div>
    </section>

    <!-- Doctors Section -->
    <section class="doctors" id="doctors">
        <div class="container">
            <div class="section-header">
                <span class="section-badge">Medical Team</span>
                <h2 class="section-title">Meet Our Senior Specialists</h2>
                <p class="section-subtitle">Dedicated, certified doctors committed to providing compassionate patient care.</p>
            </div>
            <div class="doctors-grid">
                <div class="doctor-card">
                    <div class="doctor-avatar">
                        <i class="fa-solid fa-user-doctor"></i>
                        <span class="badge-status online"><i class="fa-solid fa-circle"></i> Available Today</span>
                    </div>
                    <h3>Dr. Rajesh Sharma</h3>
                    <p class="doctor-spec">Senior Cardiologist (MD, DM)</p>
                    <p class="doctor-exp"><i class="fa-solid fa-award"></i> 16+ Years Experience</p>
                    <div class="doctor-meta"><span><i class="fa-solid fa-clock"></i> Mon - Sat (9 AM - 4 PM)</span></div>
                </div>
                <div class="doctor-card">
                    <div class="doctor-avatar">
                        <i class="fa-solid fa-user-doctor"></i>
                        <span class="badge-status online"><i class="fa-solid fa-circle"></i> Available Today</span>
                    </div>
                    <h3>Dr. Ananya Verma</h3>
                    <p class="doctor-spec">Chief Neurologist (MD, DNB)</p>
                    <p class="doctor-exp"><i class="fa-solid fa-award"></i> 14+ Years Experience</p>
                    <div class="doctor-meta"><span><i class="fa-solid fa-clock"></i> Mon - Fri (10 AM - 5 PM)</span></div>
                </div>
                <div class="doctor-card">
                    <div class="doctor-avatar">
                        <i class="fa-solid fa-user-doctor"></i>
                        <span class="badge-status online"><i class="fa-solid fa-circle"></i> Available Today</span>
                    </div>
                    <h3>Dr. Amit Kumar</h3>
                    <p class="doctor-spec">Orthopedic Surgeon (MS Ortho)</p>
                    <p class="doctor-exp"><i class="fa-solid fa-award"></i> 11+ Years Experience</p>
                    <div class="doctor-meta"><span><i class="fa-solid fa-clock"></i> Tue - Sun (11 AM - 6 PM)</span></div>
                </div>
            </div>
        </div>
    </section>

    <!-- Appointment Booking Section -->
    <section class="appointment" id="appointment">
        <div class="container">
            <div class="appointment-card">
                <div class="section-header" style="margin-bottom: 30px;">
                    <span class="section-badge">Easy Booking</span>
                    <h2 class="section-title">Book Patient Appointment</h2>
                    <p class="section-subtitle">Schedule your OPD consultation or health checkup online instantly.</p>
                </div>

                <%
                    String msg = request.getParameter("msg");
                    String appt = request.getParameter("appt");
                    if ("booked".equals(msg)) {
                %>
                <div class="alert-banner-success">
                    <i class="fa-solid fa-circle-check"></i> Appointment Booked Successfully! Your Appointment No is: <strong><%= appt %></strong>
                </div>
                <% } %>

                <form action="Appointment_Servlet" method="POST">
                    <div class="form-grid-2">
                        <div class="input-group">
                            <label for="patientName"><i class="fa-solid fa-user"></i> Patient Full Name</label>
                            <input type="text" id="patientName" name="patient_name" placeholder="Enter patient name" required>
                        </div>
                        <div class="input-group">
                            <label for="patientPhone"><i class="fa-solid fa-phone"></i> Mobile Phone Number</label>
                            <input type="tel" id="patientPhone" name="patient_phone" placeholder="Enter 10-digit phone number" required pattern="[0-9]{10}">
                        </div>
                    </div>
                    <div class="form-grid-3">
                        <div class="input-group">
                            <label for="appointDept"><i class="fa-solid fa-stethoscope"></i> Department</label>
                            <select id="appointDept" name="department_id" required>
                                <option value="">Choose Department</option>
                                <option value="1">Cardiology &amp; Heart Care</option>
                                <option value="2">Neurology &amp; Brain Center</option>
                                <option value="3">Orthopedics &amp; Joint Care</option>
                                <option value="4">Pediatrics &amp; Child Care</option>
                                <option value="7">General Medicine</option>
                            </select>
                        </div>
                        <div class="input-group">
                            <label for="appointDoctor"><i class="fa-solid fa-user-doctor"></i> Preferred Doctor</label>
                            <select id="appointDoctor" name="doctor_id" required>
                                <option value="">Select Doctor</option>
                                <option value="1">Dr. Rajesh Sharma (Cardiologist)</option>
                                <option value="2">Dr. Ananya Verma (Neurologist)</option>
                                <option value="3">Dr. Amit Kumar (Orthopedic)</option>
                            </select>
                        </div>
                        <div class="input-group">
                            <label for="appointDate"><i class="fa-solid fa-calendar-day"></i> Appointment Date</label>
                            <input type="date" id="appointDate" name="appointment_date" required>
                        </div>
                    </div>
                    <div class="input-group">
                        <label for="patientSymptoms"><i class="fa-solid fa-notes-medical"></i> Health Symptoms / Remarks (Optional)</label>
                        <input type="text" id="patientSymptoms" name="symptoms" placeholder="Briefly describe health concern (e.g. Chest discomfort, fever)">
                    </div>
                    <button type="submit" class="btn btn-primary btn-lg btn-full margin-top-10">
                        <i class="fa-solid fa-circle-check"></i> Confirm Patient Appointment
                    </button>
                </form>
            </div>
        </div>
    </section>

    <!-- Track Appointment Section -->
    <section class="track-section" id="track">
        <div class="container">
            <div class="track-card">
                <div class="section-header" style="margin-bottom: 20px;">
                    <span class="section-badge" style="background-color: #ccfbf1; color: var(--secondary);">Patient Self-Service</span>
                    <h2 class="section-title">Track Your Appointment</h2>
                    <p class="section-subtitle">Check your booking confirmation, assigned doctor, appointment date, and current status.</p>
                </div>

                <form action="CheckStatus_Servlet" method="GET">
                    <div class="track-input-box">
                        <input type="text" name="search_query" id="searchQuery"
                               placeholder="Enter Mobile Number (e.g. 9876543210) or Appointment No (e.g. APT-2026-0001)"
                               required>
                        <button type="submit" class="btn btn-secondary btn-lg">
                            <i class="fa-solid fa-magnifying-glass"></i> Check Status
                        </button>
                    </div>
                </form>

                <div class="track-hint">
                    <i class="fa-solid fa-circle-info"></i>
                    Enter the same 10-digit mobile number you used while booking your appointment.
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer" id="contact">
        <div class="container footer-grid">
            <div class="footer-col">
                <div class="logo">
                    <div class="logo-icon"><i class="fa-solid fa-hospital"></i></div>
                    <div class="logo-text">
                        <span class="brand-name" style="color: #fff;">CityCare</span>
                        <span class="brand-sub">Super Specialty Hospital</span>
                    </div>
                </div>
                <p class="footer-desc">Providing high quality, affordable healthcare and advanced medical diagnostics for over 15 years.</p>
            </div>

            <div class="footer-col">
                <h3>Quick Navigation</h3>
                <ul class="footer-links">
                    <li><a href="#home"><i class="fa-solid fa-chevron-right"></i> Home Page</a></li>
                    <li><a href="#services"><i class="fa-solid fa-chevron-right"></i> Medical Services</a></li>
                    <li><a href="#doctors"><i class="fa-solid fa-chevron-right"></i> Specialist Doctors</a></li>
                    <li><a href="#appointment"><i class="fa-solid fa-chevron-right"></i> Book Visit</a></li>
                    <li><a href="#track"><i class="fa-solid fa-chevron-right"></i> Track Appointment</a></li>
                    <li><a href="login.jsp"><i class="fa-solid fa-chevron-right"></i> Staff Login</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h3>Hospital Location</h3>
                <p><i class="fa-solid fa-location-dot"></i> 123 Main Medical Highway, Healthcare Zone, New Delhi</p>
                <p><i class="fa-solid fa-phone"></i> +91 98765 43210 / 011-23456789</p>
                <p><i class="fa-solid fa-envelope"></i> contact@citycarehospital.com</p>
                <p><i class="fa-solid fa-clock"></i> OPD Hours: 8:00 AM - 8:00 PM</p>
            </div>
        </div>

        <div class="copyright">
            <div class="container copyright-flex">
                <p>&copy; 2026 CityCare Hospital. Dynamic Web Application (JSP + Servlet + MySQL).</p>
                <div class="footer-sublinks">
                    <a href="login.jsp">Staff Login</a>
                </div>
            </div>
        </div>
    </footer>

</body>
</html>