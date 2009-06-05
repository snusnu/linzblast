package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.net.*;
	import flash.events.* ;
	
	// as3corelib json inlcude
	import com.adobe.serialization.json.*; 
	
	public class StyleSelector extends Sprite {
	  
	  private var gameStage:Game  = null;
	  private var hudStyle:HUDStyle = null;
	  
	  private var _currentStyleData  = null;
	  
	  
	  public function StyleSelector(gameStage:Game, hudStyle:HUDStyle) {
	    this.gameStage = gameStage;
	    this.hudStyle  = hudStyle;
		}
		
		public function get currentStyleData() {
		  return this._currentStyleData;
		}
		
		
		// user interaction support
		
		public function next() {
		  
		}
		
		public function previous() {
		  
		}
		
		
		// private helpers
		
		// called by styleSelector event listener
		private function setCurrentStyle(event:Event) {
		  var styleData = null;
		  this._currentStyleData = styleData;
		}
		
  }
}