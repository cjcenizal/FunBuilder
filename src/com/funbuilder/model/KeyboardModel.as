package com.funbuilder.model
{
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Actor;
	
	public class KeyboardModel extends Actor
	{
		
		public var keysDown:Object = {};
		public var shift:Boolean = false;
		public var command:Boolean = false;
		public var alt:Boolean = false;
		public var control:Boolean = false;
		
		public function KeyboardModel()
		{
			super();
		}
		
		public function contains( keyCode:int ):Boolean {
			return keysDown[ keyCode ];
		}
		
		public function get isSpaceDown():Boolean {
			return keysDown[ Keyboard.SPACE ];
		}
		
		public function clearModifiers():void {
			shift = command = alt = control = false;
		}
	}
}