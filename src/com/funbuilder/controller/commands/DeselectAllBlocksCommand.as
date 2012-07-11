package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.UpdateTargetAppearanceRequest;
	import com.funbuilder.model.SelectedBlocksModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class DeselectAllBlocksCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		// Commands.
		
		[Inject]
		public var updateTargetAppearanceRequest:UpdateTargetAppearanceRequest;
		
		override public function execute():void
		{
			// TO-DO:
			// Intersecting an existing block flashes red and doesn't allow you to leave it there
			// (i.e. deselect it)
			
			selectedBlocksModel.deselectAll();
			updateTargetAppearanceRequest.dispatch();
		}
	}
}