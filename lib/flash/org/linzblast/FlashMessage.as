package {
  import flash.display.MovieClip;
  import flash.utils.Timer;
  import flash.events.TimerEvent;
  
  public class FlashMessage extends MovieClip {
    
    private var gameStage:Game = null;
    private var _isVisible:Boolean = false;
    private var _timeout:Number = 3000;
    private var _text:String = null;
    
    public function FlashMessage(gameStage:Game, _text:String, _timeout:Number) {
      
      // center msg on stage
      this.x = gameStage.stage.stageWidth*.5 - this.width*.5;
      this.y = gameStage.stage.stageHeight*.5 - this.height*.5;
      
      this.messageText.text = _text;
      
      setupTimer(_timeout);
      
      gameStage.stage.addChild(this);
    }
    
    private function setupTimer(_timeout:Number) {
            var myTimer:Timer = new Timer(_timeout, 1);
            myTimer.addEventListener("timer", timerHandler);
            myTimer.start();
    }
    
    private function timerHandler(event:TimerEvent):void {
      if(this) if(this.parent ) this.parent.removeChild(this);
    }
  
  }
}