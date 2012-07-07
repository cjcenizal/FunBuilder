package com.funbuilder.controller.commands
{
	import com.funbuilder.model.View3DModel;
	import com.funbuilder.model.events.TimeEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateViewCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var event:TimeEvent;
		
		// Models.
		
		[Inject]
		public var view3DModel:View3DModel;
		
		override public function execute():void
		{
			view3DModel.render();
		}
	}
}