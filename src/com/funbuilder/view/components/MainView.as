package com.funbuilder.view.components {
	
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
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
		
		private var _view:View3D;
		private var _isDebugging:Boolean = false;
		private var _awayStats:AwayStats;
		private var _bg:Panel;
		private var _menuBar:MenuBarView;
		private var _library:LibraryView;
		private var _cameraController:HoverController;
		
		// Camera control.
		private var _move:Boolean = false;
		private var _lastPanAngle:Number;
		private var _lastTiltAngle:Number;
		private var _lastMouseX:Number;
		private var _lastMouseY:Number;
		
		public function MainView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
		}
		
		override protected function init():void {
			super.init();
			onKeyDownSignal = new Signal();
			onKeyUpSignal = new Signal();
			onScrollWheelSignal = new Signal();
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
			stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			stage.addEventListener( Event.RESIZE, onStageResize );
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			stage.addEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel );
		}
		
		private function onStageResize( e:Event ):void {
			_library.y = stage.stageHeight - _library.height;
		}
		
		public function enableCameraControl( enabled:Boolean ):void {
			if ( enabled ) {
				stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
				stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			} else {
				stage.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
				stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			}
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
					addChild( _awayStats );
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
		
		public function set cameraController( controller:HoverController ):void {
			_cameraController = controller;
		}
		
		/**
		 * Navigation and render loop
		 */
		private function onEnterFrame( event:Event ):void {
			if ( _cameraController ) {
				if ( _move ) {
					_cameraController.panAngle = .35 * ( stage.mouseX - _lastMouseX ) + _lastPanAngle;
					_cameraController.tiltAngle = .35 * ( stage.mouseY - _lastMouseY ) + _lastTiltAngle;
				}
			}
		}
		
		/**
		 * Mouse down listener for navigation
		 */
		private function onMouseDown( event:MouseEvent ):void {
			if ( _cameraController ) {
				_lastPanAngle = _cameraController.panAngle;
				_lastTiltAngle = _cameraController.tiltAngle;
				_lastMouseX = stage.mouseX;
				_lastMouseY = stage.mouseY;
				_move = true;
				stage.addEventListener( Event.MOUSE_LEAVE, onStageMouseLeave );
			}
		}
		
		/**
		 * Mouse up listener for navigation
		 */
		private function onMouseUp( event:MouseEvent ):void {
			_move = false;
			stage.removeEventListener( Event.MOUSE_LEAVE, onStageMouseLeave );
		}
		
		/**
		 * Mouse stage leave listener for navigation
		 */
		private function onStageMouseLeave( event:Event ):void {
			_move = false;
			stage.removeEventListener( Event.MOUSE_LEAVE, onStageMouseLeave );
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			onKeyDownSignal.dispatch( e.keyCode );
		}
		
		private function onKeyUp( e:KeyboardEvent ):void {
			onKeyUpSignal.dispatch( e.keyCode );
		}
		
		private function onMouseWheel( e:MouseEvent ):void {
			var amount:Number = e.delta * 8;
			if ( _cameraController.distance > amount ) {
				_cameraController.distance -= amount;
			}
			onScrollWheelSignal.dispatch( e.delta );
		}
	}
}
