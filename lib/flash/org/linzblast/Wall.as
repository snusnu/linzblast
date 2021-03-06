﻿package {
  
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.Loader;
	import flash.filters.*;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.net.*;
	import flash.events.* ;

	// as3corelib json inlcude
	import com.adobe.serialization.json.*; 

	public class Wall extends Sprite {
	  
	  // raw data
	  private var _wallData         = null;
	  private var _gameStage:Game = null;
	  
	  // interactive elements
	  private var _canvas:Sprite    = null;
	  
	  private var _currentWall     = null;
	  private var _currentZIndex   = 0;
		
		// TODO think about it
		private var destX:Number;

		
		// Constructor
		public function Wall(gameStage:Game, wallData) {
		  
		  this._gameStage = gameStage;
		  this._wallData  = wallData;
		  
		  this._canvas = new Sprite();
			
			this.wallData = wallData;
			
		}
		
		public function get canvas() { return _canvas; }
		
		public function set wallData(wallData) {
		  this._wallData = wallData;
		  loadBackgroundImage(wallData.original_image_url);
		  
      if(_canvas && contains(_canvas)) {
			  
        // TODO: Find a better way do get rid of old wall and posts
        while(_canvas.numChildren)
        {
            _canvas.removeChildAt(0);
        }

        
        removeChild(_canvas)
	    }
		  addChild(_canvas);
			
			// setup image scrolling and cursor following
			setupControls();
		}
		
		public function destinationX() {
		  return Math.round( -( (canvas.width-stage.stageWidth) * (mouseX / stage.stageWidth)));
		}
		
		private function loadBackgroundImage(backgroundImage:String):void {
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageHandler);
			loader.load(new URLRequest(backgroundImage));
		}
		
		private function imageHandler(event:Event) {
		  if(_currentWall && contains(_currentWall)) {
			  canvas.removeChild(_currentWall)
	    }
	    _currentWall = event.currentTarget.loader;
	    canvas.addChild(_currentWall);
	    scrollBackgroundImage(event);
	    // render all posts on this wall
			renderPosts(_wallData.recent_posts);
		}
		
		
		// transform them to Sprites on the Scenario Stage
		private function renderPosts(posts):void {
      for(var i = 0; i < posts.length; i++) {
			  renderPost(posts[i]);
			}
		}
		
		public function renderPost(post) {
		  
		  var sprite = new Sprite();
	    sprite.graphics.lineStyle(2);
	    
	    // post.polygon is a json encoded array
	    var polygon = JSON.decode(post.polygon);
	    
	    var firstX = polygon[0][0];
	    var firstY = polygon[0][1];
	    
	    sprite.graphics.moveTo(firstX, firstY);
	    
      sprite.graphics.beginFill(post.background_color);
      
		  for(var i = 1; i < polygon.length; i++) {
		    
		    var x = polygon[i][0];
		    var y = polygon[i][1];
		    
		    sprite.graphics.lineTo(x, y);
        
		  }
		  
		  sprite.graphics.lineTo(firstX, firstY);
		  
		  sprite.graphics.endFill();
      
      canvas.addChild(sprite);
      sprite.x = post.x_coord;
      sprite.y = post.y_coord;
      
      var body:TextField = new TextField;
      body.x = -35;
      body.y = -55;
      body.width = 90;
      body.wordWrap = true;
      body.autoSize = TextFieldAutoSize.CENTER;
      
      var bodyFormat:TextFormat = new TextFormat;
      
      bodyFormat.bold = true;
      bodyFormat.font = "Courier";
      bodyFormat.size = 14;
      
      body.defaultTextFormat = bodyFormat;
      //body.setTextFormat(bodyFormat);
      body.text = post.body;
      sprite.addChild(body);
      
		}
		
		private function setupControls():void {
			
			//Mouse.hide();
			
			// Setup Event Listeners for Mouse Movement
			addEventListener(MouseEvent.MOUSE_MOVE, scrollBackgroundImage);
			
			// Setup canvas Information for fireGun()

			this.destX = 1;
		}
		
		// Scroll Background Image
		private function  scrollBackgroundImage(event:Event):void {
			
			var speed = 6;
			var dir = 0;
			var mousePercent:Number = mouseX/stage.stageWidth;
			
			destX = destinationX();
			canvas.addEventListener(Event.ENTER_FRAME, checkcanvas);
			
			function checkcanvas(event:Event){
				if (canvas.x == destX) {
					canvas.removeEventListener(Event.ENTER_FRAME, checkcanvas);
				} else {
					canvas.x += Math.ceil((destX-canvas.x) * (speed / 100));
				}
			}
		}
		
	}
}