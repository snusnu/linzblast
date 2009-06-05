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

$(document).ready(function() {
  
  $('#image-file').fileUpload ({
    uploader    : '/javascripts/jquery-uploadify/uploader.swf',
    script      : '/admin/walls/upload',
    cancelImg   : '/javascripts/jquery-uploadify/cancel.png',
    auto        : false,
    fileDataName: 'fileData',
    folder      : '/uploads/images',
    wmode       : 'transparent',
    multi       : true,
    fileExt     : '*.jpg;*.png;*.gif',
    fileDesc    : 'Images (jpg, png, gif)',
    buttonText  : 'Search',
    buttonImg   : '/javascripts/jquery-uploadify/upload_button.png',
    onAllComplete: function(){
      location.href="/admin/walls"
    }
  });

  $('form').submit(function(event){
    var queryString = '&' + $('form :input:visible').serialize() + '&' + '_linzblast_session_id=' + readCookie('_linzblast_session_id');
    var upload = $('#image-file');
    if (upload.length > 0) {
      upload.fileUploadSettings('scriptData', queryString);
      upload.fileUploadStart();
      return false;
    }
    return true;
  });

});
