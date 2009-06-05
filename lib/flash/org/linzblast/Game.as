package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.net.*;
	import flash.events.* ;
	
	// as3corelib json inlcude
	import com.adobe.serialization.json.*; 
	
	public class Game extends Sprite {
	
		public var stages:Object = new Object();
		
		public function Game() {
			trace("Game called");
			
			var gamestage:Scenario = new Scenario("1","Linz","Die europäische Kulturhaupstadt 2009","http://192.168.178.60:4000/uploads/images/1/original/poestlingberg_bg.jpg");
			addChild(gamestage);
			loadScenarios();
			var codeForm:CodeForm = new CodeForm();
			addChild(codeForm);
			codeForm.x = stage.width;
			trace("stage.width = " + stage.width);
			codeForm.y = stage.height -100;
		}
		
		private function loadScenarios():void {
  		var request:URLRequest = new URLRequest("/stages.json");
			request.method = URLRequestMethod.GET;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, listScenarios);
			loader.load(request);
		}
		
		private function listScenarios(event:Event):Object {
			var loader:URLLoader = URLLoader(event.target);
			var scenarios:Object = JSON.decode(loader.data);

			for (var key:Object in scenarios) {
				trace(scenarios[key].name);
				trace(scenarios[key].description);
				trace(scenarios[key].access_restricted);
				trace(scenarios[key].image_url);
				trace(scenarios[key].posts);
				
			}
			
			return scenarios	
		}
	}
}