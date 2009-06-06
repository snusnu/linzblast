﻿package  {
	
	import caurina.transitions.Tweener;
	import com.onebyonedesign.td.OBO_3DCarousel;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	import com.adobe.serialization.json.*; 
	
	/**
	* Just a test of the OBO_3DCarousel class
	* @author Devon O.
	*/
	public class Carousel extends MovieClip {
		
		// on stage of .fla
		public var right_mc:MovieClip;
		public var left_mc:MovieClip;
		public var loading_txt:TextField;

		public static const XML_URL:String = "images.xml";
		
		private var _carousel:OBO_3DCarousel;
		private var _currentImage:int = 0;
		private var _numImages:int;
		
		private var _gameStage = null;
		private var _data      = null;
		
		public function Carousel(gameStage:Game, carouselData):void {
		  
		  _gameStage = gameStage;
		  _data      = carouselData;
		  
		  _numImages = _data.length
		  
			_carousel = new OBO_3DCarousel(700, 300, 220);
			_carousel.useBlur = true;
			_carousel.y = 150;
			_carousel.x = 550;
			addChild(_carousel);

			right_mc.addEventListener(MouseEvent.CLICK, rightClickHandler);
			left_mc.addEventListener(MouseEvent.CLICK, leftClickHandler);
			
			// Add Keyboard Event Listeners
			_gameStage.stage.addEventListener(KeyboardEvent.KEY_UP, rightKeyHandler);
			_gameStage.stage.addEventListener(KeyboardEvent.KEY_UP, leftKeyHandler);
			
			loadImages();

		}
		
		private function loadImages():void {
		  trace(JSON.encode(_data))
		  for(var entry:Object in _data) {
			  trace(JSON.encode(_data[entry].image_url))
			  loadImage(_data[entry].image_url)
			}
		}
		
		private function loadImage(imageUrl):void {
			loading_txt.text = "loading image " + (_currentImage + 1).toString() + " / " + _numImages.toString();
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, imageHandler);
			loader.load(new URLRequest(imageUrl));
		}
		
		private function imageHandler(event:*):void {
			event.currentTarget.removeEventListener(Event.COMPLETE, imageHandler);
			event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, imageHandler);
			if (event is IOErrorEvent) {
				loading_txt.text = "could not load image no " + _currentImage;
			} else {
				var image:Loader = event.currentTarget.loader;
				_carousel.addItem(image);
			}
			
/*      if (++_currentImage < _numImages){
        loadImage();
      } else {
        loading_txt.text = "complete";
      }*/
		}
		
		private function rightClickHandler(event:MouseEvent):void {
			_carousel.targetRotation += 360 / _carousel.numItems;
			Tweener.addTween(_carousel, { zRotation:_carousel.targetRotation, time:1, transition:"easeOutBack" } );
		}
		
		private function leftClickHandler(event:MouseEvent):void {
			_carousel.targetRotation -= 360 / _carousel.numItems;
			Tweener.addTween(_carousel, { zRotation:_carousel.targetRotation, time:1, transition:"easeOutBack" } );
		}
		
		// Setup Keyboard Event Handlers
		private function rightKeyHandler(event:KeyboardEvent):void {
			if (event.keyCode==39) {
				_carousel.targetRotation += 360 / _carousel.numItems;
				Tweener.addTween(_carousel, { zRotation:_carousel.targetRotation, time:1, transition:"easeOutBack" } );
			}
		}
		
		private function leftKeyHandler(event:KeyboardEvent):void {
			if (event.keyCode==37) {
				_carousel.targetRotation -= 360 / _carousel.numItems;
				Tweener.addTween(_carousel, { zRotation:_carousel.targetRotation, time:1, transition:"easeOutBack" } );
			}
		}
	}
}