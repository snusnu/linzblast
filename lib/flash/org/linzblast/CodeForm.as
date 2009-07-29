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
	  
	  private var gameStage:Game = null;
	  
	  public function CodeForm(gameStage:Game) {
	    this.gameStage = gameStage;
	    
      this.codeSubmitButton.addEventListener(MouseEvent.CLICK, submitCode);
      
      this.body.addEventListener(Event.CHANGE,countChars);
	    this.body.maxChars = 162;
      
	    var bodyFormat:TextFormat = new TextFormat;
      
      bodyFormat.bold = true;
      bodyFormat.font = "Courier New";
      bodyFormat.size = 14;
      
      body.setStyle("textFormat", bodyFormat);
      codeInput.setStyle("textFormat", bodyFormat);
      
      //body.backgroundColor   = "0xFFFFFF";
      //body.textColor         = "0xFFFF00";
      //body.defaultTextFormat = bodyFormat;
      
      //codeInput.backgroundColor   = "0xFFFFFF";
      //codeInput.textColor         = "0xFFFF00";
      //codeInput.defaultTextFormat = bodyFormat;
	  }
	  
	  // private helpers
	  
	  private function submitCode(event:Event) {
	    
	    // setup the request
			var request:URLRequest = new URLRequest("/games.json");
			request.contentType = "application/json"; 
			request.method = URLRequestMethod.POST;
			request.data = JSON.encode(this.postData());
			var loader:URLLoader = new URLLoader();
			
			// add listener that changes the gameStage
			loader.addEventListener(Event.COMPLETE, setCurrentGameInfo);
			loader.addEventListener(IOErrorEvent.IO_ERROR, setCurrentGameInfo);
			loader.load(request);
		}
		
		// build the post body content
		private function postData() {
		  var postData:Object = new Object();
			postData.game = new Object();
			postData.game.code = codeInput.text;
			postData.game.wall_id = gameStage.currentWallData.id;
			postData._method = "POST";
			return postData;
		}
		
		// change current game info in gameStage
		private function setCurrentGameInfo(event:Event) {
		  if (event is IOErrorEvent) {
        trace("Unauthenticated");
      } else {
		    var gameInfo:Object = JSON.decode(URLLoader(event.target).data);
  		  this.gameStage.gameId           = gameInfo.id;
  		  //  Sensless to load new wallData here
        //  this.gameStage.currentWallData  = gameInfo.wall;
        this.gameStage.currentStyleData = gameInfo.available_styles[0];
        this.gameStage.start(codeInput.text);
      }
		}
    
    // build the post body content
		private function countChars(event:Event) {
      trace("body.length: " + body.length);
      textcounter.setCharCounter(body.length);
      trace("countChars fired");
		}
    
	}
}