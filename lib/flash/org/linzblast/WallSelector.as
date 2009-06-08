package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.net.*;
	import flash.events.* ;
	
	// as3corelib json inlcude
	import com.adobe.serialization.json.*; 
	
	public class WallSelector extends Sprite {
	  
	  private var gameStage:Game  = null;
	  private var hudWall:HUDWall = null;
	  private var gui:Carousel    = null;
	  
	  private var _currentWallData  = null;
	  
	  
	  public function WallSelector(gameStage:Game, hudWall:HUDWall) {
	    this.gameStage = gameStage;
	    this.hudWall   = hudWall;
	    this.gui       = new Carousel(gameStage, gameStage.wallsData, 'medium_image_url', 'wall');
		}
		
		public function get currentWallData() {
		  return this._currentWallData;
		}
		
		
		// user interaction support
		
		public function show() {
		  gameStage.addChild(gui);
      gui.x = 0;
      gui.y = 0;
		}
		
		public function hide() {
		  gameStage.removeChild(gui);
		}
		
		public function next() {
		  
		}
		
		public function previous() {
		  
		}
		
		
		// private helpers
		
		
		
		// called by wallSelector event listener
		private function setCurrentWall(event:Event) {
		  var wallData = null;
		  this._currentWallData = wallData;
		}
		
  }
}