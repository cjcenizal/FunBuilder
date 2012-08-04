package com.funbuilder.model
{
	import away3d.entities.Mesh;
	
	import com.funrun.model.vo.BlockVO;
	
	import org.robotlegs.mvcs.Actor;
	
	public class BrushModel extends Actor
	{
		
		private var _data:BlockVO;
		private var _preview:Mesh;
		
		public function BrushModel()
		{
			super();
		}
		
		public function select( data:BlockVO ):void {
			_data = data;
			_preview = data.mesh.clone() as Mesh;
		}
		
		public function deselect():void {
			_data = null;
			_preview = null;
		}
		
		public function get data():BlockVO {
			return _data;
		}
		
		public function get preview():Mesh {
			return _preview;
		}
	}
}