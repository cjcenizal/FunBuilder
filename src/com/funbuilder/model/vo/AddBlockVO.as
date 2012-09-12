package com.funbuilder.model.vo
{
	import away3d.entities.Mesh;

	public class AddBlockVo
	{
		
		public var mesh:Mesh;
		public var key:String;
		
		public function AddBlockVo( mesh:Mesh, key:String = null ) {
			this.mesh = mesh;
			this.key = key;
		}
	}
}