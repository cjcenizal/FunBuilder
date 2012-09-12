package com.funbuilder.controller.signals
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.model.vo.SelectBlockVo;
	
	import org.osflash.signals.Signal;
	
	public class SelectBlockRequest extends Signal
	{
		public function SelectBlockRequest()
		{
			super( SelectBlockVo );
		}
	}
}