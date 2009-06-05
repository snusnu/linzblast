package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.net.*;
	import flash.events.* ;
	
	// as3corelib json inlcude
	import com.adobe.serialization.json.*; 
	
	public class LinzBlast extends Sprite {
	
		public var stages:Object = new Object();
		
		public function LinzBlast() {
			trace("LinzBlast called");
			
			var gamestage:Wall = new Wall("1","Linz","Die europäische Kulturhaupstadt 2009","http://192.168.178.60:4000/uploads/images/1/original/poestlingberg_bg.jpg");
			addChild(gamestage);
			loadWalls();
			var codeForm:CodeForm = new CodeForm();
			addChild(codeForm);
			codeForm.x = stage.width;
			trace("stage.width = " + stage.width);
			codeForm.y = stage.height -100;
		}
		
		private function loadWalls():void {
  		var request:URLRequest = new URLRequest("/walls.json");
			request.method = URLRequestMethod.GET;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, listWalls);
			loader.load(request);
		}
		
		private function listWalls(event:Event):Object {
			var loader:URLLoader = URLLoader(event.target);
			var walls:Object = JSON.decode(loader.data);

			for (var key:Object in walls) {
				trace(walls[key].name);
				trace(walls[key].description);
				trace(walls[key].access_restricted);
				trace(walls[key].image_url);
				trace(walls[key].posts);
				
			}
			
			return walls	
		}
	}
}