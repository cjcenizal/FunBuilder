package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.DeselectAllBlocksRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.model.KeysModel;
	import com.funbuilder.model.MouseModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.SelectBlockVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class ClickBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var block:Mesh;
		
		// Models.
		
		[Inject]
		public var keysModel:KeysModel;
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		[Inject]
		public var mouseModel:MouseModel;
		
		// Commands.
		
		[Inject]
		public var deselectAllBlocksRequest:DeselectAllBlocksRequest;
		
		[Inject]
		public var selectBlockRequest:SelectBlockRequest;
		
		override public function execute():void
		{
			if ( mouseModel.canClick ) {
				// If it's not already selected.
				if ( !selectedBlocksModel.contains( block ) ) {
					if ( keysModel.shift ) {
						// If shift is down, add it to selection.
						selectBlockRequest.dispatch( new SelectBlockVO( block, true, true ) );
					} else {
						// Else, select it and deselect all others.
						deselectAllBlocksRequest.dispatch();
						selectBlockRequest.dispatch( new SelectBlockVO( block, false, true ) );
					}
				}
			}
		}
	}
}