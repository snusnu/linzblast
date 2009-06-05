package {
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
	
		public var id:String;
		public var label:String;
		public var description:String;
		public var posts:Object;
		public var backgroundImage:String;
		public var canvas:Sprite = new Sprite();
		public var cursor:Sprite = new Sprite();
		public var destX:Number;

		
		// Constructor
		public function Wall(
			id:String = "",
			label:String = "",
			description:String = "",
			backgroundImage:String = ""
		) {
			cursor.graphics.beginFill(0x000000); 
			cursor.graphics.drawCircle(0,0,20); 
			cursor.graphics.endFill(); 
			addChild(cursor);
			trace(getChildIndex(cursor));

			trace(backgroundImage);
			this.label = label;
			this.description = description;
			this.backgroundImage = backgroundImage;
			this.canvas = canvas;

			// Set Position and Scaling
			this.x = 0;
			this.y = 0;

			this.scaleX = 1;
			this.scaleY = 1;
			
			init();

			trace("Wall " + label + ", Beschreibung: " + description);
		}
		
		private function init():void {
			trace(backgroundImage);
			// Load Background and place on Scenario
			canvas = loadBackgroundImage(backgroundImage);
			addChild(canvas);
			trace(getChildIndex(canvas));
			
			// load and render posts
			loadPosts();
			
			// setup image scrolling and cursor following
			setupControls();
			setChildIndex(cursor, numChildren-1);
		}
		
		private function loadBackgroundImage(backgroundImage:String):Sprite {
			var background:Loader = new Loader();
			background.load(new URLRequest(backgroundImage));
			canvas.addChild(background);
			trace(background.content);
			return canvas
		}
		
		private function loadPosts():Boolean {
			var request:URLRequest = new URLRequest("http://192.168.178.60:4000/posts.txt");
			request.method = URLRequestMethod.GET;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, renderPosts) ;
			 
			try{
				loader.load(request);
				return true
			}
			catch (error:Error) {
				trace("Unable to load URL");
				return false
			}
			return true
		}
		
		
		// Load Posts form Server and transform them to Sprites on the Scenario Stage
		private function renderPosts(event:Event):void {
			var loader:URLLoader = URLLoader(event.target);
			var posts:Object = JSON.decode(loader.data);
			var bgColor:String = "0x000000";
			for (var key:Object in posts) {
				if(posts[key].body) {
					trace(posts[key].body);
				}
				bgColor = "0x" + posts[key].color;
				posts[key].sprite = new Sprite();
				posts[key].sprite.graphics.lineStyle(4);
				//posts[key].sprite.graphics.moveTo(300,300);
				posts[key].sprite.graphics.beginFill(bgColor);
				
				posts[key].sprite.graphics.lineTo(-30,50);
				posts[key].sprite.graphics.lineTo(20,30);
				posts[key].sprite.graphics.lineTo(0,70);
				posts[key].sprite.graphics.lineTo(50,90);
				posts[key].sprite.graphics.lineTo(80,50);
				posts[key].sprite.graphics.lineTo(100,60);
				posts[key].sprite.graphics.lineTo(90,-30);
				posts[key].sprite.graphics.lineTo(0,0);
				
				posts[key].sprite.graphics.endFill();
				var dropShadow:DropShadowFilter = new DropShadowFilter(5,45,0x3D0C0C,0.8,4,4,2,3,true,false,false);
				posts[key].sprite.filters = [dropShadow];
				
				canvas.addChild(posts[key].sprite);
				posts[key].sprite.x = posts[key].x;
				posts[key].sprite.y = posts[key].y;
				var body:TextField = new TextField;
				body.text = posts[key].body;
				posts[key].sprite.addChild(body);
			}
		}
		
		private function setupControls():void {
			
			Mouse.hide();
			
			// Setup Event Listeners for Mouse Movement
			addEventListener(MouseEvent.MOUSE_MOVE,follow);
			addEventListener(MouseEvent.MOUSE_MOVE,panBg);
			
			
			// Setup canvas Information for fireGun()

			var destX:Number = 1;
		}
		
		// Scroll Background Image
		private function  panBg(event:Event):void {
			var speed = 3;
			var dir = 0;
			var mousePercent:Number = mouseX/stage.stageWidth;
			var mSpeed:Number;
			if (dir == 1) {
			
				mSpeed = 1-mousePercent;
			
			} else {
			
				mSpeed = mousePercent;
			
			}
			destX = Math.round(-((canvas.width-stage.stageWidth)*mSpeed));
			canvas.addEventListener(Event.ENTER_FRAME, checkcanvas);
			
			function checkcanvas(event:Event){
				if (canvas.x == destX) {
					//trace("canvas.x = " + canvas.x + " and mouseY = " + mouseY);
					canvas.removeEventListener(Event.ENTER_FRAME, checkcanvas);
			
				} else {
					//trace("canvas.x = " + canvas.x + " and mouseY = " + mouseY);
					canvas.x += Math.ceil((destX-canvas.x)*(speed/100));
			
				}
			}
		}

		private function follow(event:MouseEvent){
			if (mouseY < 510) {
				cursor.x = mouseX;
				cursor.y = mouseY;
				Mouse.hide();
			}
			else {
				Mouse.show();
				cursor.x = mouseX;
			}
		}
		
	}
}