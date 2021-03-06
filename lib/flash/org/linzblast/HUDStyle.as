﻿package {
  
  import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.ui.Mouse;
	import flash.net.*;
	import flash.events.*;
	
	// as3corelib json inlcude
	import com.adobe.serialization.json.*; 
	
	public class HUDStyle extends Sprite {
	  
	  // game elements
	  private var gameStage:Game              = null;
	  private var styleSelector:StyleSelector = null;
	  private var gui:HudStyleDisplay         = null;
	  
	  // cache all images
	  private var _images:Object              = null;
	  private var _currentImageId             = null;
	  
	  // metadata
	  private var _currentStyleData     = null;
	  
	  
	  public function HUDStyle(gameStage:Game) {
	    this.gameStage       = gameStage;
      this.styleSelector   = new StyleSelector(this.gameStage, this);
      this.gui             = new HudStyleDisplay();
      this._images         = new Object();
      this._currentImageId = gameStage.defaultStyleData.id;

      
      initializeGui();
		}
		
		// called by styleSelector event listener
		public function set currentStyleData(currentStyleData) {
		  this._currentStyleData = currentStyleData;
		  
      // Don't show the Style e Label  on the gui
      //this.gui.styleName.text = currentStyleData.name;
		  
      this.gui.removeChildAt(1);
      
		  _currentImageId = currentStyleData.id
		  var currentImage = _images[_currentImageId];
      
		  gui.addChild(currentImage);
		  currentImage.x = 0;
		  currentImage.y = 32;
		}
		
		public function get currentStyleData() {
		  return this._currentStyleData;
		}
		
		private function initializeGui() {
      gui.x = 20;
      gui.y = gameStage.stage.stageHeight - 123;
      gui.addEventListener(MouseEvent.CLICK, showStyleSelector);
      this.gameStage.styleSelector = styleSelector;
		  addChild(gui);
      loadImages();
		}
		
		private function showStyleSelector(event:Event) {
		  this.styleSelector.show();
		}
		
		
		// TODO finish image caching
		
		private function loadImages():void {
		  for(var entry:Object in gameStage.stylesData) {
			  loadImage(gameStage.stylesData[entry].symbol_image_url)
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
			
			if(gui.numChildren == 1) {
			  var currentImage = _images[associatedData.id]
			  gui.addChild(currentImage);
			  currentImage.x = 0;
  		  currentImage.y = 32;
			}
		}
		
		// images are loaded asynchronously that's why we need all this
		private function associatedImageData(imageUrl) {
		  
		  var associatedData = null;
		  
		  for(var entry:Object in gameStage.stylesData) {
		    
		    var styleData = gameStage.stylesData[entry];
		    var segments = styleData.symbol_image_url.split('/');
		    var imageName = segments[segments.length - 1].split('?')[0];
		    
        if (imageUrl.indexOf(imageName) > -1) {
			    associatedData = styleData;
			  }
			  
			}
		  
		  return associatedData;
		}
		
  }
}