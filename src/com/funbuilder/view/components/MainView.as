package com.funbuilder.view.components {
	
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	
	import com.bit101.components.Component;
	import com.bit101.components.Panel;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class MainView extends Component {
		
		public var onKeyDownSignal:Signal;
		public var onKeyUpSignal:Signal;
		public var onScrollWheelSignal:Signal;
		public var onStageClickSignal:Signal;
		public var onMouseDownSignal:Signal;
		public var onMouseUpSignal:Signal;
		public var onRightMouseDownSignal:Signal;
		public var onRightMouseUpSignal:Signal;
		
		private var _view:View3D;
		private var _isDebugging:Boolean = false;
		private var _awayStats:AwayStats;
		private var _bg:Panel;
		private var _menuBar:MenuBarView;
		private var _library:LibraryView;
		
		private var _mouseDownTimestamp:int = 0;
		
		public function MainView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
		}
		
		override protected function init():void {
			super.init();
			onKeyDownSignal = new Signal();
			onKeyUpSignal = new Signal();
			onScrollWheelSignal = new Signal();
			onStageClickSignal = new Signal();
			onMouseDownSignal = new Signal();
			onMouseUpSignal = new Signal();
			onRightMouseDownSignal = new Signal();
			onRightMouseUpSignal = new Signal();
			
			_bg = new Panel( this );
			_menuBar = new MenuBarView( this );
			_library = new LibraryView( this );
			_library.visible = false;
			this.addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( e:Event ):void {
			_bg.setSize( stage.stageWidth, 20 );
			_library.setup();
			_library.y = stage.stageHeight - _library.height;
			stage.addEventListener( Event.RESIZE, onStageResize );
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			stage.addEventListener( MouseEvent.RIGHT_MOUSE_DOWN, onRightMouseDown );
			stage.addEventListener( MouseEvent.RIGHT_MOUSE_UP, onRightMouseUp );
			stage.addEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel );
		}
		
		private function onStageResize( e:Event ):void {
			_library.y = stage.stageHeight - _library.height;
		}
		
		public function showLibrary( visible:Boolean ):void {
			_library.visible = visible;
		}
		
		/**
		 * Add debugging UI.
		 */
		public function debug( doDebug:Boolean ):void {
			_isDebugging = doDebug;
			if ( !_isDebugging ) {
				if ( _awayStats ) {
					_awayStats.registerView( null );
					removeChild( _awayStats );
					_awayStats = null;
				}
			} else {
				if ( !_awayStats ) {
					_awayStats = new AwayStats( _view );
					addChildAt( _awayStats, 1 );
					_awayStats.y = stage.stageHeight - _awayStats.height;
				}
			}
		}
		
		public function set view3D( view:View3D ):void {
			if ( _view ) {
				removeChild( _view );
				_view = null;
			}
			if ( view ) {
				_view = view;
				addChildAt( _view, 0 );
				if ( _awayStats ) {
					_awayStats.registerView( _view );
				}
			}
		}
		
		private function onRightMouseDown( event:MouseEvent ):void {
			onRightMouseDownSignal.dispatch();
		}
		
		private function onRightMouseUp( event:MouseEvent ):void {
			onRightMouseUpSignal.dispatch();
		}
		
		/**
		 * Mouse down listener for navigation
		 */
		private function onMouseDown( event:MouseEvent ):void {
			_mouseDownTimestamp = new Date().time;
			onMouseDownSignal.dispatch();
		}
		
		/**
		 * Mouse up listener for navigation
		 */
		private function onMouseUp( event:MouseEvent ):void {
			var clickTime:int = new Date().time - _mouseDownTimestamp;
			if ( clickTime < 200 ) {
				onStageClickSignal.dispatch();
			}
			onMouseUpSignal.dispatch();
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			stage.focus = stage;
			onKeyDownSignal.dispatch( e );
		}
		
		private function onKeyUp( e:KeyboardEvent ):void {
			onKeyUpSignal.dispatch( e );
		}
		
		private function onMouseWheel( e:MouseEvent ):void {
			onScrollWheelSignal.dispatch( e.delta );
		}
	}
}
