package com.funbuilder.model
{
	import flash.geom.Point;
	
	import org.robotlegs.mvcs.Actor;
	
	public class MouseModel extends Actor
	{
		
		// Mouse movement.
		private var _prevPosition:Point = null;
		private var _downPosition:Point = new Point();
		private var _currPosition:Point = new Point();
		
		private var _mouseDown:Boolean = false;
		private var _rightMouseDown:Boolean = false;
		
		public function MouseModel()
		{
			super();
		}
		
		public function setMouseDown( x:Number, y:Number ):void {
			_mouseDown = true;
			doMouseDown( x, y );
		}
		
		public function setRightMouseDown( x:Number, y:Number ):void {
			_rightMouseDown = true;
			doMouseDown( x, y );
		}
		
		private function doMouseDown( x:Number, y:Number ):void {
			_prevPosition = new Point( x, y );
			_downPosition.x = x;
			_downPosition.y = y;
			_currPosition.x = x;
			_currPosition.y = y;
		}
		
		public function setMouseUp():void {
			_mouseDown = false;
			_rightMouseDown = false;
			_prevPosition = null;
		}
		
		public function updatePrevPosition( x:Number, y:Number ):void {
			if ( _prevPosition ) {
				_prevPosition.x = x;
				_prevPosition.y = y;
			}
		}
		
		public function moveMouse( x:Number, y:Number ):void {
			_currPosition.x = x;
			_currPosition.y = y;
		}
		
		public function get mouseDown():Boolean {
			return _mouseDown;
		}
		
		public function get rightMouseDown():Boolean {
			return _rightMouseDown;
		}
		
		public function get canClick():Boolean {
			return ( _currPosition.subtract( _downPosition ).length < 10 );
		}
		
		public function get prevPosition():Point {
			return _prevPosition;
		}
	}
}