package com.funbuilder.controller.signals
{
	import com.funbuilder.model.vo.ChangeBlockStyleVo;
	
	import org.osflash.signals.Signal;
	
	public class ChangeBlockStyleRequest extends Signal
	{
		public function ChangeBlockStyleRequest()
		{
			super( ChangeBlockStyleVo );
		}
	}
}