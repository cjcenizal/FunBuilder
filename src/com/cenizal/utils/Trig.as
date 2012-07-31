package com.cenizal.utils
{
	import flash.geom.Point;

	public class Trig
	{
		public static const QUARTER_PI:Number = Math.PI * .25;
		public static const HALF_PI:Number = Math.PI * .5;
		public static const THREE_QUARTER_PI:Number = Math.PI * .75;
		public static const ONE_AND_QUARTER_PI:Number = Math.PI * 1.25;
		public static const ONE_AND_HALF_PI:Number = Math.PI * 1.5;
		public static const ONE_AND_THREE_QUARTERS_PI:Number = Math.PI * 1.75;
		
		public static function thetaFrom( p1:Point, p2:Point ):Number {
			return Math.atan2( p2.x - p1.x, p2.y - p1.y );
		}
	}
}