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
		
		private var _bg:Panel;
		private var _menuBar:MenuBarView;
		private var _library:LibraryView;
		private var _handlesLayer:Sprite;
		
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
			
			_handlesLayer = new Sprite();
			addChild( _handlesLayer );
			_handlesLayer.mouseEnabled = false;
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
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
		}
		
		private function onStageResize( e:Event ):void {
			_library.y = stage.stageHeight - _library.height;
		}
		
		public function showLibrary( visible:Boolean ):void {
			_library.visible = visible;
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
		
		public function drawHandles( originX:Point, arrowX:Point, colorX:uint,
									 originY:Point, arrowY:Point, colorY:uint, 
									 originZ:Point, arrowZ:Point, colorZ:uint ):void {
			
			var radius:Number = 30;
			var alpha:Number = .3;
			var lineAlpha:Number = .4;
			
			var g:Graphics = _handlesLayer.graphics;
			g.clear();
			
			g.lineStyle( 2, colorX, lineAlpha );
			g.moveTo( originX.x, originX.y );
			g.lineTo( arrowX.x, arrowX.y );
			g.beginFill( colorX, alpha );
			g.drawCircle( arrowX.x, arrowX.y, radius );
			
			g.lineStyle( 2, colorY, lineAlpha );
			g.moveTo( originY.x, originY.y );
			g.lineTo( arrowY.x, arrowY.y );
			g.beginFill( colorY, alpha );
			g.drawCircle( arrowY.x, arrowY.y, radius );
			
			g.lineStyle( 2, colorZ, lineAlpha );
			g.moveTo( originZ.x, originZ.y );
			g.lineTo( arrowZ.x, arrowZ.y );
			g.beginFill( colorZ, alpha );
			g.drawCircle( arrowZ.x, arrowZ.y, radius );
			
			g.endFill();
		}
	}
}
