package com.funbuilder.view.components
{
	import com.bit101.components.Component;
	import com.bit101.components.Panel;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class LibraryView extends Component
	{
		
		private var _bg:Panel;
		
		public function LibraryView( parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0 )
		{
			super( parent, xpos, ypos );
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
	}
}