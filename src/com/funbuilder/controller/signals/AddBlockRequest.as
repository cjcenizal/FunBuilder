package com.funbuilder.controller.signals
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.model.vo.AddBlockVO;
	
	import org.osflash.signals.Signal;
	
	public class AddBlockRequest extends Signal
	{
		public function AddBlockRequest()
		{
			super( AddBlockVO );
		}
	}
}