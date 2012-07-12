package com.funbuilder.model
{
	import org.robotlegs.mvcs.Actor;
	
	public class KeysModel extends Actor
	{
		
		public var keysDown:Object = {};
		public var isShiftDown:Boolean = false;
		public var isCommandDown:Boolean = false;
		public var isAltDown:Boolean = false;
		public var isControlDown:Boolean = false;
		
		public function KeysModel()
		{
			super();
		}
		
		public function contains( keyCode:int ):Boolean {
			return keysDown[ keyCode ];
		}
	}
}