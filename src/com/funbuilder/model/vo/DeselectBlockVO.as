package com.funbuilder.model.vo
{
	import away3d.entities.Mesh;

	public class DeselectBlockVO
	{
		
		public var block:Mesh;
		
		public function DeselectBlockVO( block:Mesh )
		{
			this.block = block;
		}
	}
}