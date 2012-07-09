package com.funbuilder.model.vo
{
	import away3d.entities.Mesh;

	public class AddElevationIndicatorVO
	{
		
		public var indicator:Mesh;
		public var isPositive:Boolean;
		
		public function AddElevationIndicatorVO( indicator:Mesh, isPositive:Boolean )
		{
			this.indicator = indicator;
			this.isPositive = isPositive;
		}
	}
}