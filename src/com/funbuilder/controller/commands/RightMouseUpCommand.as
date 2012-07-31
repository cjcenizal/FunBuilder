package com.funbuilder.controller.commands
{
	import com.funbuilder.model.MouseModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class RightMouseUpCommand extends Command
	{
		[Inject]
		public var mouseModel:MouseModel;
		
		override public function execute():void {
			mouseModel.rightMouseDown = false;
		}
	}
}