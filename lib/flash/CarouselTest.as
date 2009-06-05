package  {
	
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
	
	/**
	* Just a test of the OBO_3DCarousel class
	* @author Devon O.
	*/
	public class CarouselTest extends MovieClip {
		
		// on stage of .fla
		public var right_mc:MovieClip;
		public var left_mc:MovieClip;
		public var loading_txt:TextField;

		public static const XML_URL:String = "images.xml";
		
		private var _carousel:OBO_3DCarousel;
		private var _imageList:XMLList;
		private var _numImages:int;
		private var _currentImage:int = 0;
		
		public function CarouselTest():void {
			_carousel = new OBO_3DCarousel(700, 300, 220);
			_carousel.useBlur = true;
			_carousel.y = 150;
			_carousel.x = 550;
			addChild(_carousel);

			right_mc.addEventListener(MouseEvent.CLICK, rightClickHandler);
			left_mc.addEventListener(MouseEvent.CLICK, leftClickHandler);
			
			// Add Keyboard Event Listeners
			stage.addEventListener(KeyboardEvent.KEY_UP, rightKeyHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, leftKeyHandler);
			
			loading_txt.text = "loading xml";
			var uloader:URLLoader = new URLLoader();
			uloader.addEventListener(Event.COMPLETE, xmlHandler);
			uloader.addEventListener(IOErrorEvent.IO_ERROR, xmlHandler);
			uloader.load(new URLRequest(XML_URL));
		}
		
		private function xmlHandler(event:*):void {
			event.currentTarget.removeEventListener(Event.COMPLETE, xmlHandler);
			event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, xmlHandler);
			if (event is IOErrorEvent) {
				loading_txt.text = "could not load xml file";
			} else {
				var xml:XML = new XML(event.currentTarget.data);
				_imageList = xml..image;
				_numImages = _imageList.length();
				loadImage();
			}
		}
		
		private function loadImage():void {
			loading_txt.text = "loading image " + (_currentImage + 1).toString() + " / " + _numImages.toString();
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, imageHandler);
			loader.load(new URLRequest(_imageList[_currentImage].toString()));
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
			
			if (++_currentImage < _numImages){
				loadImage();
			} else {
				loading_txt.text = "complete";
			}
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