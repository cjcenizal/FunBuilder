package com.funbuilder.model
{
	import away3d.entities.Mesh;
	
	import com.funrun.model.vo.BlockVO;
	
	import org.robotlegs.mvcs.Actor;
	
	public class BrushModel extends Actor
	{
		
		private var _data:BlockVO;
		private var _preview:Mesh;
		
		private var _count:int = 0;
		private var _interval:int = 4;
		
		public function BrushModel()
		{
			super();
		}
		
		public function select( data:BlockVO ):void {
			_data = data;
			_preview = data.mesh.clone() as Mesh;
			_count = _interval;
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
			_count == _interval;
		}
		
		public function get data():BlockVO {
			return _data;
		}
		
		public function get preview():Mesh {
			return _preview;
		}
	}
}