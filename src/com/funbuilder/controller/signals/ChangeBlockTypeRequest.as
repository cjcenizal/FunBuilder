package com.funbuilder.controller.signals
{
	import com.funbuilder.model.vo.ChangeBlockTypeVO;
	
	import org.osflash.signals.Signal;
	
	public class ChangeBlockTypeRequest extends Signal
	{
		public function ChangeBlockTypeRequest()
		{
			super( ChangeBlockTypeVO );
		}
	}
}