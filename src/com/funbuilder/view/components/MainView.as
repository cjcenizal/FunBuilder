package com.funbuilder.view.components {
	
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	
	import com.bit101.components.Component;
	import com.bit101.components.Panel;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
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
		public var onMouseMoveSignal:Signal;
		public var onHandleMouseDownSignal:Signal;
		
		private var _bg:Panel;
		private var _menuBar:MenuBarView;
		private var _library:LibraryView;
		
		// Handles.
		private var _handlesLayer:Sprite;
		private var _handleX:Sprite;
		private var _handleY:Sprite;
		private var _handleZ:Sprite;
		
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
			onMouseMoveSignal = new Signal();
			onHandleMouseDownSignal = new Signal();
			
			_handlesLayer = new Sprite();
			addChild( _handlesLayer );
			_handlesLayer.mouseEnabled = false;
			_handleX = addHandle( 0xff0000 );
			_handleY = addHandle( 0x00ff00 );
			_handleZ = addHandle( 0x0000ff );
			_handleX.addEventListener( MouseEvent.MOUSE_DOWN, onHandleXMouseDown );
			_handleY.addEventListener( MouseEvent.MOUSE_DOWN, onHandleYMouseDown );
			_handleZ.addEventListener( MouseEvent.MOUSE_DOWN, onHandleZMouseDown );
			hideHandles();
			
			_bg = new Panel( this );
			_menuBar = new MenuBarView( this );
			_library = new LibraryView( this );
			_library.visible = false;
			this.addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function addHandle( color:uint ):Sprite {
			var handle:Sprite = new Sprite();
			addChild( handle );
			var alpha:Number = .3;
			var lineAlpha:Number = .4;
			handle.graphics.beginFill( color, lineAlpha );
			handle.graphics.lineStyle( 2, color, alpha );
			handle.graphics.drawCircle( 0, 0, 30 );
			return handle;
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
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
		}
		
		private function onStageResize( e:Event ):void {
			_library.y = stage.stageHeight - _library.height;
		}
		
		public function toggleLibrary():void {
			_library.visible = !_library.visible;
		}
		
		public function set view3D( view:View3D ):void {
			addChildAt( view, 0 );
			var awayStats:AwayStats = new AwayStats( view );
			addChildAt( awayStats, 1 );
			awayStats.y = stage.stageHeight - awayStats.height;
		}
		
		private function onRightMouseDown( event:MouseEvent ):void {
			onRightMouseDownSignal.dispatch();
		}
		
		private function onRightMouseUp( event:MouseEvent ):void {
			onRightMouseUpSignal.dispatch();
		}
		
		private function onMouseDown( event:MouseEvent ):void {
			_mouseDownTimestamp = new Date().time;
			onMouseDownSignal.dispatch();
		}
		
		private function onMouseUp( event:MouseEvent ):void {
			var clickTime:int = new Date().time - _mouseDownTimestamp;
			if ( clickTime < 200 ) {
				onStageClickSignal.dispatch();
			}
			onMouseUpSignal.dispatch();
		}
		
		private function onMouseMove( e:MouseEvent ):void {
			onMouseMoveSignal.dispatch();
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
		
		private function onHandleXMouseDown( e:MouseEvent ):void {
			onHandleMouseDownSignal.dispatch( "x" );
		}
		
		private function onHandleYMouseDown( e:MouseEvent ):void {
			onHandleMouseDownSignal.dispatch( "y" );
		}
		
		private function onHandleZMouseDown( e:MouseEvent ):void {
			onHandleMouseDownSignal.dispatch( "z" );
		}
		
		public function hideHandles():void {
			_handleX.visible = _handleY.visible = _handleZ.visible = false;
			_handlesLayer.graphics.clear();
		}
		
		public function drawHandles( originX:Point, arrowX:Point, colorX:uint,
									 originY:Point, arrowY:Point, colorY:uint, 
									 originZ:Point, arrowZ:Point, colorZ:uint ):void {
			
			_handleX.visible = _handleY.visible = _handleZ.visible = true;
			
			var alpha:Number = .3;
			var lineAlpha:Number = .4;
			
			var g:Graphics = _handlesLayer.graphics;
			g.clear();
			
			g.lineStyle( 2, colorX, lineAlpha );
			g.moveTo( originX.x, originX.y );
			g.lineTo( arrowX.x, arrowX.y );
			_handleX.x = arrowX.x;
			_handleX.y = arrowX.y;
			
			g.lineStyle( 2, colorY, lineAlpha );
			g.moveTo( originY.x, originY.y );
			g.lineTo( arrowY.x, arrowY.y );
			_handleY.x = arrowY.x;
			_handleY.y = arrowY.y;
			
			g.lineStyle( 2, colorZ, lineAlpha );
			g.moveTo( originZ.x, originZ.y );
			g.lineTo( arrowZ.x, arrowZ.y );
			_handleZ.x = arrowZ.x;
			_handleZ.y = arrowZ.y;
			
			g.endFill();
		}
	}
}
