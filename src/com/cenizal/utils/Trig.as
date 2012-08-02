package com.cenizal.utils
{
	import flash.geom.Point;
	import flash.geom.Vector3D;

	public class Trig
	{
		public static const QUARTER_PI:Number = Math.PI * .25;
		public static const HALF_PI:Number = Math.PI * .5;
		public static const THREE_QUARTER_PI:Number = Math.PI * .75;
		public static const ONE_AND_QUARTER_PI:Number = Math.PI * 1.25;
		public static const ONE_AND_HALF_PI:Number = Math.PI * 1.5;
		public static const ONE_AND_THREE_QUARTERS_PI:Number = Math.PI * 1.75;
		
		public static function thetaFromPoints( p1:Point, p2:Point = null ):Number {
			p2 = p2 || new Point();
			return thetaFrom( p1.x, p1.y, p2.x, p2.y );
		}
		
		public static function thetaFrom( p1x:Number, p1y:Number, p2x:Number = 0, p2y:Number = 0 ):Number {
			return Math.atan2( p2x - p1x, p2y - p1y );
		}
		
		public static function getDistanceFromPoints( p1:Point, p2:Point ):Number {
			return ( p2.subtract( p1 ) ).length;
		}
	}
}