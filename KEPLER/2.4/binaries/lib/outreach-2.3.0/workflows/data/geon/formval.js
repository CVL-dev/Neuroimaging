// ----------------------------------------------------------------------
// Javascript form validation routines.
// Author: Stephen Poley
//
// Simple routines to quickly pick up obvious typos.
// All validation routines return true if executed by an older browser:
// in this case validation must be left to the server.
// ----------------------------------------------------------------------

emptyString = /^\s*$/

// -----------------------------------------
//                  trim
// Trim leading/trailing whitespace off string
// -----------------------------------------

function trim(str)
{
  return str.replace(/^\s+|\s+$/g, '')
};


// -----------------------------------------
//                  msg
// Display warn/error message in HTML element
// commonCheck routine must have previously been called
// -----------------------------------------

function msg(fld,     // id of element to display message in
             msgtype, // class to give element ("warn" or "error")
             message) // string to display
{
  // setting an empty string can give problems if later set to a 
  // non-empty string, so slip in an nbsp if needed
  var dispmessage;
  if (emptyString.test(message)) 
    dispmessage = "";    
  else  
    dispmessage = message;

  var elem = document.getElementById(fld);
  if (elem.firstChild && (elem.firstChild.nodeType == 1)) {
    elem.firstChild.nodeValue = dispmessage;  // DOM method
  } else { 
    elem.innerHTML = dispmessage; // IE/Opera method
  }

  elem.className = msgtype;
};

// -----------------------------------------
//            commonCheck
// Common code for all validation routines to:
// (a) check for older / less-equipped browsers
// (b) check if empty fields are required
// Returns true (validation passed), 
//         false (validation failed) or 
//         proceed (don't know yet)
// -----------------------------------------

var proceed = 2;  

function commonCheck    (vfld,   // element to be validated
                         ifld,   // id of element to receive info/error msg
                         reqd)   // true if required
{
  if (!document.getElementById) 
    return true;  // not available on this browser - leave validation to the server
  var elem = document.getElementById(ifld);
  if (!elem.firstChild && (typeof elem.innerHTML != "string"))
    return true;  // not available on this browser 

  if (emptyString.test(vfld.value)) {
    if (reqd) {
      msg (ifld, "error", "&nbsp;<font color=red><b>required</b></font>");  
      //vfld.focus();
      return false;
    }
    else {
      msg (ifld, "warn", "");   // OK
      return true;  
    }
  }
  return proceed;
}

// -----------------------------------------
//            validatePresent
// Validate if something has been entered
// Returns true if so 
// -----------------------------------------

function validatePresent(vfld,   // element to be validated
                         ifld )  // id of element to receive info/error msg
{
  var stat = commonCheck (vfld, ifld, true);
  if (stat != proceed) return stat;

  msg (ifld, "warn", "");  
  return true;
};

// -----------------------------------------
//            validateYear
// Validate if something has been entered
// Returns true if so 
// -----------------------------------------

function validateYear(vfld,   // element to be validated
                      ifld )  // id of element to receive info/error msg
{
  var stat = commonCheck (vfld, ifld, true);
  if (stat != proceed) return stat;

  var tmp = trim(vfld.value);
  var d = new Date();

  if (tmp >= 0 && tmp < d.getFullYear()) {
     msg (ifld, "warn", "");
     return true;  
  } else {
     msg (ifld, "error", "&nbsp;<b><font color=red>not a valid year</font></b>");
     return false;  
  }
};


// -----------------------------------------
//            validateYear
// Validate if something has been entered
// Returns true if so 
// -----------------------------------------

function validateBCYear(vfld,   // element to be validated
                        ifld )  // id of element to receive info/error msg
{
  var stat = commonCheck (vfld, ifld, true);
  if (stat != proceed) return stat;

  var tmp = trim(vfld.value);
  var d = new Date();

  if (tmp >= 0 && tmp < 10000) {
     msg (ifld, "warn", "");
     return true;  
  } else {
     msg (ifld, "error", "&nbsp;<b><font color=red>not a valid year</font></b>");
     return false;  
  }
};



// -----------------------------------------
//            validateNumber
// Validate if something has been entered
// Returns true if so 
// -----------------------------------------

function validateNumber(vfld,   // element to be validated
                        ifld )  // id of element to receive info/error msg
{

  var stat = commonCheck (vfld, ifld, true);
  if (stat != proceed) return stat;

  var tmp = trim(vfld.value);
  tmp = parseInt(tmp);
  if (!isNaN(tmp) && tmp > 0 ) {
     msg (ifld, "warn", "");
     return true;  
  } else {
     msg (ifld, "error", "&nbsp;<b><font color=red>invalid number</font></b>");
     return false;  
  }
};



// -----------------------------------------
//            validateFloat
// Validate if something has been entered
// Returns true if so 
// -----------------------------------------

function validateFloat(vfld,   // element to be validated
                       ifld )  // id of element to receive info/error msg
{

  if (!emptyString.test(vfld.value)) {
       var floatValue=parseFloat(vfld.value) 
       if (isNaN(floatValue)) {
           msg (ifld, "error", "<b><font color=red>invalid</font></b>");
	   return false;
       } else {
           var element = document.getElementById(ifld);
	   element.innerHTML = ""; // IE/Opera method
	   return true;	
       }
  } else {
    msg (ifld, "warn", "");	
    return true;
  }
};




// -----------------------------------------
//            validateAlphabet
// Validate if something has been entered
// Returns true if so 
// -----------------------------------------

function validateAlphabet(vfld,   // element to be validated
                          ifld )  // id of element to receive info/error msg
{

  if (!emptyString.test(vfld.value)) {
        var re = /^[a-zA-Z]*$/
        var isMatch = re.exec(vfld.value);

       if (isMatch != null && vfld.value == isMatch[0]) {
           var element = document.getElementById(ifld);
	   element.innerHTML = ""; // IE/Opera method
	   return true;	
       } else {
           msg (ifld, "error", "<b><font color=red>invalid</font></b>");
	   return false;
       }
  } else {
  }
  var element = document.getElementById(ifld);
  element.innerHTML = ""; // IE/Opera method
  return true;

};




// -----------------------------------------
//               validateEmail
// Validate if e-mail address
// Returns true if so (and also if could not be executed because of old browser)
// -----------------------------------------

function validateEmail  (vfld,   // element to be validated
                         ifld,   // id of element to receive info/error msg
                         reqd)   // true if required
{
  var stat = commonCheck (vfld, ifld, reqd);
  if (stat != proceed) return stat;

  var tfld = trim(vfld.value);  // value of field with whitespace trimmed off
  var email = /^[^@]+@[^@.]+\.[^@]*\w\w$/
  if (!email.test(tfld)) {
    msg (ifld, "error", "<b><font color=red>not a valid e-mail address</font></b>");
    //vfld.focus();
    return false;
  }

  var email2 = /^[A-Za-z][\w.-]+@\w[\w.-]+\.[\w.-]*[A-Za-z][A-Za-z]$/
  if (!email2.test(tfld)) 
    msg (ifld, "warn", "Unusual e-mail address - check if correct");
  else {
     var element = document.getElementById(ifld);
     element.innerHTML = ""; // IE/Opera method
  }
  return true;
};


// -----------------------------------------
//            validateTelnr
// Validate telephone number
// Returns true if so (and also if could not be executed because of old browser)
// Permits spaces, hyphens, brackets and leading +
// -----------------------------------------

function validateTelnr  (vfld,   // element to be validated
                         ifld,   // id of element to receive info/error msg
                         reqd)   // true if required
{
  var stat = commonCheck (vfld, ifld, reqd);
  if (stat != proceed) return stat;

  var tfld = trim(vfld.value);  // value of field with whitespace trimmed off
  var telnr = /^\+?[0-9 ()-]+[0-9]$/
  if (!telnr.test(tfld)) {
    msg (ifld, "error", "ERROR: not a valid telephone number. Characters permitted are digits, space ()- and leading +");
    vfld.focus();
    return false;
  }

  var numdigits = 0;
  for (var j=0; j<tfld.length; j++)
    if (tfld.charAt(j)>='0' && tfld.charAt(j)<='9') numdigits++;

  if (numdigits<6) {
    msg (ifld, "error", "ERROR: " + numdigits + " digits - too short");
    vfld.focus();
    return false;
  }

  if (numdigits>14)
    msg (ifld, "warn", numdigits + " digits - check if correct");
  else { 
    if (numdigits<10)
      msg (ifld, "warn", "Only " + numdigits + " digits - check if correct");
    else
      msg (ifld, "warn", "");
  }
  return true;
};

// -----------------------------------------
//             validateAge
// Validate person's age
// Returns true if OK 
// -----------------------------------------

function validateAge    (vfld,   // element to be validated
                         ifld,   // id of element to receive info/error msg
                         reqd)   // true if required
{
  var stat = commonCheck (vfld, ifld, reqd);
  if (stat != proceed) return stat;

  

  var tfld = trim(vfld.value);

  alert("value = "+tfld);

  var ageRE = /^[0-9]{1,3}$/
  if (!ageRE.test(tfld)) {
    msg (ifld, "error", "ERROR 100: not a valid age");
    vfld.focus();
    return false;
  }

  return true;
};
