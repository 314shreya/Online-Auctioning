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
<div class= "cont_div">
	<div class="forms_div">
            <div class="form signup">
                <span class="title">Registration</span>

                <form method = "post" action="register">
                    <div class="input_tag">
                        <input type="text" name= "name" placeholder="Enter your name" required>
                        <i class="uil uil-user"></i>
                    </div>
                    <div class="input_tag">
                        <input type="text" name= "email" id= "email" onkeyup=' emailcheck();verify();'placeholder="Enter your email" required>
                        <i class="uil uil-envelope icon"></i>
                    </div>
                    <div><span id = "msg3"></span></div>
                    <div class="input_tag">
                        <input type="text" name= "phone" id="phone" onkeyup=' phonecheck();verify();' placeholder="Enter your Phone" required>
                        <i class="uil uil-phone icon"></i>
                    </div>
                    <div><span id = "msg2"></span></div>
                    <div class="input_tag">
                        <input type="text" name= "address" placeholder="Enter your Address" required>
                        <i class="uil uil-home icon"></i>
                    </div>
                    <div class="input_tag">
                        <input type="password" class="password" onkeyup=' check1();check();verify();' name="password" id= "pwd" placeholder="Create a password" required>
                        <i class="uil uil-lock icon"></i>
						<i class="uil uil-eye-slash showHidePw" id="pwd_eye" onclick="myFunction()"></i>
                        
                    </div>
                    <div><span style="font-size: 70%; background: inherit;" id = "msg1"></span></div>
                    <div class="input_tag">
                        <input type="password" class="password" onkeyup='check();verify();' name="cpassword" id= "confirm_pwd" placeholder="Confirm a password" required>
                        <i class="uil uil-lock icon"></i>
                        
                    </div>
					<div><span id = "msg"></span></div>

                    <div>
                    	<button class="btn" type="submit" id="mybtn" >Sign Up</button>
                    </div>
                </form>

                <div class="register">
                    <span class="text">Already a member?
                        <a href="login.jsp" class="text login-link">Login Now</a>
                    </span>
                </div>
            </div>
            </div>
            </div>

    <script type="text/javascript">
	/* function myFunction() 
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
    var status = document.getElementById("status").value;
	if(status == "failed"){
		alert("User is already registered with same email");
	}
    var e_flag = false,phone_flag = false,pwd_flag = false,c_box = false;
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
    
    var phonecheck = function()
    {
    	var re = /^\d{10}$/;
    	var test = re.test(document.getElementById('phone').value);
    	if(document.getElementById('phone').value == "")
    	{
    		phone_flag = false;
    		document.getElementById('msg2').innerHTML = '';
    	}
    	else if(test == true)
    	{
    		phone_flag = true;
    		document.getElementById('msg2').innerHTML = '';
    		
    	}
    	else
    	{
    		phone_flag = false;
    		document.getElementById('msg2').innerHTML = 'Invalid Phone';
    	}
    		
    }
    
    var check1 = function() {
    	var re = /^(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).{4,}$/;
    	var test = re.test(document.getElementById('pwd').value);
    	if(test == true)
    	{
    		
    		document.getElementById('msg1').innerHTML = '';
    	}
    	else
    	{
    		
    		document.getElementById('msg1').style.color = 'red';
    		document.getElementById('msg1').innerHTML ="Password must be atleast 10 letters and should contains special characters !@#$%^&*";
    	}
    		
    	}
    var check = function() {
    	if( document.getElementById('pwd').value == document.getElementById('confirm_pwd').value &&  document.getElementById('confirm_pwd').value == "")
		  {
    		pwd_flag = false;
		  	document.getElementById('msg').innerHTML = '';
		  }
    	else if (document.getElementById('pwd').value == document.getElementById('confirm_pwd').value) {
    		pwd_flag = true;
    	    document.getElementById('msg').style.color = 'green';
    	    document.getElementById('msg').innerHTML = 'Password matching';
    	  }
    	  else {
    		  pwd_flag = false;
    	    document.getElementById('msg').style.color = 'red';
    	    document.getElementById('msg').innerHTML = 'Passoward not matching';
    	  }
    	}
    var verify = function()
    {
    	c_box = document.getElementById('termCon').checked;
    	if(!(pwd_flag &&  e_flag && phone_flag && c_box))
    	{
    		document.getElementById('mybtn').disabled = true;
    		document.getElementById('mybtn').style.background = 'red';
    	}
    	else
    	{
    		document.getElementById('mybtn').disabled = false;
    		document.getElementById('mybtn').style.background = '#4070f4';
    	}
    	
    } */
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
var status = document.getElementById("status").value;
if(status == "failed"){
	alert("User is already registered with same email");
}
var e_flag = false,phone_flag = false,pwd_flag = false;
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

var phonecheck = function()
{
	var re = /^\d{10}$/;
	var test = re.test(document.getElementById('phone').value);
	if(document.getElementById('phone').value == "")
	{
		phone_flag = false;
		document.getElementById('msg2').innerHTML = '';
	}
	else if(test == true)
	{
		phone_flag = true;
		document.getElementById('msg2').innerHTML = '';
		
	}
	else
	{
		phone_flag = false;
		document.getElementById('msg2').innerHTML = 'Invalid Phone';
	}
		
}

var check1 = function() {
	// var re = /^(?=.\d)(?=.[!@#$%^&])(?=.[a-z])(?=.*[A-Z]).{6,}$/;
	var re = /^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{6,20}$/;
	var test = re.test(document.getElementById('pwd').value);
	if(test == true)
	{
		
		document.getElementById('msg1').innerHTML = '';
	}
	else
	{
		
		document.getElementById('msg1').style.color = 'red';
		document.getElementById('msg1').innerHTML ="Password must be atleast 6 letters and should contains special characters !@#$%^&*";
	}
		
	}
var check = function() {
	if( document.getElementById('pwd').value == document.getElementById('confirm_pwd').value &&  document.getElementById('confirm_pwd').value == "")
	  {
		pwd_flag = false;
	  	document.getElementById('msg').innerHTML = '';
	  }
	else if (document.getElementById('pwd').value == document.getElementById('confirm_pwd').value) {
		pwd_flag = true;
	    document.getElementById('msg').style.color = 'green';
	    document.getElementById('msg').innerHTML = 'Password matching';
	  }
	  else {
		  pwd_flag = false;
	    document.getElementById('msg').style.color = 'red';
	    document.getElementById('msg').innerHTML = 'Passoward not matching';
	  }
	}
var verify = function()
{
	
	if(!(pwd_flag &&  e_flag && phone_flag))
	{
		document.getElementById('mybtn').disabled = true;
		document.getElementById('mybtn').style.background = 'red';
	}
	else
	{
		document.getElementById('mybtn').disabled = false;
		document.getElementById('mybtn').style.background = '#4070f4';
	}
	
}
    
    
    </script>
</body>
</html>