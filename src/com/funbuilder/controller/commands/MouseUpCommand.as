package com.funbuilder.controller.commands
{
	import com.funbuilder.model.HandlesModel;
	import com.funbuilder.model.MouseModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class MouseUpCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var mouseModel:MouseModel;
		
		[Inject]
		public var handlesModel:HandlesModel;
		
		override public function execute():void {
			mouseModel.setMouseUp();
			handlesModel.grab( false );
		}
	}
}