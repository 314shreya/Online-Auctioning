<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- ===== Iconscout CSS ===== -->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">

    <!-- ===== CSS ===== -->
    <link rel="stylesheet" href="style.css">
         
    <!--<title>Login & Registration Form</title>-->
</head>
<body class = "body">
    <input type="hidden" id="status" value="<%= request.getAttribute("status") %>">
    <div class="div_tag">
        <div class="forms_div ">
            <div class="form login">
                <span class="title">Login</span>

                <form method = "post" action="login">
                    <div class="input_tag">
                        <input type="text" name = "email" onkeyup='emailcheck();' id= "email" placeholder="Enter your email" required>
                        <i class="uil uil-envelope icon"></i>
                    </div>
                    <div><span id = "msg3"></span></div>
                    <div class="input_tag">
                        <input type="password" class="password" id="pwd" name ="password" placeholder="Enter your password" required>
                        <i class="uil uil-lock icon"></i>
                        <i class="uil uil-eye-slash showHidePw" id="pwd_eye" onclick="myFunction()"></i>
                    </div>
                    
                    <div >

						<button class="btn" type="submit" id="signin" >Sign In</button>
									
                    </div>

                    
                </form>

                <div class="register">
                    <span class="text">Not a member?
                        <a href="registration.jsp" class="text signup-link">Sign Up Now</a>
                    </span>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
    

		var status = document.getElementById("status").value;
		if(status == "failed"){
			alert("Wrong username or password");
		}
		if(status == "success"){
			alert("User is created successfully");
		}
        if(status == "logout"){
			alert("Successfully logged out!");
		}

        function myFunction() 
        {
            var x = document.getElementById("pwd");
            if (x.type === "password") {
                x.type = "text";
                document.getElementById("pwd_eye").classList.remove('uil-eye-slash');
                document.getElementById("pwd_eye").classList.add('uil-eye');
            } else {
                x.type = "password";
                document.getElementById("pwd_eye").classList.add('uil-eye-slash');
            }
        }
        
        var emailcheck = function()
        {
        	var re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        	var test = re.test(document.getElementById('email').value);
        	if(document.getElementById('email').value == "")
        	{
        		e_flag = false;
        		document.getElementById('msg3').innerHTML = '';
        	}
        	else if(test == true)
        	{
        		e_flag = true;
        		document.getElementById('msg3').innerHTML = '';
        	}
        	else
        	{
        		e_flag = false;
        		document.getElementById('msg3').innerHTML = 'Invalid email';
        	}
        		
        }
	</script>
</body>
</html>