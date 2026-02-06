<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Face Verification - Secure Voting</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #3498db;
            --accent: #e74c3c;
            --success: #2ecc71;
            --light: #ecf0f1;
            --dark: #2c3e50;
            --gradient: linear-gradient(135deg, #3498db, #2c3e50);
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        
        body {
            background: var(--gradient);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            position: relative;
        }
        
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkZWZzPjxwYXR0ZXJuIGlkPSJwYXR0ZXJuIiB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHBhdHRlcm5Vbml0cz0idXNlclNwYWNlT25Vc2UiIHBhdHRlcm5UcmFuc2Zvcm09InJvdGF0ZSg0NSkiPjxyZWN0IHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgZmlsbD0icmdiYSgyNTUsMjU1LDI1NSwwLjA1KSIvPjwvcGF0dGVybj48L2RlZnM+PHJlY3QgZmlsbD0idXJsKCNwYXR0ZXJuKSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIvPjwvc3ZnPg==');
            z-index: -1;
        }
        
        .verification-container {
            display: flex;
            width: 100%;
            max-width: 900px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: var(--shadow);
            overflow: hidden;
            min-height: 600px;
            backdrop-filter: blur(10px);
        }
        
        .info-section {
            flex: 1;
            background: var(--gradient);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
            color: white;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .info-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkZWZzPjxwYXR0ZXJuIGlkPSJwYXR0ZXJuIiB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHBhdHRlcm5Vbml0cz0idXNlclNwYWNlT25Vc2UiIHBhdHRlcm5UcmFuc2Zvcm09InJvdGF0ZSg0NSkiPjxyZWN0IHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgZmlsbD0icmdiYSgyNTUsMjU1LDI1NSwwLjA1KSIvPjwvcGF0dGVybj48L2RlZnM+PHJlY3QgZmlsbD0idXJsKCNwYXR0ZXJuKSIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIvPjwvc3ZnPg==');
        }
        
        .info-content {
            z-index: 1;
            max-width: 400px;
        }
        
        .security-icon {
            font-size: 4rem;
            margin-bottom: 30px;
            color: rgba(255, 255, 255, 0.9);
        }
        
        .info-section h2 {
            font-size: 2rem;
            margin-bottom: 20px;
            font-weight: 600;
        }
        
        .info-section p {
            font-size: 1.1rem;
            opacity: 0.9;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        
        .features-list {
            list-style: none;
            text-align: left;
            margin-top: 20px;
        }
        
        .features-list li {
            margin-bottom: 15px;
            display: flex;
            align-items: flex-start;
            font-size: 0.95rem;
        }
        
        .features-list i {
            color: var(--light);
            margin-right: 10px;
            margin-top: 3px;
            font-size: 1.1rem;
        }
        
        .camera-section {
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        
        .section-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .section-header h1 {
            color: var(--primary);
            font-size: 2rem;
            margin-bottom: 10px;
            position: relative;
            padding-bottom: 15px;
        }
        
        .section-header h1:after {
            content: '';
            position: absolute;
            width: 60px;
            height: 4px;
            background: var(--secondary);
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 2px;
        }
        
        .section-header p {
            color: #666;
            font-size: 1rem;
        }
        
        .camera-container {
            position: relative;
            margin-bottom: 30px;
        }
        
        video, canvas, img {
            width: 100%;
            max-width: 400px;
            height: 300px;
            border: 3px solid #e1e5ee;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            object-fit: cover;
            transition: var(--transition);
        }
        
        video:hover, img:hover {
            border-color: var(--secondary);
            transform: translateY(-2px);
        }
        
        #preview {
            display: none;
            border-color: var(--success);
        }
        
        .camera-overlay {
            position: absolute;
            top: 10px;
            left: 10px;
            right: 10px;
            bottom: 10px;
            border: 2px dashed rgba(255, 255, 255, 0.5);
            border-radius: 10px;
            pointer-events: none;
        }
        
        .btn-group {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            justify-content: center;
            margin-bottom: 20px;
        }
        
        .btn {
            padding: 15px 25px;
            font-size: 1rem;
            font-weight: 600;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            min-width: 160px;
            justify-content: center;
        }
        
        .btn-capture {
            background: var(--secondary);
            color: white;
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
        }
        
        .btn-capture:hover {
            background: #2980b9;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(52, 152, 219, 0.6);
        }
        
        .btn-submit {
            background: var(--success);
            color: white;
            box-shadow: 0 5px 15px rgba(46, 204, 113, 0.4);
        }
        
        .btn-submit:hover {
            background: #27ae60;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(46, 204, 113, 0.6);
        }
        
        .btn-recapture {
            background: var(--accent);
            color: white;
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.4);
            display: none;
        }
        
        .btn-recapture:hover {
            background: #c0392b;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(231, 76, 60, 0.6);
        }
        
        #snapshot {
            display: none;
        }
        
        .status-indicator {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
            padding: 15px;
            border-radius: 10px;
            background: rgba(52, 152, 219, 0.1);
            border-left: 4px solid var(--secondary);
        }
        
        .status-indicator i {
            color: var(--secondary);
            font-size: 1.2rem;
        }
        
        .status-text {
            color: var(--primary);
            font-weight: 500;
        }
        
        .capture-animation {
            animation: captureFlash 0.5s ease;
        }
        
        @keyframes captureFlash {
            0% { opacity: 1; }
            50% { opacity: 0.3; }
            100% { opacity: 1; }
        }
        
        
        @media (max-width: 768px) {
            .verification-container {
                flex-direction: column;
            }
            
            .info-section {
                padding: 30px 20px;
            }
            
            .camera-section {
                padding: 30px 20px;
            }
            
            .btn-group {
                flex-direction: column;
                align-items: center;
            }
            
            .btn {
                width: 100%;
                max-width: 300px;
            }
        }
    </style>
</head>

<%
    String email = request.getParameter("id");
%>

<body>
    <div class="verification-container">
        
        <div class="info-section">
            <div class="info-content">
                <div class="security-icon">
                    <i class="fas fa-face-recognition"></i>
                </div>
                <h2>Identity Verification</h2>
                <p>Verify your identity using facial recognition to ensure secure voting access.</p>
                
                <ul class="features-list">
                    <li>
                        <i class="fas fa-shield-alt"></i>
                        <span>Enhanced security with biometric verification</span>
                    </li>
                    <li>
                        <i class="fas fa-user-check"></i>
                        <span>One-time verification for voting session</span>
                    </li>
                    <li>
                        <i class="fas fa-lock"></i>
                        <span>Encrypted facial data processing</span>
                    </li>
                    <li>
                        <i class="fas fa-bolt"></i>
                        <span>Quick and seamless verification process</span>
                    </li>
                </ul>
            </div>
        </div>
        
       
        <div class="camera-section">
            <div class="section-header">
                <h1>Face Verification</h1>
                <p>Position your face clearly in the camera frame</p>
            </div>
            
            <div class="camera-container">
                
                <video id="camera" autoplay></video>
                <div class="camera-overlay"></div>
                
                
                <img id="preview" alt="Captured Image Preview">
                
                
                <canvas id="snapshot"></canvas>
            </div>
            
            <div class="status-indicator">
                <i class="fas fa-camera"></i>
                <span class="status-text" id="statusText">Camera ready - Position your face</span>
            </div>
            
            <div class="btn-group">
               
                <button class="btn btn-capture" onclick="capturePhoto()">
                    <i class="fas fa-camera"></i>
                    Capture Face
                </button>
                
                
                <button class="btn btn-recapture" onclick="recapturePhoto()">
                    <i class="fas fa-redo"></i>
                    Recapture
                </button>
            </div>
            
           
            <form id="verifyForm" action="face" method="post">
                <input type="hidden" name="email" value="<%= email %>">
                <input type="hidden" name="capturedImage" id="capturedImage">
                <button type="submit" class="btn btn-submit">
                    <i class="fas fa-paper-plane"></i>
                    Submit for Verification
                </button>
            </form>
        </div>
    </div>

    <script>
        const video = document.getElementById("camera");
        const statusText = document.getElementById("statusText");
        const preview = document.getElementById("preview");
        const recaptureBtn = document.querySelector('.btn-recapture');
        const captureBtn = document.querySelector('.btn-capture');

        function startCamera() {
            navigator.mediaDevices.getUserMedia({
                video: {
                    width: { ideal: 1280 },
                    height: { ideal: 720 },
                    facingMode: "user"
                }
            })
            .then(stream => {
                video.srcObject = stream;
                statusText.innerHTML = '<i class="fas fa-check-circle"></i> Camera active - Ready for capture';
            })
            .catch(err => {
                console.error("Camera error:", err);
                statusText.innerHTML = '<i class="fas fa-exclamation-triangle"></i> Camera access denied';
                alert("Please allow camera access.");
            });
        }

        startCamera();

        function capturePhoto() {
            const canvas = document.getElementById("snapshot");
            const context = canvas.getContext("2d");

            canvas.width = video.videoWidth;
            canvas.height = video.videoHeight;
            context.drawImage(video, 0, 0, canvas.width, canvas.height);

            const base64Image = canvas.toDataURL("image/png");
            document.getElementById("capturedImage").value = base64Image;

            preview.src = base64Image;
            preview.style.display = "block";
            video.style.display = "none";

            recaptureBtn.style.display = "flex";
            captureBtn.style.display = "none";

            statusText.innerHTML = '<i class="fas fa-check-circle"></i> Photo captured successfully';

            const tracks = video.srcObject.getTracks();
            tracks.forEach(track => track.stop());
        }

        function recapturePhoto() {
            preview.style.display = "none";
            video.style.display = "block";

            captureBtn.style.display = "flex";
            recaptureBtn.style.display = "none";

            statusText.innerHTML = '<i class="fas fa-camera"></i> Camera ready - Position your face';
            startCamera();
        }

        document.getElementById('verifyForm').addEventListener('submit', function(e) {
            const capturedImage = document.getElementById('capturedImage').value;
            if (!capturedImage) {
                e.preventDefault();
                alert('Please capture your face first');
                return;
            }

            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Verifying...';
            submitBtn.disabled = true;
        });
    </script>
</body>
</html>