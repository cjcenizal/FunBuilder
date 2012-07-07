package com.funbuilder.model
{
	import away3d.entities.Mesh;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * CurrentSegmentModel contains the current segment
	 * the user is editing.
	 */
	public class CurrentSegmentModel extends Actor
	{
		
		private var _blocks:Object = {};
		
		public function CurrentSegmentModel()
		{
			super();
		}
		
		public function add( block:Mesh ):void {
			var hash:String = makeHash( block.position );
			_blocks[ hash ] = block;
		}
		
		public function getAtPos( pos:Vector3D ):Mesh {
			return _blocks[ makeHash( pos ) ];
		}
		
		private function makeHash( pos:Vector3D ):String {
			return pos.x.toString() + "," + pos.y.toString() + "," + pos.z.toString();
		}
	}
}