package com.funbuilder.view.components {

	import com.bit101.components.ComboBox;
	import com.bit101.components.Component;
	import com.bit101.components.Label;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	public class MenuBarView extends Component {

		public static const EVENT_NEW:String = "new";
		public static const EVENT_OPEN:String = "open";
		public static const EVENT_SAVE:String = "save";
		public static const EVENT_UNDO:String = "undo";
		public static const EVENT_REDO:String = "redo";
		
		private var _menus:Array;
		private var _menusObj:Object;
		private var _fileLabel:Label;
		private var _selectionIndicator:Shape;
		
		public function MenuBarView( parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0 ) {
			super( parent, xpos, ypos );
		}
		
		override protected function init():void {
			super.init();
			_menus = [];
			_menusObj = {};
			addMenu( "File",
				[
					new MenuItemVO( "New (Cmd-N)", getDispatchEvent( EVENT_NEW ) ),
					new MenuItemVO( "Open (Cmd-O)", getDispatchEvent( EVENT_OPEN ) ),
					new MenuItemVO( "Save (Cmd-S)", getDispatchEvent( EVENT_SAVE ) )
				] );
			addMenu( "Edit",
				[
					new MenuItemVO( "Undo (Cmd-Z)", getDispatchEvent( EVENT_UNDO ) ),
					new MenuItemVO( "Redo (ShftCmd-Z)", getDispatchEvent( EVENT_REDO ) )
				] );
			_fileLabel = new Label( this,  _menus[ _menus.length - 1 ].x + _menus[ _menus.length - 1 ].width + 20, 1 );
			this.addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( e:Event ):void {
			_selectionIndicator = new Shape();
			_selectionIndicator.y = _fileLabel.height + 2;
			addChild( _selectionIndicator );
			_selectionIndicator.graphics.beginFill( 0xffff00 );
			_selectionIndicator.graphics.drawRect( 0, 0, stage.stageWidth, 4 );
			_selectionIndicator.graphics.endFill();
			_selectionIndicator.visible = false;
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		}
		
		public function showFileName( name:String ):void {
			_fileLabel.text = name;
			_fileLabel.draw();
			_fileLabel.x = ( stage.stageWidth - _fileLabel.width ) * .5;
		}
		
		public function showSelectionIndicator( visible:Boolean ):void {
			_selectionIndicator.visible = visible;
		}
		
		private function addMenu( name:String, items:Array ):void {
			var posX:Number = ( _menus.length > 0 ) ? _menus[ _menus.length - 1 ].x + _menus[ _menus.length - 1 ].width : 0;
			var menu:ComboBox = new ComboBox( this, posX, 0, name, items );
			menu.addEventListener( Event.SELECT, onMenuItemSelect );
			_menus.push( menu );
			_menus[ name ] = menu;
		}
		
		private function onMenuItemSelect( e:Event ):void {
			for ( var i:int = 0; i < _menus.length; i++ ) {
				var menu:ComboBox = _menus[ i ] as ComboBox;
				if ( menu.selectedIndex >= 0 ) {
					( menu.selectedItem as MenuItemVO ).callback.apply();
					menu.selectedIndex = -1;
				}
			}
		}
		
		private function getDispatchEvent( event:String ):Function {
			var self:Component = this;
			return function():void {
				self.dispatchEvent( new Event( event ) );
			}
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			if ( e.commandKey ) {
				if ( e.shiftKey ) {
					switch ( e.keyCode ) {
						case 90: // z
							dispatchEvent( new Event( EVENT_REDO ) );
							break;
					}
				} else {
					switch ( e.keyCode ) {
						case 78: // n
							dispatchEvent( new Event( EVENT_NEW ) );
							break;
						case 83: // s
							dispatchEvent( new Event( EVENT_SAVE ) );
							break;
						case 79: // o
							dispatchEvent( new Event( EVENT_OPEN ) );
							break;
						case 90: // z
							dispatchEvent( new Event( EVENT_UNDO ) );
							break;
					}
				}
			}
		}
	}
}

class MenuItemVO {
	
	public var name:String;
	public var callback:Function;
	
	public function MenuItemVO( name:String, callback:Function ) {
		this.name = name;
		this.callback = callback;
	}
	
	public function toString():String {
		return name;
	}
}