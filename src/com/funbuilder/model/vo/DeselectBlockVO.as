package com.funbuilder.model.vo
{
	import away3d.entities.Mesh;

	public class DeselectBlockVo
	{
		
		public var block:Mesh;
		public var saveHistory:Boolean;
		
		public function DeselectBlockVo( block:Mesh, saveHistory:Boolean = true )
		{
			this.block = block;
			this.saveHistory = saveHistory;
		}
	}
}