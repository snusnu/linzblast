﻿package {  	import flash.display.MovieClip;	import flash.display.Sprite;	import flash.display.Shape;	import flash.display.Loader;	import flash.filters.*;  import flash.text.TextField;  import flash.text.TextFieldAutoSize;  import flash.text.TextFormat;	import flash.events.MouseEvent;	import flash.ui.Mouse;	import flash.net.*;	import flash.events.* ;	// as3corelib json inlcude	import com.adobe.serialization.json.*; 	public class Wall extends Sprite {	  	  // raw data	  private var _wallData         = null;	  private var _gameStage:Game = null;	  	  // interactive elements	  private var canvas:Sprite    = null;	  private var cursor:Sprite    = null;	  	  private var _currentWall     = null;	  private var _currentZIndex   = 0;				// TODO think about it		private var destX:Number;				// Constructor		public function Wall(gameStage:Game, wallData) {		  		  this._gameStage = gameStage;		  this._wallData  = wallData;		  		  this.canvas = new Sprite();  		this.cursor = new Sprite();						// Load Background and add to canvas			loadBackgroundImage(_wallData.original_image_url);						addChild(canvas);			addChild(cursor);						// setup image scrolling and cursor following			setupControls();			setChildIndex(cursor, numChildren-1);						// render all posts on this wall			renderPosts(_wallData.posts);					}				public function set wallData(wallData) {		  this._wallData = wallData;		  loadBackgroundImage(wallData.original_image_url);		}				private function loadBackgroundImage(backgroundImage:String):void {			var loader:Loader = new Loader();			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageHandler);			loader.load(new URLRequest(backgroundImage));		}				private function imageHandler(event:Event) {		  if(_currentWall && contains(_currentWall)) {			  canvas.removeChild(_currentWall)	    }	    _currentWall = event.currentTarget.loader;	    canvas.addChild(_currentWall);		}						// ransform them to Sprites on the Scenario Stage		private function renderPosts(posts):void {						var bgColor:String = "0x000000";						for (var key:Object in posts) {				if(posts[key].body) {					trace(posts[key].body);				}				bgColor = "0x" + posts[key].color;				posts[key].sprite = new Sprite();				posts[key].sprite.graphics.lineStyle(4);				//posts[key].sprite.graphics.moveTo(300,300);				posts[key].sprite.graphics.beginFill(bgColor);								posts[key].sprite.graphics.lineTo(-30,50);				posts[key].sprite.graphics.lineTo(20,30);				posts[key].sprite.graphics.lineTo(0,70);				posts[key].sprite.graphics.lineTo(50,90);				posts[key].sprite.graphics.lineTo(80,50);				posts[key].sprite.graphics.lineTo(100,60);				posts[key].sprite.graphics.lineTo(90,-30);				posts[key].sprite.graphics.lineTo(0,0);								posts[key].sprite.graphics.endFill();				var dropShadow:DropShadowFilter = new DropShadowFilter(5,45,0x3D0C0C,0.8,4,4,2,3,true,false,false);				posts[key].sprite.filters = [dropShadow];								canvas.addChild(posts[key].sprite);				posts[key].sprite.x = posts[key].x;				posts[key].sprite.y = posts[key].y;				var body:TextField = new TextField;				body.text = posts[key].body;				posts[key].sprite.addChild(body);			}		}				private function setupControls():void {						//Mouse.hide();						// Setup Event Listeners for Mouse Movement			addEventListener(MouseEvent.MOUSE_MOVE, followCursor);			addEventListener(MouseEvent.MOUSE_MOVE, scrollBackgroundImage);						// Setup canvas Information for fireGun()			this.destX = 1;		}				// follow the mouse cursor		private function followCursor(event:MouseEvent){			if (mouseY < 510) {				cursor.x = mouseX;				cursor.y = mouseY;				Mouse.hide();			} else {				Mouse.show();				cursor.x = mouseX;			}		}				// Scroll Background Image		private function  scrollBackgroundImage(event:Event):void {						var speed = 3;			var dir = 0;			var mousePercent:Number = mouseX/stage.stageWidth;			var mouseSpeed:Number;						if (dir == 1) {				mouseSpeed = 1 - mousePercent;			} else {				mouseSpeed = mousePercent;			}						destX = Math.round( -( (canvas.width-stage.stageWidth) * mouseSpeed));			canvas.addEventListener(Event.ENTER_FRAME, checkcanvas);						function checkcanvas(event:Event){				if (canvas.x == destX) {					canvas.removeEventListener(Event.ENTER_FRAME, checkcanvas);				} else {					canvas.x += Math.ceil((destX-canvas.x) * (speed / 100));				}			}		}			}}