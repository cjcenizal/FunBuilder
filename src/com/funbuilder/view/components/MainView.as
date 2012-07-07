package com.funbuilder.view.components {
	
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	
	import com.bit101.components.Component;
	import com.bit101.components.Panel;
	import com.funbuilder.model.constants.SegmentConstants;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	
	public class MainView extends Component {
		private const KEYS:Object = {
			W : 87,
			A : 65,
			S : 83,
			D : 68,
			Z : 90,
			X : 88
		}
		private const KEY_ACTIONS:Object = {};
		private var _currKey:int = -1;
		
		private var _view:View3D;
		private var _isDebugging:Boolean = false;
		private var _awayStats:AwayStats;
		private var _bg:Panel;
		private var _menuBar:MenuBarView;
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
			_bg = new Panel( this );
			_menuBar = new MenuBarView( this );
			this.addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( e:Event ):void {
			_bg.setSize( stage.stageWidth, 20 );
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
				addChild( _view );
				_view.y = 20;
				if ( _awayStats ) {
					_awayStats.registerView( _view );
				}
				
				_target = new Mesh();
				_target.x = SegmentConstants.SEGMENT_HALF_WIDTH;
				_target.z = SegmentConstants.SEGMENT_HALF_DEPTH;
				_view.scene.addChild( _target );
				_view.camera.z = -1000;
				_view.camera.y = 200;
				_cameraController = new HoverController( _view.camera, _target, 45, 10, 800 );
				_cameraController.steps = 1;
				addEventListener( Event.ENTER_FRAME, onEnterFrame );
				stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
				stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
				stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
				stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
				
				var amount:Number = 10;
				KEY_ACTIONS[ KEYS.W ] = getMoveCallback( 'z', amount );
				KEY_ACTIONS[ KEYS.A ] = getMoveCallback( 'x', -amount );
				KEY_ACTIONS[ KEYS.S ] = getMoveCallback( 'z', -amount );
				KEY_ACTIONS[ KEYS.D ] = getMoveCallback( 'x', amount );
			}
		}
		
		private function getMoveCallback( property:String, amount:Number ):Function {
			var t:Mesh = _target;
			return function():void {
				_target[ property ] += amount;
			}
		}
		
		/**
		 * Navigation and render loop
		 */
		private function onEnterFrame( event:Event ):void {
			if ( _move ) {
				_cameraController.panAngle = ( stage.mouseX - _lastMouseX ) + _lastPanAngle;
				_cameraController.tiltAngle = ( stage.mouseY - _lastMouseY ) + _lastTiltAngle;
			}
			var divDegToRad:Number = 180 * Math.PI;
			var rads:Number = _cameraController.panAngle / divDegToRad;
			
			var camPos:Vector3D = _view.camera.position;
			var adjCamPos:Vector3D = new Vector3D( camPos.x, 0, camPos.z );
			var theta:Number = getTheta( camPos, _target.position );
			var speed:Number = 20;
			var moveX:Number = 0;
			var moveZ:Number = 0;
			switch ( _currKey ) {
				case KEYS.W:
					// Move towards target along ground plane.
					break;
				case KEYS.S:
					// Move away from target along ground plane.
					break;
				case KEYS.A:
					// Strafe left along ground plane.
					moveX = Math.cos( theta + Math.PI * .5 ) * -speed;
					moveZ = Math.sin( theta + Math.PI * .5 ) * -speed;
					break;
				case KEYS.D:
					// Strafe right along ground plane.
					moveX = Math.cos( theta + Math.PI * .5 ) * speed;
					moveZ = Math.sin( theta + Math.PI * .5 ) * speed;
					break;
			}
			_view.camera.position.x += moveX;
			_view.camera.position.z += moveZ;
			_target.x += moveX;
			_target.z += moveZ;
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
			_lastPanAngle = _cameraController.panAngle;
			_lastTiltAngle = _cameraController.tiltAngle;
			_lastMouseX = stage.mouseX;
			_lastMouseY = stage.mouseY;
			_move = true;
			stage.addEventListener( Event.MOUSE_LEAVE, onStageMouseLeave );
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
			if ( e.shiftKey ) {
				_currKey = e.keyCode;
			}
		}
		
		private function onKeyUp( e:KeyboardEvent ):void {
			_currKey = -1;
		}
		
	}
}
