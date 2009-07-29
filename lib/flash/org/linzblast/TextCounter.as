package  {
	import flash.display.MovieClip;
	import flash.events.*;

	public class TextCounter extends MovieClip {
	  
	  private var gameStage:Game = null;
    private var maxChars:Number = 162;
	  
	  public function TextCounter() {
	    this.gameStage = gameStage;
      this.nrofchars.text = "blabla" + "/" + maxChars;
      setCharCounter(0);
	    
	  }
    
    public function setCharCounter(chars:Number) {
      trace("setCharCounter fired");
      this.nrofchars.text = chars + "/" + maxChars;
		}
  
  }

}