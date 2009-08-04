package {
  
  import flash.display.Loader;
  import flash.display.Bitmap;
	import flash.display.BitmapData;
  import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.net.*;
	import flash.events.* ;
  import flash.filters.*;
  import flash.media.*;
  
	
	// as3corelib json include
	import com.adobe.serialization.json.*; 
	
	
	public class Game extends Sprite {
	  
	  // raw data
	  
	  private var _wallsData         = null;
	  private var _stylesData        = null;
	  
		private var _currentWallData   = null;
		private var _currentStyleData  = null;
		
		private var _accessCode        = false;
		private var _gameId            = null;
		
		// cache all images
	  private var _crosshairImages:Object  = null;
	  private var _currentCrosshairImageId = null;
		
		
		// interactive objects
		
		private var _gun:GunSound    = null;
		
		private var cursor:Sprite    = null;
    
    private var _fullscreenButton:FullscreenButton    = null;
		
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
		public function start(accessCode) {
		  _accessCode = accessCode;
		  addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		public function stop() {
      _accessCode = null;
      removeEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		public function post() {
		  if(_accessCode) {
        createPost();
      }
		}
		
		// mouse listener
		public function onMouseClick(event:MouseEvent) {
      if (mouseY < 480) {
        var channel:SoundChannel = _gun.play();
	      createPost();
      }
		}


		// setters
		
		public function set currentWall(currentWall) {
		  if (contains(_currentWall)) {
		    removeChild(_currentWall);
		  }
		  _currentWall = currentWall;
		  addChild(_currentWall);
		}
		
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
		  
		  if(cursor.contains(_crosshairImages[_currentCrosshairImageId])) {
		    cursor.removeChild(_crosshairImages[_currentCrosshairImageId])
		  }
		  
		  _currentCrosshairImageId = currentStyleData.id
		  var currentImage = _crosshairImages[_currentCrosshairImageId];
		  
		  cursor.addChild(currentImage);
		}
		
		
		// getters

		public function get gameId() {
		  return this._gameId;
		}
		

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



    // setters
    
		public function set gameId(gameId) {
		  this._gameId = gameId;
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
		  
		  _gun = new GunSound(); 
		  
		  this._wallsData  = gameElements.walls;
		  this._stylesData = gameElements.styles;
		  
		  // load crosshair images
      loadCrosshairImages();

		  this._hudWall    = new HUDWall(this);
			this._hudStyle   = new HUDStyle(this);
			
			// set default wall and style
			this._currentWallData  = defaultWallData;
			this._currentStyleData = defaultStyleData;
			
			// initialize codeForm
			this._codeForm = new CodeForm(this);
			this._codeForm.x = 305;
			this._codeForm.y = stage.stageHeight - 100;
  		
  		// make the wall
			this._currentWall = new Wall(this, currentWallData);
			addChild(this._currentWall);
			
			// make cursor
      this.cursor = new Sprite();
      
      // init fullscreen button | Flash plugin does not support Textinput in fullscreen mode
      //this._fullscreenButton = new FullscreenButton();
			//addChild(this._fullscreenButton);
      
      
      var glow:GlowFilter = new GlowFilter(0xF5BA0A, 1, 10, 10);
      cursor.filters = [glow];
      
  		//this.cursor.addChild(currentStyleData.crosshair_symbol_image);
  		addEventListener(MouseEvent.MOUSE_MOVE, followCursor);
  		addChild(cursor);
  		setChildIndex(cursor, numChildren-1);
		  
		  // setup codeForm
			addChild(this._codeForm);
			
		  // setup HUD display
		  addChild(this._hudWall);
		  addChild(this._hudStyle);
		}
		
		private function createPost() {
		  // setup the request
			var request:URLRequest = new URLRequest("/games/" + _gameId + ".json");
			request.contentType = "application/json";
			request.method = URLRequestMethod.POST;
			request.data = JSON.encode(this.postData());
			var loader:URLLoader = new URLLoader();

			// add listener that changes the gameStage
			loader.addEventListener(Event.COMPLETE, updateWall);
			loader.addEventListener(IOErrorEvent.IO_ERROR, updateWall);
			loader.load(request);
		}

		// build the post body content
		private function postData() {
		  var postData:Object = new Object();
			
			postData._method            = "PUT";
		  postData.id                 = _gameId;
      postData.game               = new Object();
		  postData.game.code          = _accessCode;
			postData.game.wall_id       = _currentWallData.id;
      postData.game.post          = new Object();
			postData.game.post.wall_id  = _currentWallData.id;
			postData.game.post.style_id = _currentStyleData.id;
      postData.game.post.body     = _codeForm.body.text;
      postData.game.post.x_coord  = mouseX - _currentWall.canvas.x;
      postData.game.post.y_coord  = mouseY;
      
      return postData;
		}

		private function updateWall(event:Event) {
		  if (event is IOErrorEvent) {
        trace("error creating post");
      } else {
		    
		    var newPost:Object = JSON.decode(URLLoader(event.target).data);

		    if (newPost) {
    		  _currentWall.renderPost(newPost);
    		  _currentWallData.recent_posts.push(newPost);
  		  }
      }
		}
		
		private function loadCrosshairImages() {
		  _crosshairImages = new Object();
		  _currentCrosshairImageId = defaultStyleData.id;
		  for(var i = 0; i < stylesData.length; i++) {
		    loadCrosshairImage(stylesData[i].crosshair_image_url);
		  }
		}
		
		private function loadCrosshairImage(imageUrl) {
		  var loader:Loader = new Loader();
  		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, crosshairImageHandler);
  		loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, crosshairImageHandler);
  		loader.load(new URLRequest(imageUrl));
		}
		
		private function crosshairImageHandler(event:Event) {
		  event.currentTarget.removeEventListener(Event.COMPLETE, addCrosshairImage);
			event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, addCrosshairImage);
			if (event is IOErrorEvent) {
				trace("could not load crosshair image");
			} else {
				var image:Loader = event.currentTarget.loader;
				var imageUrl = event.currentTarget.loader.contentLoaderInfo.url;
				addCrosshairImage(image, associatedCrosshairImageData(imageUrl));
			}
		}
		
		private function addCrosshairImage(image:DisplayObject, associatedData):void {
		  var data = new BitmapData(image.width, image.height, true, 0x00FFFFFF);
			data.draw(image);
			var bmp:Bitmap = new Bitmap(data, "auto", true);
			bmp.x -= bmp.width * .5;
			bmp.y -= bmp.height * .5;
			
			_crosshairImages[associatedData.id] = bmp;
			
			if(cursor.numChildren == 1) {
			  cursor.addChild(_crosshairImages[associatedData.id]);
			}
		}
		
		// images are loaded asynchronously that's why we need all this
		private function associatedCrosshairImageData(imageUrl) {
		  
		  var associatedData = null;
		  
		  for(var entry:Object in stylesData) {
		    
		    var styleData = stylesData[entry];
		    var segments = styleData.crosshair_image_url.split('/');
		    var imageName = segments[segments.length - 1].split('?')[0];
		    
        if (imageUrl.indexOf(imageName) > -1) {
			    associatedData = styleData;
			  }
			  
			}
		  
		  return associatedData;
		}
		
		// follow the mouse cursor
		private function followCursor(event:MouseEvent){
			if (mouseY < 510) {
				cursor.x = mouseX;
				cursor.y = mouseY;
				//Mouse.hide();
			} else {
				Mouse.show();
				cursor.x = mouseX;
			}
		}

	}
}