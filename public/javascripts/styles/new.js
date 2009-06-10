$(document).ready(function() {
  
  addFileUpload(
    '/admin/styles.json',
    [ "style_image", 'style_symbol_image', 'style_crosshair_image' ],
    '/admin/styles/upload',
    '/admin/styles',
    '_linzblast_session_id'
  );

});