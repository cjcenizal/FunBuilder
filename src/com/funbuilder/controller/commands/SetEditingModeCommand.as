package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.DeselectBlockRequest;
	import com.funbuilder.controller.signals.SetEditingModeRequest;
	import com.funbuilder.controller.signals.UpdateTargetAppearanceRequest;
	import com.funbuilder.model.EditingModeModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class SetEditingModeCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var mode:String;
		
		// Models.
		
		[Inject]
		public var editingModeModel:EditingModeModel;
		
		// Commands.
		
		[Inject]
		public var setEditingModeRequest:SetEditingModeRequest;
		
		[Inject]
		public var updateTargetAppearanceRequest:UpdateTargetAppearanceRequest;
		
		[Inject]
		public var deselectBlockRequest:DeselectBlockRequest;
		
		override public function execute():void
		{
			if ( mode == EditingModeModel.BUILD ) {
				deselectBlockRequest.dispatch();
			}
			editingModeModel.mode = mode;
			updateTargetAppearanceRequest.dispatch();
		}
	}
}