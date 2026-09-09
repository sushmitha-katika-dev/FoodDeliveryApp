<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - FoodZone</title>
  <link type="image/png" rel="icon" href="images/food app header logo.png">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
	
    body {
      background: linear-gradient(135deg, #ffefe8 0%, #fff2ec 50%, #f4f6f8 100%);
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      padding: 20px;
    }

    .brand-header {
      margin-bottom: 20px;
      text-align: center;
    }

    .brand-header a {
      font-size: 28px;
      font-weight: 800;
      color: #ff6f61;
      text-decoration: none;
    }
	
    .login-container {
      background: #fff;
      padding: 35px 30px;
      border-radius: 18px;
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
      width: 100%;
      max-width: 440px;
      border: 1px solid #eee;
    }

    .role-tabs {
      display: flex;
      background: #f1f5f9;
      border-radius: 12px;
      padding: 4px;
      margin-bottom: 22px;
      gap: 4px;
    }

    .role-tab {
      flex: 1;
      padding: 10px;
      text-align: center;
      font-size: 13.5px;
      font-weight: 700;
      color: #64748b;
      border-radius: 9px;
      cursor: pointer;
      transition: all 0.2s ease;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 6px;
    }

    .role-tab.active {
      background: white;
      color: #ff6f61;
      box-shadow: 0 2px 8px rgba(0,0,0,0.06);
    }

    .login-container h2 {
      margin-bottom: 6px;
      font-size: 24px;
      color: #222;
      text-align: center;
    }

    .login-subtitle {
      font-size: 13.5px;
      color: #666;
      text-align: center;
      margin-bottom: 20px;
    }

    .login-container label {
      display: block;
      text-align: left;
      margin-bottom: 6px;
      font-weight: 600;
      font-size: 13.5px;
      color: #444;
    }

    .login-container input {
      width: 100%;
      padding: 12px 14px;
      margin-bottom: 18px;
      border: 1px solid #ddd;
      border-radius: 10px;
      font-size: 14px;
      transition: border-color 0.2s;
    }

    .login-container input:focus {
      border-color: #ff6f61;
      outline: none;
      box-shadow: 0 0 0 3px rgba(255,111,97,0.15);
    }

    .login-btn {
      width: 100%;
      padding: 14px;
      background-color: #ff6f61;
      color: #fff;
      font-size: 16px;
      font-weight: bold;
      border: none;
      border-radius: 12px;
      cursor: pointer;
      transition: background-color 0.2s ease;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
    }

    .login-btn:hover {
      background-color: #e65b50;
    }

    .register-link {
      margin-top: 20px;
      font-size: 14px;
      color: #555;
      text-align: center;
    }

    .register-link a {
      color: #ff6f61;
      text-decoration: none;
      font-weight: bold;
      margin-left: 4px;
    }

    .register-link a:hover {
      text-decoration: underline;
    }

    .error-message {
      background-color: #ffebee;
      border: 1px solid #ffcdd2;
      color: #c62828;
      padding: 10px 14px;
      border-radius: 10px;
      margin-bottom: 18px;
      font-size: 13.5px;
      text-align: center;
    }

    .success-message {
      background-color: #e8f5e9;
      border: 1px solid #c8e6c9;
      color: #2e7d32;
      padding: 10px 14px;
      border-radius: 10px;
      margin-bottom: 18px;
      font-size: 13.5px;
      text-align: center;
    }

    .demo-box {
      background: #fafafa;
      border: 1px dashed #ffd8cc;
      border-radius: 10px;
      padding: 14px;
      margin-top: 22px;
      text-align: center;
    }

    .demo-title {
      font-size: 12px;
      font-weight: 700;
      color: #ff6f61;
      text-transform: uppercase;
      margin-bottom: 8px;
    }

    .demo-btn {
      background: white;
      border: 1px solid #ffd1cb;
      color: #333;
      padding: 7px 12px;
      border-radius: 14px;
      font-size: 12px;
      font-weight: 600;
      cursor: pointer;
      display: inline-block;
      margin: 3px;
      transition: 0.2s;
    }

    .demo-btn:hover {
      background: #ffefe8;
      color: #ff6f61;
    }
  </style>
  <script>
    function switchRole(role) {
      const custTab = document.getElementById('custTab');
      const adminTab = document.getElementById('adminTab');
      const title = document.getElementById('loginTitle');
      const subtitle = document.getElementById('loginSubtitle');
      const regLink = document.getElementById('regLinkSection');

      if (role === 'admin') {
        adminTab.classList.add('active');
        custTab.classList.remove('active');
        title.innerText = 'Admin & Merchant Portal';
        subtitle.innerText = 'Sign in to manage kitchen orders & operations';
        regLink.style.display = 'none';
        fillDemo('admin@foodzone.com', 'admin123');
      } else {
        custTab.classList.add('active');
        adminTab.classList.remove('active');
        title.innerText = 'Welcome Back!';
        subtitle.innerText = 'Ready to feast on your favorite food?';
        regLink.style.display = 'block';
        fillDemo('katikasushmitha7228@gmail.com', 'Sushmitha@06');
      }
    }

    function fillDemo(email, pass) {
      document.getElementById('email').value = email;
      document.getElementById('password').value = pass;
    }
  </script>
</head>
<body>

  <div class="brand-header">
    <a href="home">FoodZone 🍴</a>
  </div>

  <div class="login-container">
    <!-- Role Switch Tabs -->
    <div class="role-tabs">
      <div id="custTab" class="role-tab active" onclick="switchRole('customer')">
        <i class="fa-solid fa-user"></i> Customer Login
      </div>
      <div id="adminTab" class="role-tab" onclick="switchRole('admin')">
        <i class="fa-solid fa-shield-halved"></i> Admin Portal
      </div>
    </div>

    <h2 id="loginTitle">Welcome Back!</h2>
    <p class="login-subtitle" id="loginSubtitle">Ready to feast on your favorite food?</p>

    <!-- Success message on logout -->
    <% if("true".equals(request.getParameter("logout"))) { %>
      <div class="success-message">
        <i class="fa-solid fa-circle-check"></i> You have logged out successfully.
      </div>
    <% } %>

    <!-- Error message from authorization or invalid credentials -->
    <% if(request.getAttribute("error") != null) { %>
      <div class="error-message">
        <i class="fa-solid fa-triangle-exclamation"></i> <%= request.getAttribute("error") %>
      </div>
    <% } else if (request.getParameter("error") != null) { %>
      <div class="error-message">
        <i class="fa-solid fa-triangle-exclamation"></i> <%= request.getParameter("error") %>
      </div>
    <% } %>

    <form action="login" method="post">
      <label for="email"><i class="fa-solid fa-envelope"></i> Email ID</label>
      <input type="email" id="email" name="email" placeholder="e.g. john@example.com" value="katikasushmitha7228@gmail.com" required>

      <label for="password"><i class="fa-solid fa-lock"></i> Password</label>
      <input type="password" id="password" name="password" placeholder="Enter your password" value="Sushmitha@06" required>

      <button type="submit" class="login-btn">
        <i class="fa-solid fa-right-to-bracket"></i> Login
      </button>
    </form>

    <div class="demo-box">
      <div class="demo-title">⚡ Quick-Fill Demo Credentials</div>
      <button type="button" class="demo-btn" onclick="switchRole('customer'); fillDemo('katikasushmitha7228@gmail.com', 'Sushmitha@06')">👤 Sushmitha (Customer)</button>
      <button type="button" class="demo-btn" onclick="switchRole('customer'); fillDemo('john@example.com', 'password123')">👤 John (Customer)</button>
      <button type="button" class="demo-btn" onclick="switchRole('admin'); fillDemo('admin@foodzone.com', 'admin123')">👑 Admin (Operations)</button>
    </div>

    <p class="register-link" id="regLinkSection">Don't have a customer account?<a href="userregistration.jsp">Register here</a></p>
  </div>

</body>
</html>