package com.funbuilder.model
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.model.constants.SegmentConstants;
	import com.funrun.model.vo.BlockVO;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;
	
	public class BrushModel extends Actor
	{
		
		private var _data:BlockVO;
		private var _preview:Mesh;
		private var _prevPosition:Vector3D = new Vector3D();
		
		private var _count:int = 0;
		private var _interval:int = 10;
		
		public function BrushModel()
		{
			super();
		}
		
		public function select( data:BlockVO ):void {
			_data = data;
			_preview = data.mesh.clone() as Mesh;
			_count = 0;
		}
		
		public function deselect():void {
			_data = null;
			_preview = null;
		}
		
		public function canPlace():Boolean {
			_count++;
			if ( _count % _interval == 0 ) {
				_count = 0;
				return true;
			}
			return false;
		}
		
		public function resetPlacement():void {
			_count = 0;
		}
		
		public function movePreview( x:Number, y:Number, z:Number ):void {
			_prevPosition.x = _preview.x;
			_prevPosition.y = _preview.y;
			_prevPosition.z = _preview.z;
			_preview.x = x;
			_preview.y = y;
			_preview.z = z;
		}
		
		public function get hasMoved():Boolean {
			var snappedPrev:Vector3D = _prevPosition.clone();
			SegmentConstants.snapPositionToGrid( snappedPrev );
			var snappedCurr:Vector3D = _preview.position.clone();
			SegmentConstants.snapPositionToGrid( snappedCurr );
			snappedCurr.y = snappedPrev.y;
			return ( !snappedPrev.equals( snappedCurr ) );
		}
		
		public function get data():BlockVO {
			return _data;
		}
		
		public function get preview():Mesh {
			return _preview;
		}
	}
}