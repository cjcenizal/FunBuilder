package com.funbuilder.controller.commands
{
	import com.funbuilder.model.vo.ChangeBlockTypeVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class ChangeBlockTypeCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var changeBlockTypeData:ChangeBlockTypeVO;
		
		override public function execute():void
		{
			trace(changeBlockTypeData.dir);
		}
	}
}