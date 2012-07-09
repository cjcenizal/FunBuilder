package com.funbuilder.model.constants
{
	import flash.geom.Vector3D;

	public class SegmentConstants
	{
		public static const BLOCK_SIZE:int = 100;
		public static const NUM_BLOCKS_WIDE:int = 12;
		public static const NUM_BLOCKS_DEPTH:int = 24;
		public static const SEGMENT_WIDTH:int = NUM_BLOCKS_WIDE * BLOCK_SIZE;
		public static const SEGMENT_DEPTH:int = NUM_BLOCKS_DEPTH * BLOCK_SIZE;
		public static const SEGMENT_HALF_WIDTH:Number = SEGMENT_WIDTH * .5;
		public static const SEGMENT_HALF_DEPTH:Number = SEGMENT_DEPTH * .5;
		
		public static function snapPointGrid( x:Number, y:Number, z:Number ):Vector3D {
			var point:Vector3D = new Vector3D();
			point.x = snapToGrid( x - BLOCK_SIZE * .5 ) + BLOCK_SIZE * .5;
			point.y = snapToGrid( y - BLOCK_SIZE * .5 );
			point.z = snapToGrid( z - BLOCK_SIZE * .5 ) + BLOCK_SIZE * .5;
			return point;
		}
		
		private static function snapToGrid( val:Number ):int {
			return Math.round( val / BLOCK_SIZE ) * BLOCK_SIZE;
		}
		
	}
}