// Reading Cookies
// taken from http://www.quirksmode.org/js/cookies.html
function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i = 0; i < ca.length; i++) {
		var c = ca[i];
		while (c.charAt(0) == ' ') c = c.substring(1, c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
	}
	return null;
}

function addFileUpload(resourceUrl, imageNames, uploadAction, redirect, cookieName) {
  
  var nrOfImage = 0;
  
  $.each(imageNames, function() {
    
    nrOfImage++;
    
    var config = {
      uploader    : '/javascripts/jquery-uploadify/uploader.swf',
      script      : uploadAction,
      cancelImg   : '/javascripts/jquery-uploadify/cancel.png',
      auto        : false,
      fileDataName: 'fileData',
      folder      : '/uploads/images',
      wmode       : 'transparent',
      multi       : true,
      fileExt     : '*.jpg;*.png;*.gif',
      fileDesc    : 'Images (jpg, png, gif)',
      buttonText  : 'Search',
      buttonImg   : '/javascripts/jquery-uploadify/upload_button.png'
    }
    
    // only install redirect for the last upload
    if (nrOfImage == imageNames.length) {
      config['onAllComplete'] = function() {
        location.href = redirect
      } 
    }
    
    $('#' + this + '-file').fileUpload (config);
    
  });
  
  $('form').submit(function(event) {
    
    if (imageNames.length > 1) {
      
      $.post(resourceUrl, $('form :input:visible').serialize(), function(resourceId) {
        
        $.each(imageNames, function() {
          upload("update", this, resourceId, cookieName);
        })
        
        return false;
      
      }, 'json');
    
    } else {
      
      upload("create", imageNames[0], null, cookieName);
      
    }
    
    return false
    
  });
  
}
  
function upload(action, imageName, resourceId, cookieName) {
  
  var queryString = "";
  var sessionInfo = '&' + cookieName + '=' + readCookie(cookieName);
  
  if (action == "update") {
    queryString = '&id=' + resourceId + '&image_name=' + imageName + sessionInfo;
  } else {
    queryString = '&' + $('form :input:visible').serialize() + sessionInfo;
  }
  
  var upload = $('#' + imageName + "-file");
  if (upload.length > 0) {
    upload.fileUploadSettings('scriptData', queryString);
    upload.fileUploadStart();
    return false;
  }
  
  return true;
  
}