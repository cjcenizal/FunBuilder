package com.funbuilder.view.components {
	
	import com.bit101.components.Component;
	import com.bit101.components.Panel;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	public class MainView extends Component {
		
		private var _bg:Panel;
		private var _menuBar:MenuBarView;
		
		public function MainView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
		}
		
		override protected function init():void {
			super.init();
			_bg = new Panel( this );
			_menuBar = new MenuBarView( this );
			this.addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( e:Event ):void {
			_bg.setSize( stage.stageWidth, 20 );
		}
	}
}
