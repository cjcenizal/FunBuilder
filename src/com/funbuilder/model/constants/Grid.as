package com.funbuilder.model.constants
{
	import away3d.entities.Mesh;
	
	import com.funrun.model.constants.Block;
	import flash.geom.Vector3D;

	public class Grid
	{
		
		public static function snapObjectToGrid( obj:Mesh ):void {
			obj.x = snapToGrid( obj.x - Block.SIZE * .5 ) + Block.SIZE * .5;
			obj.y = snapToGrid( obj.y - Block.SIZE * .5 );
			obj.z = snapToGrid( obj.z - Block.SIZE * .5 ) + Block.SIZE * .5;
		}
		
		public static function snapPositionToGrid( pos:Vector3D ):void {
			pos.x = snapToGrid( pos.x - Block.SIZE * .5 ) + Block.SIZE * .5;
			pos.y = snapToGrid( pos.y - Block.SIZE * .5 );
			pos.z = snapToGrid( pos.z - Block.SIZE * .5 ) + Block.SIZE * .5;
		}
		
		public static function snapPointGrid( x:Number, y:Number, z:Number ):Vector3D {
			var point:Vector3D = new Vector3D();
			point.x = snapToGrid( x - Block.SIZE * .5 ) + Block.SIZE * .5;
			point.y = snapToGrid( y - Block.SIZE * .5 );
			point.z = snapToGrid( z - Block.SIZE * .5 ) + Block.SIZE * .5;
			return point;
		}
		
		private static function snapToGrid( val:Number ):int {
			return Math.round( val / Block.SIZE ) * Block.SIZE;
		}
		
	}
}