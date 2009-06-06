package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.net.*;
	import flash.events.* ;
	
	// as3corelib json inlcude
	import com.adobe.serialization.json.*; 
	
	public class StyleSelector extends Sprite {
	  
	  private var gameStage:Game    = null;
	  private var hudStyle:HUDStyle = null;
	  private var gui:Carousel      = null;
	  
	  private var _currentStyleData  = null;
	  
	  
	  public function StyleSelector(gameStage:Game, hudStyle:HUDStyle) {
	    this.gameStage = gameStage;
	    this.hudStyle  = hudStyle;
	    this.gui       = new Carousel();
		}
		
		public function get currentStyleData() {
		  return this._currentStyleData;
		}
		
		
		// user interaction support
		
		public function next() {
		  
		}
		
		public function previous() {
		  
		}		
		
		public function show() {
		  gameStage.addChild(gui);
      gui.x = 0;
      gui.y = 0;
		}


		// private helpers
		
		// called by styleSelector event listener
		private function setCurrentStyle(event:Event) {
		  var styleData = null;
		  this._currentStyleData = styleData;
		}
		
  }
}