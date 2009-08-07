package com.onebyonedesign.td {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.text.StyleSheet;
	import flash.events.MouseEvent;
	
	/**
	* 3D items for OBO_3DCarousel class
	* @author Devon O.
	*/
	public class TDCarouselItem extends Sprite {
		
		private var _radius:Number;
		private var _radians:Number;
		private var _angle:Number;
		private var _focalLength:int;
		private var _orgZPos:Number;
		private var _orgYPos:Number;
		private var _data:BitmapData;
		private var _associatedData;
    
    // style data
    private var _propsTable:TextField;
    private var _propsStyle:StyleSheet;
		
		private var _zpos:Number;
		
		public function TDCarouselItem(image:DisplayObject, associatedData):void {
			_data = new BitmapData(image.width, image.height, true, 0x00FFFFFF);
			_data.draw(image);
			_associatedData = associatedData;
			var bmp:Bitmap = new Bitmap(_data, "auto", true);
			bmp.x -= bmp.width * .5;
			bmp.y -= bmp.height * .5;
      
      _propsTable = new TextField();
      _propsTable.multiline = true;
      
      _propsStyle = new StyleSheet;
      
      var propLabel:Object = new Object();
      propLabel.fontSize = "18";
      var body:Object = new Object();
      body.color = "#F5BA0A";
      body.fontFamily = "Courier New";
      body.fontSize = "24";
      body.fontWeight = "bold";
      
      if (_associatedData.distortion) {
        body.textAlign = "right";
      } else {
       body.textAlign = "center";
      }
      
      _propsStyle.setStyle(".label", propLabel);
      _propsStyle.setStyle("body", body);
     
      _propsTable.styleSheet = _propsStyle;
      
      // check if wall or style
      if (_associatedData.distortion) {

        _propsTable.width = 500;
        _propsTable.height = 350;
        _propsTable.x -= 10;
        _propsTable.y = 70;

        _propsTable.htmlText = "<body>" +
                                "<span class='label'>name</span><br>" + _associatedData.name +
                                "<br><span class='label'>type</span><br>" + _associatedData.type +
                                "<br><span class='label'>series</span><br>" + _associatedData.series +
                                "<br><span class='label'>manufacturer</span><br>" + _associatedData.manufacturer +
                                "<br><span class='label'>range</span><br>" + _associatedData.range +
                                "</body>";

      } else {
      
        _propsTable.width = 400;
        _propsTable.height = 60;
        _propsTable.x -= _propsTable.width * .5;
        _propsTable.y = 225;

        _propsTable.htmlText = "<body>" + _associatedData.name + "</body>";

      }
      
			updateDisplay();
			addChild(bmp);
      addChild(_propsTable);
		}
		
		internal function updateDisplay():void {
			var angle:Number = _angle + _radians;
			var xpos:Number = Math.cos(angle) * _radius;
			_zpos = _orgZPos + Math.sin(angle) * _radius;
			var scaleRatio:Number = _focalLength / (_focalLength + _zpos);
			x = xpos * scaleRatio;
			y = _orgYPos * scaleRatio;
			scaleX = scaleY = scaleRatio;
		}
		
		// make the associated data accessible
		public function get associatedData() { return _associatedData; }
		
		
		internal function get angle():Number { return _angle; }
		
		internal function set angle(value:Number):void {
			_angle = value;
		}
		
		internal function get radius():Number { return _radius; }
		
		internal function set radius(value:Number):void {
			_radius = value;
		}
		
		internal function get focalLength():int { return _focalLength; }
		
		internal function set focalLength(value:int):void {
			_focalLength = value;
		}
		
		internal function get radians():Number { return _radians; }
		
		internal function set radians(value:Number):void {
			_radians = value;
		}
		
		// must remain public for Array.sortOn() method in OBO_3DCarousel instance.
		public function get zpos():Number { return _zpos; }
		
		public function set zpos(value:Number):void {
			_orgZPos = value;
		}
		
		internal function set ypos(value:Number):void {
			_orgYPos = value;
		}
		
		internal function get data():BitmapData { return _data; }
	}
}