package com.funbuilder.view.components {
	
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	
	import com.bit101.components.Component;
	import com.bit101.components.Panel;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	
	import org.osflash.signals.Signal;
	
	public class MainView extends Component {
		
		public var onKeyDownSignal:Signal;
		public var onKeyUpSignal:Signal;
		public var onScrollWheelSignal:Signal;
		
		private var _keysDown:Object = {};
		
		private var _view:View3D;
		private var _isDebugging:Boolean = false;
		private var _awayStats:AwayStats;
		private var _bg:Panel;
		private var _menuBar:MenuBarView;
		private var _library:LibraryView;
		private var _cameraController:HoverController;
		private var _target:Mesh;
		
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
				stage.addEventListener( MouseEvent.RIGHT_MOUSE_DOWN, onMouseRightClick );
			} else {
				stage.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
				stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
				stage.removeEventListener( MouseEvent.RIGHT_MOUSE_DOWN, onMouseRightClick );
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
		
		public function set target( t:Mesh ):void {
			_target = t;
			linkTargetToCamera();
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
				linkTargetToCamera();
			}
		}
		
		private function linkTargetToCamera():void {
			if ( _view && _target ) {
				_view.scene.addChild( _target );
				_cameraController = new HoverController( _view.camera, _target, 45, 10, 800 );
				_cameraController.steps = 1;
			}
		}
		
		/**
		 * Navigation and render loop
		 */
		private function onEnterFrame( event:Event ):void {
			if ( _view && _target ) {
				if ( _move ) {
					_cameraController.panAngle = .35 * ( stage.mouseX - _lastMouseX ) + _lastPanAngle;
					_cameraController.tiltAngle = .35 * ( stage.mouseY - _lastMouseY ) + _lastTiltAngle;
				}
				var divDegToRad:Number = 180 * Math.PI;
				var rads:Number = _cameraController.panAngle / divDegToRad;
				
				var camPos:Vector3D = _view.camera.position;
				var adjCamPos:Vector3D = new Vector3D( camPos.x, 0, camPos.z );
				var theta:Number = getTheta( camPos, _target.position );
				var speed:Number = 20;
				
				for ( var key:String in _keysDown ) {
					var moveX:Number = 0;
					var moveY:Number = 0;
					var moveZ:Number = 0;
					switch ( int( key ) ) {
						case Keyboard.W:
							// Move towards target along ground plane.
							moveX = Math.cos( theta ) * -speed;
							moveZ = Math.sin( theta ) * -speed;
							break;
						case Keyboard.S:
							// Move away from target along ground plane.
							moveX = Math.cos( theta ) * speed;
							moveZ = Math.sin( theta ) * speed;
							break;
						case Keyboard.A:
							// Strafe left along ground plane.
							moveX = Math.cos( theta + Math.PI * .5 ) * -speed;
							moveZ = Math.sin( theta + Math.PI * .5 ) * -speed;
							break;
						case Keyboard.D:
							// Strafe right along ground plane.
							moveX = Math.cos( theta + Math.PI * .5 ) * speed;
							moveZ = Math.sin( theta + Math.PI * .5 ) * speed;
							break;
						case 189: // Minus
							// Decrease elevation.
							moveY = -speed;
							break;
						case 187: // Plus
							// Increase elevation.
							moveY = speed;
							break;
						case 219: // Left brace
							// Zoom out.
							_cameraController.distance += speed;
							break;
						case 221: // Right brace
							// Zoom in.
							if ( _cameraController.distance > speed * 2 ) {
								_cameraController.distance -= speed;
							}
							break;
					}
					_view.camera.position.x += moveX;
					_view.camera.position.y += moveY;
					_view.camera.position.z += moveZ;
					_target.x += moveX;
					_target.y += moveY;
					_target.z += moveZ;
				}
			}
		}
		
		private function getTheta( posA:Vector3D, posB:Vector3D ):Number {
			var deltaZ:Number = posA.z - posB.z;
			var deltaX:Number = posA.x - posB.x;
			var angle:Number = Math.atan2(deltaZ, deltaX);
			return angle;
		}
		
		/**
		 * Mouse down listener for navigation
		 */
		private function onMouseDown( event:MouseEvent ):void {
			if ( _view && _target ) {
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
			if ( !_keysDown[ e.keyCode ] ) {
				onKeyDownSignal.dispatch( e.keyCode );
			}
			if ( !e.commandKey && !e.shiftKey ) {
				_keysDown[ e.keyCode ] = true;
			}
		}
		
		private function onKeyUp( e:KeyboardEvent ):void {
			onKeyUpSignal.dispatch( e.keyCode );
			if ( !e.commandKey && !e.shiftKey ) {
				delete _keysDown[ e.keyCode ];
			}
		}
		
		private function onMouseRightClick( e:MouseEvent ):void {
			for ( var key:String in _keysDown ) {
				delete _keysDown[ key ];
			}
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
