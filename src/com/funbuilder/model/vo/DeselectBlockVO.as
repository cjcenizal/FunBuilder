package com.funbuilder.model.vo
{
	import away3d.entities.Mesh;

	public class DeselectBlockVO
	{
		
		public var block:Mesh;
		public var saveHistory:Boolean;
		
		public function DeselectBlockVO( block:Mesh, saveHistory:Boolean = true )
		{
			this.block = block;
			this.saveHistory = saveHistory;
		}
	}
}