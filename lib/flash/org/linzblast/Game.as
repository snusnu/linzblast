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
	
		public function Game() {
			trace("Game called");
			
			var scenario:Scenario = new Scenario("1","Linz","Die europäische Kulturhaupstadt 2009");
			addChild(scenario);
		}
	}
}