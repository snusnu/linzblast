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
		
		public function CodeForm() {
			codeSubmitButton.addEventListener(MouseEvent.CLICK, onButtonClick);
		}
		
		private function onButtonClick(event:MouseEvent):void {
			submitCode();
		}
		
		function submitCode() {
			var variables:Object = new Object();
			variables.game = new Object();
			variables.game.code = codeInput.text;
			variables.game.stage_id = codeInput.text;
			variables._method = "POST";
			var request:URLRequest = new URLRequest("/games");
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