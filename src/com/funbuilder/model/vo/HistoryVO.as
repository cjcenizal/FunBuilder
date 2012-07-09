package com.funbuilder.model.vo
{
	import flash.geom.Vector3D;

	public class HistoryVO
	{
		
		public var snapshot:String;
		public var selectedBlockKey:String;
		
		public function HistoryVO( snapshot:String, selectedBlockKey:String )
		{
			this.snapshot = snapshot;
			this.selectedBlockKey = selectedBlockKey;
		}
	}
}