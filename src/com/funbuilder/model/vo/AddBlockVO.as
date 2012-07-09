package com.funbuilder.model.vo
{
	import away3d.entities.Mesh;

	public class AddBlockVO
	{
		
		public var mesh:Mesh;
		public var id:String;
		public var key:String;
		
		public function AddBlockVO( mesh:Mesh, id:String, key:String = null )
		{
			this.mesh = mesh;
			this.id = id;
			this.key = key;
		}
	}
}