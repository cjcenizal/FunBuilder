package com.funbuilder.model.vo
{
	import away3d.entities.Mesh;

	public class SelectBlockVo
	{
		
		public var block:Mesh;
		public var multipleSelect:Boolean;
		public var saveHistory:Boolean;
		
		public function SelectBlockVo( block:Mesh, multipleSelect:Boolean = false, saveHistory:Boolean = true )
		{
			this.block = block;
			this.multipleSelect = multipleSelect;
			this.saveHistory = saveHistory;
		}
	}
}