package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Loader;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
	import flash.net.*;
	import flash.events.*;
	
	// as3corelib json include
	import com.adobe.serialization.json.*; 
	
	public class CodeForm extends MovieClip {
		
		var stage_id = null;
		
		public function CodeForm(stage_id:uint) {
			this.stage_id = stage_id;
			trace(stage_id);
			codeSubmitButton.addEventListener(MouseEvent.CLICK, onButtonClick);
		}
		
		private function onButtonClick(event:MouseEvent):void {
			submitCode();
		}
		
		function submitCode() {
			var variables:Object = new Object();
			variables.game = new Object();
			variables.game.code = codeInput.text;
			variables.game.wall_id = codeInput.text;
			variables._method = "POST";
			var request:URLRequest = new URLRequest("/games.json");
			request.contentType = "application/json"; 
			request.method = URLRequestMethod.POST;
			request.data = JSON.encode(variables);
			trace(request.data);
			var loader:URLLoader = new URLLoader();
			 
			try{
				loader.load(request);
				return true
			}
			catch (error:Error) {
				trace("Unable to load URL");
				return false
			}
		}
		
	}
}