package com.funbuilder.controller.commands
{
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
		
		
		override public function execute():void
		{
			editingModeModel.mode = mode;
			updateTargetAppearanceRequest.dispatch();
		}
	}
}