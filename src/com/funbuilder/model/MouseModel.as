package com.funbuilder.model
{
	import org.robotlegs.mvcs.Actor;
	
	public class MouseModel extends Actor
	{
		
		public var mouseDown:Boolean = false;
		public var rightMouseDown:Boolean = false;
		
		public function MouseModel()
		{
			super();
		}
	}
}