package com.funbuilder.controller.signals
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.model.vo.AddElevationIndicatorVO;
	
	import org.osflash.signals.Signal;
	
	public class AddElevationIndicatorRequest extends Signal
	{
		public function AddElevationIndicatorRequest()
		{
			super( AddElevationIndicatorVO );
		}
	}
}