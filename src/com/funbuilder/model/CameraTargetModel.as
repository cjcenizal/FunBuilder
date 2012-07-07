package com.funbuilder.model
{
	import away3d.entities.Mesh;
	
	import org.robotlegs.mvcs.Actor;
	
	public class CameraTargetModel extends Actor
	{
		
		private var _target:Mesh;
		
		public function CameraTargetModel()
		{
			super();
		}
		
		public function set target( t:Mesh ):void {
			_target = t;
		}
	}
}