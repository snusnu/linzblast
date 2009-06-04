$(document).ready(function(){
  
  // Initialize accordion
  $('#actions-container').accordion({
      header: "h3",
      autoHeight: false,
      alwaysOpen: true,
      collapsible: true
  });
	
  
	// Colorize Tables
	$('table.resources tbody').colorize({
    altColor:'#2e2e2e',
		bgColor: '#000000',
		hoverColor: '#1281A9',
		hiliteClass: 'ui-state-active'
  });
  
	// make Table sortable
	$('table.resources').tablesorter({
    sortList: [[0, 0]]
  });
	
});