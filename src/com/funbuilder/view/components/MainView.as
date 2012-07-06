package com.funbuilder.view.components {
	
	import com.bit101.components.Component;
	
	import flash.display.DisplayObjectContainer;
	
	public class MainView extends Component {
		
		private var _menuBar:MenuBarView;
		
		public function MainView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
		}
		
		override protected function init():void {
			super.init();
			_menuBar = new MenuBarView( this );
		}
	}
}
