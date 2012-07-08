package com.funbuilder.view.components
{
	import com.bit101.components.Component;
	import com.bit101.components.Panel;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class LibraryView extends Component
	{
		
		private var _bg:Panel;
		private var _items:Array;
		
		public function LibraryView( parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0 )
		{
			super( parent, xpos, ypos );
			_items = [];
		}
		
		override protected function init():void {
			super.init();
			_bg = new Panel( this, 0, 0 );
		}
		
		public function setup():void {
			_bg.setSize( stage.stageWidth, 100 );
			_bg.draw();
			setSize( _bg.width, _bg.height );
		}
		
		public function addItem( id:String, bitmap:Bitmap ):void {
			var xpos:Number = ( _items.length > 0 ) ? _items[ _items.length - 1 ].x + _items[ _items.length - 1 ].width : 0
			addChild( bitmap );
			bitmap.x = xpos;
			_items.push( bitmap );
		}
	}
}