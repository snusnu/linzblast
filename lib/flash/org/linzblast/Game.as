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
		
		private var _running           = false;
		
		
		// interactive objects
		
		private var _codeForm:CodeForm  = null;

		private var _hudWall:HUDWall    = null;
		private var _hudStyle:HUDStyle  = null;
		
		private var _currentWall:Wall   = null;
		private var _currentStyle:Style = null;
			
		private var _wallSelector:WallSelector   = null;
		private var _styleSelector:StyleSelector = null;
		
		
		
		public function Game() {
			initialize();
		}
		
		public function initialize() {
  		var request:URLRequest = new URLRequest("/stage.json");
  		request.method = URLRequestMethod.GET;
  		var loader:URLLoader = new URLLoader();
  		loader.addEventListener(Event.COMPLETE, initializeElements);
  		loader.load(request);
		}
		
		// called from CodeForm event listener
		public function start() {
      _running = true;
		}
		
		public function stop() {
      _running = false;
		}
		
		public function post() {
		  if(_running) {
        // TODO implement
      }
		}
		
		
		// setters
		
		
		// called from WallSelector event listener
		public function set currentWallData(currentWallData) {
		  this._currentWallData = currentWallData;
		  this._hudWall.currentWallData = currentWallData;
		  this._currentWall.wallData = currentWallData;
		}
		
		// called from StyleSelector event listener
		public function set currentStyleData(currentStyleData) {
		  this._currentStyleData = currentStyleData;
		  this._hudStyle.currentStyleData = currentStyleData;
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



		public function set wallSelector(wallSelector) {
		  this._wallSelector = wallSelector;
		}
		
		public function set styleSelector(styleSelector) {
		  this._styleSelector = styleSelector;
		}
		
				
		
		public function get wallSelector() {
		  return this._wallSelector;
		}
		
		public function get styleSelector() {
		  return this._styleSelector;
		}
		
		
		// helpers
		
		// store game info in game stage
		private function initializeElements(event:Event):void {
		  
		  var gameElements:Object = JSON.decode(URLLoader(event.target).data);
		  
		  this._wallsData  = gameElements.walls;
		  this._stylesData = gameElements.styles;

		  this._hudWall    = new HUDWall(this);
			this._hudStyle   = new HUDStyle(this);
			
			// set default wall and style
			this._currentWallData  = defaultWallData;
			this._currentStyleData = defaultStyleData;
			
			// initialize codeForm
			this._codeForm = new CodeForm(this);
			
			this._currentWall = new Wall(this, currentWallData);
			addChild(this._currentWall);
		  
		  // setup codeForm
			addChild(this._codeForm);
			
		  // setup HUD display
		  addChild(this._hudWall);
		  addChild(this._hudStyle);
		}
		
		private function createPost(event:Event) {
		  
		}

	}
}