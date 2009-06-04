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
    // clashes with tablesorting
		altColor:'#2e2e2e',
		bgColor: '#2e2e2e',
		hoverColor: '#1281A9',
		hiliteClass: 'ui-state-active'
  });
  
	// make Table sortable
	$('table.resources').tablesorter({
    sortList: [[0, 0]]
  });
	
});