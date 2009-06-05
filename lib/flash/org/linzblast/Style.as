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

	public class Style extends Sprite {
	  
	  // raw data
	  private var styleData        = null
	  
	  // interactive objects
	  private var gameStage:Game = null;
	  
	  
	  public function Style(gameStage:Game, styleData) {
	    this.gameStage = gameStage;
	    this.styleData = styleData;
	  }
	  
  }
}