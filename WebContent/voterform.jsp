<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Apply for Voter ID - Secure Online Voting</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700;800&display=swap" rel="stylesheet">

<style>
/* ===== ENHANCED STYLES ===== */
:root {
    --primary-blue: #3498db;
    --dark-blue: #2c3e50;
    --accent-blue: #1abc9c;
    --light-blue: #e3f2fd;
    --gradient-bg: linear-gradient(135deg, #3498db, #2c3e50);
    --gradient-accent: linear-gradient(90deg, #1abc9c, #3498db);
    --shadow-light: 0 5px 15px rgba(52, 152, 219, 0.1);
    --shadow-medium: 0 10px 25px rgba(52, 152, 219, 0.2);
    --shadow-heavy: 0 15px 35px rgba(0, 0, 0, 0.15);
    --border-radius: 15px;
    --border-radius-lg: 20px;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Poppins', sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    padding: 20px;
    position: relative;
    overflow-x: hidden;
}

/* Background decorative elements */
body::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: 
        radial-gradient(circle at 10% 20%, rgba(52, 152, 219, 0.05) 0%, transparent 20%),
        radial-gradient(circle at 90% 80%, rgba(26, 188, 156, 0.05) 0%, transparent 20%);
    z-index: -1;
}

/* Main container with enhanced styling */
.application-container {
    background: white;
    border-radius: var(--border-radius-lg);
    width: 100%;
    max-width: 700px;
    padding: 40px 50px;
    box-shadow: var(--shadow-heavy);
    position: relative;
    overflow: hidden;
    border: 1px solid rgba(52, 152, 219, 0.1);
}

/* Header decorative strip */
.application-container::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 5px;
    background: var(--gradient-accent);
}

/* Header with improved styling */
.application-container h2 {
    text-align: center;
    color: var(--dark-blue);
    font-family: 'Montserrat', sans-serif;
    font-weight: 800;
    margin-bottom: 30px;
    font-size: 2.2rem;
    position: relative;
    padding-bottom: 15px;
}

.application-container h2::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 80px;
    height: 4px;
    background: var(--gradient-accent);
    border-radius: 2px;
}

/* Form styling */
form {
    margin-top: 10px;
}

/* Form group enhancements */
.form-group {
    margin-bottom: 25px;
    position: relative;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
    color: var(--dark-blue);
    font-size: 1rem;
    padding-left: 5px;
}

.form-group label i {
    margin-right: 8px;
    color: var(--primary-blue);
}

.form-control {
    width: 100%;
    padding: 16px 20px;
    border-radius: var(--border-radius);
    border: 2px solid #e1e5ee;
    font-size: 1rem;
    transition: all 0.3s ease;
    background-color: white;
    font-family: 'Poppins', sans-serif;
}

.form-control:focus {
    outline: none;
    border-color: var(--primary-blue);
    box-shadow: var(--shadow-light);
    background-color: var(--light-blue);
}

.readonly-field {
    background: #f8fafc;
    border-color: #d1d9e6;
    color: #5a6c7d;
    cursor: not-allowed;
}

.readonly-field:focus {
    background: #f8fafc;
    border-color: #d1d9e6;
    box-shadow: none;
}

/* Camera section styling */
.camera-box {
    text-align: center;
    border: 2px dashed var(--primary-blue);
    padding: 25px;
    border-radius: var(--border-radius);
    background-color: #f9fcff;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

.camera-box:hover {
    border-color: var(--accent-blue);
    background-color: #f0f8ff;
    transform: translateY(-2px);
    box-shadow: var(--shadow-light);
}

.camera-label {
    display: block;
    font-weight: 600;
    margin-bottom: 15px;
    color: var(--dark-blue);
    font-size: 1.1rem;
}

.camera-instruction {
    font-size: 0.9rem;
    color: #7b8a9c;
    margin-bottom: 15px;
}

video, canvas, img {
    width: 100%;
    max-height: 280px;
    border-radius: 10px;
    margin-top: 10px;
    object-fit: cover;
    border: 1px solid rgba(52, 152, 219, 0.2);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* Button styling */
.capture-btn {
    margin-top: 20px;
    padding: 12px 30px;
    background: var(--gradient-accent);
    color: white;
    border: none;
    border-radius: 50px;
    cursor: pointer;
    font-weight: 600;
    font-size: 1rem;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 4px 10px rgba(26, 188, 156, 0.3);
}

.capture-btn:hover {
    transform: translateY(-3px);
    box-shadow: 0 6px 15px rgba(26, 188, 156, 0.4);
}

.capture-btn:active {
    transform: translateY(-1px);
}

.capture-btn i {
    margin-right: 8px;
    font-size: 1.1rem;
}

/* Submit button styling */
.btn-submit {
    width: 100%;
    padding: 18px;
    border-radius: 50px;
    border: none;
    background: var(--gradient-bg);
    color: white;
    font-size: 1.2rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    margin-top: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 6px 15px rgba(52, 152, 219, 0.3);
    letter-spacing: 0.5px;
}

.btn-submit:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 20px rgba(52, 152, 219, 0.4);
    background: linear-gradient(135deg, #2980b9, #1a252f);
}

.btn-submit:active {
    transform: translateY(-1px);
}

.btn-submit i {
    margin-left: 10px;
    font-size: 1.3rem;
}

/* Status indicator */
.status-indicator {
    display: flex;
    justify-content: center;
    margin-bottom: 30px;
}

.step {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin: 0 15px;
}

.step-circle {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background-color: #e1e5ee;
    color: #7b8a9c;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 600;
    margin-bottom: 8px;
    transition: all 0.3s ease;
}

.step.active .step-circle {
    background: var(--gradient-accent);
    color: white;
    box-shadow: 0 4px 10px rgba(26, 188, 156, 0.3);
}

.step-text {
    font-size: 0.85rem;
    color: #7b8a9c;
    font-weight: 500;
}

.step.active .step-text {
    color: var(--dark-blue);
    font-weight: 600;
}

.step-connector {
    width: 40px;
    height: 2px;
    background-color: #e1e5ee;
    margin-top: 20px;
}

/* BACK BUTTON STYLES - Added without changing existing code */
.back-button-container {
    margin-bottom: 20px;
}

.back-btn {
    background: transparent;
    color: var(--dark-blue);
    border: 2px solid var(--dark-blue);
    padding: 10px 25px;
    border-radius: 50px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    font-size: 1rem;
    text-decoration: none;
}

.back-btn:hover {
    background: var(--dark-blue);
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(44, 62, 80, 0.2);
}

.back-btn i {
    margin-right: 8px;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .application-container {
        padding: 30px 25px;
    }
    
    .application-container h2 {
        font-size: 1.8rem;
    }
    
    .camera-box {
        padding: 20px;
    }
    
    .status-indicator {
        flex-wrap: wrap;
    }
    
    .step {
        margin: 5px 10px;
    }
}

@media (max-width: 480px) {
    body {
        padding: 15px;
    }
    
    .application-container {
        padding: 25px 20px;
    }
    
    .form-control {
        padding: 14px 16px;
    }
    
    .btn-submit {
        padding: 16px;
        font-size: 1.1rem;
    }
    
    .back-btn {
        padding: 8px 20px;
        font-size: 0.9rem;
    }
}

/* Animation for photo capture */
@keyframes flash {
    0% { opacity: 0; }
    50% { opacity: 1; }
    100% { opacity: 0; }
}

.camera-flash {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: white;
    opacity: 0;
    pointer-events: none;
    z-index: 10;
    border-radius: var(--border-radius);
}

/* Success message styling */
.success-message {
    background: linear-gradient(135deg, #d4edda, #c3e6cb);
    border-left: 5px solid #28a745;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
    display: none;
}

.success-message i {
    color: #28a745;
    margin-right: 10px;
}
</style>
</head>

<%
String name = session.getAttribute("studentName").toString();
String email = session.getAttribute("studentEmail").toString();
String scourse = session.getAttribute("studentcourse").toString();
%>

<body>

<div class="application-container">

    <h2><i class="fas fa-id-card"></i> Voter ID Application</h2>
    
    <!-- BACK BUTTON ADDED HERE -->
    <div class="back-button-container">
        <a href="javascript:history.back()" class="back-btn">
            <i class="fas fa-arrow-left"></i> Back
        </a>
    </div>
    
    <!-- Progress indicator -->
    <div class="status-indicator">
        <div class="step active">
            <div class="step-circle">1</div>
            <div class="step-text">Personal Info</div>
        </div>
        <div class="step-connector"></div>
        <div class="step active">
            <div class="step-circle">2</div>
            <div class="step-text">Photo Capture</div>
        </div>
        <div class="step-connector"></div>
        <div class="step">
            <div class="step-circle">3</div>
            <div class="step-text">Submit</div>
        </div>
    </div>

    <form method="post" action="voterapply" enctype="multipart/form-data" onsubmit="return validateForm()">
        
        <div class="form-group">
            <label><i class="fas fa-user"></i> Voter District</label>
            <input type="text" class="form-control readonly-field" value="<%= name %>" name="name" readonly>
        </div>
        
        <div class="form-group">
            <label><i class="fas fa-envelope"></i> Email Address</label>
            <input type="email" class="form-control readonly-field" value="<%= email %>" name="email" readonly>
        </div>
        
        <div class="form-group">
            <label><i class="fas fa-graduation-cap"></i> Student Course</label>
            <input type="text" class="form-control readonly-field" value="<%= scourse %>" name="course" readonly>
        </div>
        
        <!-- ===== ENHANCED LIVE CAMERA CAPTURE ===== -->
        <div class="form-group">
            <label class="camera-label"><i class="fas fa-camera"></i> Live Photo Capture</label>
            <div class="camera-instruction">Position your face in the frame and click "Capture Photo"</div>
            
            <div class="camera-box">
                <div class="camera-flash" id="cameraFlash"></div>
                <video id="video" autoplay></video>
                <button type="button" class="capture-btn" onclick="capturePhoto()">
                    <i class="fas fa-camera"></i> Capture Photo
                </button>
                <img id="previewImage" style="display:none;">
            </div>
            
            <!-- Hidden file input to send captured image -->
            <input type="file" name="file" id="hiddenFile" style="display:none;">
        </div>
        
        <button type="submit" class="btn-submit">
            Submit Application <i class="fas fa-paper-plane"></i>
        </button>
        
    </form>
</div>

<script>
let video = document.getElementById("video");
let previewImage = document.getElementById("previewImage");
let hiddenFile = document.getElementById("hiddenFile");
let cameraFlash = document.getElementById("cameraFlash");

// Access Camera
navigator.mediaDevices.getUserMedia({ 
    video: { 
        width: { ideal: 1280 },
        height: { ideal: 720 },
        facingMode: "user" 
    } 
})
.then(stream => {
    video.srcObject = stream;
})
.catch(err => {
    alert("Camera access denied! Please allow camera access to continue.");
    console.error("Camera error: ", err);
});

// Capture Image with enhanced feedback
function capturePhoto() {
    // Show flash animation
    cameraFlash.style.animation = "flash 0.3s";
    setTimeout(() => {
        cameraFlash.style.animation = "";
    }, 300);
    
    let canvas = document.createElement("canvas");
    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;
    let ctx = canvas.getContext("2d");
    ctx.drawImage(video, 0, 0);
    
    let dataURL = canvas.toDataURL("image/png");
    previewImage.src = dataURL;
    previewImage.style.display = "block";
    video.style.display = "none";
    
    // Update capture button
    let captureBtn = document.querySelector(".capture-btn");
    captureBtn.innerHTML = '<i class="fas fa-redo"></i> Retake Photo';
    captureBtn.style.background = "linear-gradient(90deg, #e74c3c, #c0392b)";
    
    // Update capture button onclick to allow retake
    captureBtn.onclick = function() {
        previewImage.style.display = "none";
        video.style.display = "block";
        captureBtn.innerHTML = '<i class="fas fa-camera"></i> Capture Photo';
        captureBtn.style.background = "var(--gradient-accent)";
        captureBtn.onclick = capturePhoto;
        hiddenFile.value = ""; // Clear file input
    };
    
    // Convert base64 to file
    fetch(dataURL)
    .then(res => res.blob())
    .then(blob => {
        let file = new File([blob], "voter_photo.png", { type: "image/png" });
        let dataTransfer = new DataTransfer();
        dataTransfer.items.add(file);
        hiddenFile.files = dataTransfer.files;
        
        // Show success feedback
        showMessage("Photo captured successfully!", "success");
    });
}

// Form Validation
function validateForm() {
    if (!hiddenFile.files || hiddenFile.files.length === 0) {
        showMessage("Please capture your photo before submitting.", "error");
        return false;
    }
    
    // Update progress indicator
    document.querySelectorAll(".step")[2].classList.add("active");
    return true;
}

// Show message function
function showMessage(message, type) {
    // Create message element if it doesn't exist
    let messageEl = document.querySelector(".success-message");
    if (!messageEl) {
        messageEl = document.createElement("div");
        messageEl.className = "success-message";
        document.querySelector("form").insertBefore(messageEl, document.querySelector(".btn-submit"));
    }
    
    // Set message content and style
    let icon = type === "success" ? "fas fa-check-circle" : "fas fa-exclamation-circle";
    messageEl.innerHTML = `<i class="${icon}"></i> ${message}`;
    messageEl.style.display = "block";
    
    // Hide message after 3 seconds
    setTimeout(() => {
        messageEl.style.display = "none";
    }, 3000);
}
</script>

</body>
</html>