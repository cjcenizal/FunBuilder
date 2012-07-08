package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.ChangeBlockTypeRequest;
	import com.funbuilder.controller.signals.RemoveBlockRequest;
	import com.funbuilder.controller.signals.SetEditingModeRequest;
	import com.funbuilder.model.EditingModeModel;
	import com.funbuilder.model.SelectedBlockModel;
	import com.funbuilder.model.vo.ChangeBlockTypeVO;
	
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
		
		[Inject]
		public var changeBlockTypeRequest:ChangeBlockTypeRequest;
		
		// Private vars.
		
		private const LEFT_ARROW:int = 37;
		private const RIGHT_ARROW:int = 39;
		
		override public function execute():void
		{
			switch ( code ) {
				case Keyboard.SPACE:
					setEditingModeRequest.dispatch( EditingModeModel.BUILD );
					break;
				case Keyboard.BACKSPACE:
					if ( selectedBlockModel.hasBlock() ) {
						addHistoryRequest.dispatch( false );
						removeBlockRequest.dispatch( selectedBlockModel.getBlock() );
					}
					break;
				case LEFT_ARROW:
					changeBlockTypeRequest.dispatch( new ChangeBlockTypeVO( -1 ) );
					break;
				case RIGHT_ARROW:
					changeBlockTypeRequest.dispatch( new ChangeBlockTypeVO( 1 ) );
					break;
			}
		}
	}
}