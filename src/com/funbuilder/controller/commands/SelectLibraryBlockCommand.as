package com.funbuilder.controller.commands
{
	import com.funbuilder.model.BrushModel;
	import com.funrun.model.vo.BlockVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class SelectLibraryBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var blockData:BlockVO;
		
		// Models.
		
		[Inject]
		public var brushModel:BrushModel;
		
		override public function execute():void {
			brushModel.block = blockData;
		}
	}
}