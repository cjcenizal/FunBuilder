package com.funbuilder.model
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.model.constants.Grid;
	import com.funrun.model.vo.BlockTypeVo;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;
	
	public class BrushModel extends Actor
	{
		
		private var _data:BlockTypeVo;
		private var _preview:Mesh;
		private var _prevPosition:Vector3D = new Vector3D();
		
		private var _count:int = 0;
		private var _interval:int = 10;
		
		public function BrushModel()
		{
			super();
		}
		
		public function select( data:BlockTypeVo, mesh:Mesh ):void {
			_data = data;
			_preview = mesh;
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
			if ( _preview ) {
				var snappedPrev:Vector3D = _prevPosition.clone();
				Grid.snapPositionToGrid( snappedPrev );
				var snappedCurr:Vector3D = _preview.position.clone();
				Grid.snapPositionToGrid( snappedCurr );
				snappedCurr.y = snappedPrev.y;
				return ( !snappedPrev.equals( snappedCurr ) );
			}
			return false;
		}
		
		public function get data():BlockTypeVo {
			return _data;
		}
		
		public function get preview():Mesh {
			return _preview;
		}
	}
}