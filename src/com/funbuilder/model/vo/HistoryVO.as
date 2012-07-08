package com.funbuilder.model.vo
{
	import flash.geom.Vector3D;

	public class HistoryVO
	{
		
		public var snapshot:String;
		public var selectedBlock:Vector3D;
		
		public function HistoryVO( snapshot:String, selectedBlock:Vector3D )
		{
			this.snapshot = snapshot;
			this.selectedBlock = selectedBlock;
		}
	}
}