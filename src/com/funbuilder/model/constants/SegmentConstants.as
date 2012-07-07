package com.funbuilder.model.constants
{
	public class SegmentConstants
	{
		public static const BLOCK_SIZE:int = 100;
		public static const NUM_BLOCKS_WIDE:int = 12;
		public static const NUM_BLOCKS_DEPTH:int = 24;
		public static const SEGMENT_WIDTH:int = NUM_BLOCKS_WIDE * BLOCK_SIZE;
		public static const SEGMENT_DEEP:int = NUM_BLOCKS_DEPTH * BLOCK_SIZE;
		public static const SEGMENT_HALF_WIDTH:Number = SEGMENT_WIDTH * .5;
		public static const SEGMENT_HALF_DEPTH:Number = SEGMENT_DEEP * .5;
	}
}