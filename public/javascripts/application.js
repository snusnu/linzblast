// Reading Cookies
// taken from http://www.quirksmode.org/js/cookies.html
function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}

function addFileUpload(imageNames, script, redirect) {
  
  var nrOfImage = 0;
  
  $.each(imageNames, function() {
    
    nrOfImage++;
    
    var config = {
      uploader    : '/javascripts/jquery-uploadify/uploader.swf',
      script      : script,
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
    
  })
  
  function upload(action, imageName, id) {
    
    var queryString = "";
    var sessionInfo = '&_linzblast_session_id=' + readCookie('_linzblast_session_id')
    
    if (action == "update") {
      queryString = '&id=' + id + '&image_name=' + imageName + sessionInfo;
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

  $('form').submit(function(event) {
    
    if (imageNames.length > 1) {
      
      $.post('/admin/styles.json', $('form :input:visible').serialize(), function(id) {
        
        $.each(imageNames, function() {
          upload("update", this, id);
        })
        
        return false;
      
      }, 'json');
    
    } else {
      
      upload("create", imageNames[0], null);
      
    }
    
    return false

  });

}
