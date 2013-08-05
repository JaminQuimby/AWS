
<html> 
<head> 
<link rel="stylesheet" type="text/css" href="../../../AWS/assets/css/aws.css">
        <script type="text/javascript"> 
            function doLogin() { 
                // Create the Ajax proxy instance. 
                var auth = new userAuth(); 
 
                // setForm() implicitly passes the form fields to the CFC function. 
                auth.setForm("loginForm"); 
                //Call the CFC validateCredentials function. 
                if (auth.validateCredentials()) { 
                    ColdFusion.Window.hide("loginWindow"); 
                } else { 
                    var msg = document.getElementById("loginWindow_title"); 
                    msg.innerHTML = "Incorrect username/password. Please try again!"; 
                } 
            } 
        </script> 
</head> 
 
<body> 
<cfajaxproxy cfc="assets/com/userAuth" jsclassname="userAuth"> /> 
 
<cfif structKeyExists(URL,"logout") and URL.logout> 
    <cflogout /> 
</cfif> 
 
<cflogin> 
    <cfwindow name="loginWindow" center="true" closable="false" 
                draggable="false" modal="true"  
                title="Please login to use this system" 
                initshow="true" width="400" height="200"> 
        <!--- Notice that the form does not have a submit button. Submit action is performed by the doLogin function. ---> 
        <form name="loginForm" > 
        <label for="username">Username</label>
            <input type="text" name="username"/><br /> 
             <label for="Password">Password</label>    
            <input type="password" name="password" label="password" /> 
            <input type="button" name="login" value="Login!" onclick="doLogin();" /> 
        </form> 
    </cfwindow> 
</cflogin> 
 
<p> 
This page is secured by login.  
You can see the window containing the login form. 
The window is modal; so the page cannot be accessed until you log in. 
<ul> 
    <li><a href="../../OLD/module/login/login.cfm">Continue using the application</a>!</li> 
    <li><a href="../../OLD/module/login/login.cfm?logout=true">Logout</a>!</li> 
</ul> 
</p> 
</body> 
</html>


    <!--- Define a top-secret message! --->
    <cfset manCrush = "Jason Dean of 12robots.com fame." />
     
    <!---
    Generate a secret key. We are going to be using a more complex
    form of encryption; however, we can still tell the key-generator
    that we are simply using AES (Advanced Encryption Standard).
    --->
    <cfset encryptionKey = generateSecretKey( "AES" ) />
     
    <!---
    Now, let's encrypt our secret message with AES and Cypher Block
    Chaining (CBC). This CBC approach breaks the data up into blocks,
    encrypts them individually, and passes the result into the next
    block of encryption (.... I think).
    --->
    <cfset secret = encrypt(
    manCrush,
    encryptionKey,
    "AES/CBC/PKCS5Padding",
    "hex"
    ) />
     
    <!---
    Now, let's decode our secret using AES (with Cypher Block
    Chaining) and our secret key.
    --->
    <cfset decoded = decrypt(
    secret,
    encryptionKey,
    "AES/CBC/PKCS5Padding",
    "hex"
    ) />
     
     
    <cfoutput>
     
    Original: #manCrush#<br />
     
    <br />encryptionKey: #encryptionKey#  <br />
     
    Secret: #secret#<br />
     
    <br />
     
    Decoded: #decoded#<br />
     
    </cfoutput>

SALT!!!!!!!!!!!!!!!!!