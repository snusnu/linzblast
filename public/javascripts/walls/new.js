$(document).ready(function() {
  
  addFileUpload(
    '/admin/walls.json',
    [ "wall_image" ],
    '/admin/walls/upload',
    '/admin/walls',
    '_linzblast_session_id'
  );

});
