package {
  
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.net.*;
	import flash.events.* ;
	
	// as3corelib json include
	import com.adobe.serialization.json.*; 
	
	
	public class Game extends Sprite {
	  
	  // raw data
	  
	  private var _wallsData         = null;
	  private var _stylesData        = null;
	  
		private var _currentWallData   = null;
		private var _currentStyleData  = null;
		
		
		// interactive objects
		
		private var codeForm:CodeForm  = null;

		private var hudWall:HUDWall    = null;
		private var hudStyle:HUDStyle  = null;
		
		private var currentWall:Wall   = null;
		private var currentStyle:Style = null;
			
		private var wallSelector:WallSelector   = null;
		private var styleSelector:StyleSelector = null;
		
		
		
		public function Game() {
			initialize();
		}
		
		public function initialize() {
  		var request:URLRequest = new URLRequest("http://localhost:4000/stage.json");
  		request.method = URLRequestMethod.GET;
  		var loader:URLLoader = new URLLoader();
  		loader.addEventListener(Event.COMPLETE, initializeElements);
  		loader.load(request);
		}
		
		// called from CodeForm event listener
		public function start() {
      // TODO implement
		}
		
		
		// setters
		
		
		// called from WallSelector event listener
		public function set currentWallData(currentWallData) {
		  this._currentWallData = currentWallData;
		}
		
		// called from StyleSelector event listener
		public function set currentStyleData(currentStyleData) {
		  this._currentStyleData = currentStyleData;
		}
		
		
		// getters

		public function get defaultWallData() {
		  return this._wallsData[0];
		}
		
		public function get defaultStyleData() {
		  return this._stylesData[0];
		}
				
		
		public function get currentWallData() {
		  return this._currentWallData;
		}
		
		public function get currentStyleData() {
		  return this._currentStyleData;
		}
		
		
		public function get wallsData() {
		  return this._wallsData;
		}
		
		public function get stylesData() {
		  return this._stylesData;
		}
		
		
		// helpers
		
		// store game info in game stage
		private function initializeElements(event:Event):void {
		  
		  var gameElements:Object = JSON.decode(URLLoader(event.target).data);
		  
		  this._wallsData  = gameElements.walls;
		  this._stylesData = gameElements.styles;
		  this.hudWall    = new HUDWall(this);
			this.hudStyle   = new HUDStyle(this);
			
			// set default wall and style
			this._currentWallData  = defaultWallData;
			this._currentStyleData = defaultStyleData;
			
			// initialize codeForm
			this.codeForm = new CodeForm(this);
		  
		  // setup codeForm
			addChild(this.codeForm);
			
		  // setup HUD display
		  addChild(this.hudWall);
		  addChild(this.hudStyle);
		}

	}
}