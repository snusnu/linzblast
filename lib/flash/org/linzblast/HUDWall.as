package {
  
  import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Loader;
  import flash.display.LoaderInfo;
  import flash.filters.*;
	import flash.ui.Mouse;
	import flash.net.*;
	import flash.events.*;
	
	// as3corelib json inlcude
	import com.adobe.serialization.json.*; 
	
	public class HUDWall extends Sprite {
	  
	  // game elements
	  private var gameStage:Game            = null;
	  private var wallSelector:WallSelector = null;
	  private var gui:HudWallDisplay        = null;
	  
	  private var _images:Object            = null;
	  private var _currentImageId           = null;
	  
	  // metadata
	  private var _currentWallData     = null;
	  
	  
	  public function HUDWall(gameStage:Game) {
	    this.gameStage    = gameStage;
      this.wallSelector = new WallSelector(this.gameStage, this);
      this.gui          = new HudWallDisplay();
      
      this._images         = new Object();
      this._currentImageId = gameStage.defaultWallData.id;

      initializeGui();
		}
		
		
		// called by wallSelector event listener
		public function set currentWallData(currentWallData) {
		  this._currentWallData = currentWallData;
      
		  // Don't show wallName
      //this.gui.wallName.text = currentWallData.name;
		  
		  if(this.gui.contains(_images[_currentImageId])) {
		    this.gui.removeChild(_images[_currentImageId])
		  }
		  
		  _currentImageId = currentWallData.id
		  var currentImage = _images[_currentImageId];
		  
		  gui.addChild(currentImage);
		  currentImage.x = currentImage.width * -1;
		  currentImage.y = 103;
		}
		
		public function get currentWallData() {
		  return this._currentWallData;
		}
		
		private function initializeGui() {
		  addChild(gui);
      gui.x = gameStage.stage.stageWidth - 20;
      gui.y = 444;
      
      var frame = new Sprite;
      frame.graphics.lineStyle(6,0xF5BA0A);
      frame.graphics.beginFill(0xF5BA0A);
      frame.graphics.drawRoundRect(0,0,156,76,10);
      frame.graphics.endFill();
      gui.addChild(frame);
      frame.x -= 153;
      frame.y = 100;
      
      gui.addEventListener(MouseEvent.CLICK, showWallSelector);
      this.gameStage.wallSelector = wallSelector;
      loadImages();
		}
		
		private function showWallSelector(event:Event) {
		  this.wallSelector.show();
		}
		
		
		// TODO finish image caching
		
		private function loadImages():void {
		  for(var entry:Object in gameStage.wallsData) {
			  loadImage(gameStage.wallsData[entry].symbol_image_url)
			}
		}
		
		private function loadImage(imageUrl):void {
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, imageHandler);
			loader.load(new URLRequest(imageUrl));
		}
		
		private function imageHandler(event:*):void {
			event.currentTarget.removeEventListener(Event.COMPLETE, imageHandler);
			event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, imageHandler);
			if (event is IOErrorEvent) {
				trace("could not load image");
			} else {
				var image:Loader = event.currentTarget.loader;
				var imageUrl = event.currentTarget.loader.contentLoaderInfo.url;
				addImage(image, associatedImageData(imageUrl));
			}
		}
		
		private function addImage(image:DisplayObject, associatedData):void {
		  var data = new BitmapData(image.width, image.height, true, 0x00FFFFFF);
      data.draw(image);
			var bmp:Bitmap = new Bitmap(data, "auto", true);
			bmp.x -= bmp.width * .5;
			bmp.y -= bmp.height * .5;
			
			_images[associatedData.id] = bmp;

      // Convert Image to Grayscale
      var matrix:Array = [0.3, 0.59, 0.11, 0, 0,
                      0.3, 0.59, 0.11, 0, 0,
                      0.3, 0.59, 0.11, 0, 0,
                      0, 0, 0, 1, 0];
                      
      var grayscaleFilter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
      bmp.filters = [grayscaleFilter];
			
      if(gui.numChildren == 2 && associatedData.id == 1) {
			  var currentImage = _images[associatedData.id]
			  
        gui.addChild(currentImage);
			  currentImage.x = currentImage.width * -1;
  		  currentImage.y = 103;
			}
		}
		
		// images are loaded asynchronously that's why we need all this
		private function associatedImageData(imageUrl) {
		  
		  var associatedData = null;
		  
		  for(var entry:Object in gameStage.wallsData) {
		    
		    var wallData = gameStage.wallsData[entry];
		    var segments = wallData.symbol_image_url.split('/');
		    var imageName = segments[segments.length - 1].split('?')[0];
		    
        if (imageUrl.indexOf(imageName) > -1) {
			    associatedData = wallData;
			  }
			  
			}
		  
		  return associatedData;
		}
		
  }
}