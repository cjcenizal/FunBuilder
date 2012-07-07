package com.funbuilder.view.components {
	
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	
	import com.funbuilder.model.constants.SegmentConstants;
	import com.bit101.components.Component;
	import com.bit101.components.Panel;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class MainView extends Component {
		
		private var _view:View3D;
		private var _isDebugging:Boolean = false;
		private var _awayStats:AwayStats;
		private var _bg:Panel;
		private var _menuBar:MenuBarView;
		private var cameraController:HoverController;
		
		// Camera control.
		private var _move:Boolean = false;
		private var lastPanAngle:Number;
		private var lastTiltAngle:Number;
		private var lastMouseX:Number;
		private var lastMouseY:Number;
		
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
				
				var target:Mesh = new Mesh();
				target.x = SegmentConstants.SEGMENT_HALF_WIDTH;
				target.z = SegmentConstants.SEGMENT_HALF_DEPTH;
				_view.scene.addChild( target );
				cameraController = new HoverController( _view.camera, target, 45, 10, 800 );
				addEventListener( Event.ENTER_FRAME, onEnterFrame );
				stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
				stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			}
		}
		
		/**
		 * Navigation and render loop
		 */
		private function onEnterFrame( event:Event ):void {
			if ( _move ) {
				cameraController.panAngle = 0.3 * ( stage.mouseX - lastMouseX ) + lastPanAngle;
				cameraController.tiltAngle = 0.3 * ( stage.mouseY - lastMouseY ) + lastTiltAngle;
			}
		}
		
		/**
		 * Mouse down listener for navigation
		 */
		private function onMouseDown( event:MouseEvent ):void {
			lastPanAngle = cameraController.panAngle;
			lastTiltAngle = cameraController.tiltAngle;
			lastMouseX = stage.mouseX;
			lastMouseY = stage.mouseY;
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
	}
}
