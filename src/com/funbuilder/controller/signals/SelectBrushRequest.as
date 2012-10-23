package com.funbuilder.controller.signals
{
	import com.funrun.model.vo.BlockTypeVo;
	
	import org.osflash.signals.Signal;
	
	public class SelectBrushRequest extends Signal
	{
		public function SelectBrushRequest()
		{
			super( String );
		}
	}
}