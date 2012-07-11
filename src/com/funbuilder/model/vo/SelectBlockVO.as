package com.funbuilder.model.vo
{
	import away3d.entities.Mesh;

	public class SelectBlockVO
	{
		
		public var block:Mesh;
		public var multipleSelect:Boolean;
		public var saveHistory:Boolean;
		
		public function SelectBlockVO( block:Mesh, multipleSelect:Boolean = false, saveHistory:Boolean = true )
		{
			this.block = block;
			this.multipleSelect = multipleSelect;
			this.saveHistory = saveHistory;
		}
	}
}