package com.funbuilder.controller.commands
{
	import com.funbuilder.model.HudModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class InvalidateHudCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var hudModel:HudModel;
		
		override public function execute():void
		{
			hudModel.isValid = false;
		}
	}
}