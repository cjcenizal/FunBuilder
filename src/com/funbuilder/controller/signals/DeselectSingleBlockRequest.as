package com.funbuilder.controller.signals
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.model.vo.SelectBlockVO;
	
	import org.osflash.signals.Signal;
	
	public class DeselectSingleBlockRequest extends Signal
	{
		public function DeselectSingleBlockRequest()
		{
			super( SelectBlockVO );
		}
	}
}