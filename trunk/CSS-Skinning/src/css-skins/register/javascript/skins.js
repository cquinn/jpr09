(function() {
	var i, styleSheet;
	var styleSheets = document.styleSheets;
	var head = document.getElementsByTagName("head")[0];
	var cssNode = document.createElement('link'); 
	cssNode.type = 'text/css'; 
	cssNode.rel = 'stylesheet'; 
	cssNode.href = 'css/sunshine.css'; 
	cssNode.media = 'screen'; 
	cssNode.title = 'dynamicLoadedSheet'; 
	
	head.appendChild(cssNode);
	
	
	for (i = 0; i < styleSheets.length; i++) {
		styleSheet = styleSheets[i];
		
	}
})();

