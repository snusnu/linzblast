package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Shape;
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

	public class Stage extends Sprite {
	
		public var id:String;
		public var label:String;
		public var description:String;
		public var posts:Object;
		
		// Constructor
		public function Stage(
			id:String = "",
			label:String = "",
			description:String = ""
		) {
			this.label = label;
			this.description = description;

			// Set Position and Scaling
			this.x = 0;
			this.y = 0;
			trace("this = " + this + " this.x = " + this.x + " this.y = " + this.y);
						
			this.scaleX = 1;
			this.scaleY = 1;
			
			init();

			trace("Stage " + label + ", Beschreibung: " + description);
		}
		
		private function init():void {
			loadPosts();
			var backgroundImagePath:String = "poestlingberg_bg.jpg";
			trace(backgroundImagePath);
		}
		
		public function loadPosts():Boolean {
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
				
				addChild(posts[key].sprite);
				posts[key].sprite.x = posts[key].x;
				posts[key].sprite.y = posts[key].y;
				var body:TextField = new TextField;
				body.text = posts[key].body;
				posts[key].sprite.addChild(body);
			}
		}
		
		
	}
}