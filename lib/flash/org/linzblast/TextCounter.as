package  {
	import flash.display.MovieClip;
	import flash.events.*;

	public class TextCounter extends MovieClip {
	  
	  private var gameStage:Game = null;
    private var maxChars:Number = 162;
	  
	  public function TextCounter() {
	    this.gameStage = gameStage;
      this.nrofchars.text = "0" + "/" + maxChars;
      setCharCounter(0);
	    
	  }
    
    public function setCharCounter(chars:Number) {
      this.nrofchars.text = chars + "/" + maxChars;
		}
  
  }

}