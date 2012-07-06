package com.funbuilder.view.components {
	
	import com.bit101.components.Component;
	
	import flash.display.DisplayObjectContainer;
	
	public class MainView extends Component {
		
		//private var _mainMenu:MainMenuView;
		
		public function MainView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
		}
		
		override protected function init():void {
			super.init();
			//_mainMenu = new MainMenuView( this );
		}
		/*
		public function hideAll():void {
			_mainMenu.visible = false;
			_game.visible = false;
		}
		
		public function showGame():void {
			_mainMenu.visible = false;
			_game.visible = true;
		}
		
		public function showMainMenu():void {
			_mainMenu.visible = true;
			_game.visible = false;
		}*/
	}
}
