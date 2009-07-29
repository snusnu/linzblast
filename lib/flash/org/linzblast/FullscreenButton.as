package  {
	import flash.display.MovieClip;
  import flash.display.StageDisplayState;
	import flash.events.*;

	public class FullscreenButton extends MovieClip {
	  
	  private var gameStage:Game = null;
	  
	  public function FullscreenButton() {
	    this.gameStage = gameStage;
	    this.addEventListener(MouseEvent.CLICK, changeScreenMode);
	    
	  }
    
    private function changeScreenMode(event:Event) {
      trace("changeScreenMode fired");
      trace("StageDisplayState");
      stage.displayState = StageDisplayState.FULL_SCREEN;
		}
  
  }

}