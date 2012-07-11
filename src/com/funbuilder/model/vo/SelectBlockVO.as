package com.funbuilder.model.vo
{
	import away3d.entities.Mesh;

	public class SelectBlockVO
	{
		
		public var block:Mesh;
		
		public function SelectBlockVO( block:Mesh )
		{
			this.block = block;
		}
	}
}