package com.funbuilder.model
{
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Actor;
	
	public class KeyboardModel extends Actor
	{
		
		public var shift:Boolean = false;
		public var command:Boolean = false;
		public var alt:Boolean = false;
		public var control:Boolean = false;
		
		private var _pressedKeys:Object;
		private var _blockedKeys:Object;
		
		public function KeyboardModel()
		{
			super();
			reset();
		}
		
		public function reset():void {
			_pressedKeys = {};
			_blockedKeys = {};
		}
		
		public function down( key:uint ):void {
			if ( !_blockedKeys[ key ] ) {
				_pressedKeys[ key ] = true;
			}
		}
		
		public function up( key:uint ):void {
			_pressedKeys[ key ] = false;
			_blockedKeys[ key ] = false;
		}
		
		public function block( key:uint ):void {
			if ( _pressedKeys[ key ] ) {
				_blockedKeys[ key ] = true;
				_pressedKeys[ key ] = false;
			}
		}
		
		public function isDown( key:uint ):Boolean {
			return _pressedKeys[ key ];
		}
		
		public function isUp( key:uint ):Boolean {
			return !_pressedKeys[ key ];
		}
		
		public function clearModifiers():void {
			shift = command = alt = control = false;
		}
	}
}