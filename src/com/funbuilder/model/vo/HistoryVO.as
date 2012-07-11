package com.funbuilder.model.vo
{
	import flash.geom.Vector3D;

	public class HistoryVO
	{
		
		public var snapshot:String;
		public var selectedBlockKeys:Array;
		
		public function HistoryVO( snapshot:String, selectedBlockKeys:Array )
		{
			this.snapshot = snapshot;
			this.selectedBlockKeys = selectedBlockKeys;
		}
	}
}