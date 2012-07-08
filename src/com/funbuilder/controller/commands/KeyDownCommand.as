package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.RemoveBlockRequest;
	import com.funbuilder.controller.signals.SetEditingModeRequest;
	import com.funbuilder.model.EditingModeModel;
	import com.funbuilder.model.SelectedBlockModel;
	
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class KeyDownCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var code:int;
		
		// Models.
		
		[Inject]
		public var editingModeModel:EditingModeModel;
		
		[Inject]
		public var selectedBlockModel:SelectedBlockModel;
		
		// Commands.
		
		[Inject]
		public var setEditingModeRequest:SetEditingModeRequest;
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var removeBlockRequest:RemoveBlockRequest;
		
		override public function execute():void
		{
			switch ( code ) {
				case Keyboard.SPACE:
					// Toggle between Selection and Exploration mode.
					if ( editingModeModel.mode == EditingModeModel.LOOK ) {
						setEditingModeRequest.dispatch( EditingModeModel.BUILD );
					} else {
						setEditingModeRequest.dispatch( EditingModeModel.LOOK );
					}
					break;
				case Keyboard.BACKSPACE:
					if ( selectedBlockModel.hasBlock() ) {
						addHistoryRequest.dispatch( false );
						removeBlockRequest.dispatch( selectedBlockModel.getBlock() );
					}
					break;
			}
		}
	}
}