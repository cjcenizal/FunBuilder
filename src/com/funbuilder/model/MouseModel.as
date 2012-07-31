package com.funbuilder.model
{
	import flash.geom.Point;
	
	import org.robotlegs.mvcs.Actor;
	
	public class MouseModel extends Actor
	{
		
		public var mouseDown:Boolean = false;
		public var rightMouseDown:Boolean = false;
		public var prev:Point = new Point();
		
		public function MouseModel()
		{
			super();
		}
	}
}