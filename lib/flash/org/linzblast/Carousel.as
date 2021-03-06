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
		private var _carouselItems:Array;
		private var _currentImage;
		private var _numImages:int;
		
		private var _gameStage   = null;
		private var _data        = null;
		private var _imageName   = null;
		private var _contentType = null;
		
		public function Carousel(gameStage:Game, carouselData, imageName, contentType):void {
		  
		  _gameStage = gameStage;
		  _data      = carouselData;
		  _imageName = imageName;
		  _contentType = contentType;
		  
		  _numImages = _data.length
		  
			_carousel = new OBO_3DCarousel(700, 300, 400);
			_carousel.useBlur = true;
			_carousel.y = 150;
			_carousel.x = 550;
			addChild(_carousel);
			
			right_mc.addEventListener(MouseEvent.CLICK, rightClickHandler);
			left_mc.addEventListener(MouseEvent.CLICK, leftClickHandler);
			exitCarousel.addEventListener(MouseEvent.CLICK, exitClickHandler);
			
			// Add Keyboard Event Listeners
			_gameStage.stage.addEventListener(KeyboardEvent.KEY_UP, rightKeyHandler);
			_gameStage.stage.addEventListener(KeyboardEvent.KEY_UP, leftKeyHandler);
			
			loadImages();

		}
		
		public function nrOfCarouselItems():int {
		  return _data.length;
		}
		
		private function onItemMouseClick(event:MouseEvent) {
		  var cType = (_contentType == 'style') ? 'Style' : 'Wall' // ugly
		  _gameStage['current' + cType + 'Data'] = event.currentTarget.associatedData;
		  _gameStage['' + _contentType + 'Selector'].hide();
		  event.stopPropagation();
		}
		
		private function loadImages():void {
		  for(var entry:Object in _data) {
			  loadImage(_data[entry][_imageName])
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
				var item = _carousel.addItem(image, associatedItemData(imageUrl));
				item.addEventListener(MouseEvent.CLICK, onItemMouseClick);
			}
		}
		
		// images are loaded asynchronously that's why we need all this
		private function associatedItemData(imageUrl) {
		  
		  var associatedData = null;
		  
		  // ugly
		  var imageType = (_contentType == 'wall') ? 'medium_image_url' : 'original_image_url'
		  
		  for(var entry:Object in _data) {
		    var segments = _data[entry][imageType].split('/');
		    var imageName = segments[segments.length - 1].split('?')[0];
        if (imageUrl.indexOf(imageName) > -1) {
			    associatedData = _data[entry];
			  }
			}
		  
		  return associatedData;
		}
		
		private function rightClickHandler(event:MouseEvent):void {
			_carousel.targetRotation += 360 / _carousel.numItems;
			Tweener.addTween(_carousel, { zRotation:_carousel.targetRotation, time:1, transition:"easeOutBack" } );
		}
		
		private function leftClickHandler(event:MouseEvent):void {
			_carousel.targetRotation -= 360 / _carousel.numItems;
			Tweener.addTween(_carousel, { zRotation:_carousel.targetRotation, time:1, transition:"easeOutBack" } );
		}
		
		private function exitClickHandler(event:MouseEvent):void {
			_gameStage['' + _contentType + 'Selector'].hide();
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