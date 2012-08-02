package com.funbuilder.controller.signals
{
	import flash.geom.Point;
	
	import org.osflash.signals.Signal;
	
	public class DrawHandlesRequest extends Signal
	{
		public function DrawHandlesRequest()
		{
			super( Point, Point, uint, Point, Point, uint, Point, Point, uint );
		}
	}
}