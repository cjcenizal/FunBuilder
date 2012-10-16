package com.funbuilder.view.components
{
	import com.bit101.components.Component;
	import com.bit101.components.Label;
	import com.bit101.components.Panel;
	import com.funrun.model.vo.BlockTypeVo;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class LibraryView extends Component
	{
		
		public const EVENT_SELECT:String = "EVENT_SELECT";
		
		private var _bg:Panel;
		private var _items:Array;
		public var selected:BlockTypeVo;
		
		public function LibraryView( parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0 )
		{
			super( parent, xpos, ypos );
			_items = [];
		}
		
		override protected function init():void {
			super.init();
			_bg = new Panel( this );
		}
		
		public function setup():void {
			_bg.setSize( stage.stageWidth, 103 );
			_bg.draw();
			setSize( _bg.width, _bg.height );
		}
		
		public function addItem( data:BlockTypeVo, bitmap:Bitmap ):void {
			var xpos:Number = ( _items.length > 0 ) ? _items[ _items.length - 1 ].x + _items[ _items.length - 1 ].width + 3 : 3;
			var sprite:Sprite = new Sprite();
			sprite.addChild( bitmap );
			var label:Label = new Label( sprite, 0, 0, data.id );
			label.draw();
			label.x = ( bitmap.width - label.width ) * .5;
			label.y = bitmap.height - label.height;
			addChild( sprite );
			sprite.x = xpos;
			sprite.y = 3
			_items.push( sprite );
			sprite.addEventListener( MouseEvent.CLICK, getOnMouseDown( data ) );
		}
		
		private function getOnMouseDown( data:BlockTypeVo ):Function {
			var self:LibraryView = this;
			return function( e:MouseEvent ):void {
				self.selected = data;
				self.dispatchEvent( new Event( self.EVENT_SELECT ) );
			}
		}
	}
}