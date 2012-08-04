package com.funbuilder.model
{
	import away3d.entities.Mesh;
	
	import com.funrun.model.vo.BlockVO;
	
	import org.robotlegs.mvcs.Actor;
	
	public class BrushModel extends Actor
	{
		
		public var data:BlockVO;
		public var preview:Mesh;
		
		public function BrushModel()
		{
			super();
		}
	}
}