package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.DeselectAllBlocksRequest;
	import com.funbuilder.controller.signals.DeselectBlockRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.model.KeysModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.DeselectBlockVO;
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
		
		// Commands.
		
		[Inject]
		public var deselectBlockRequest:DeselectBlockRequest;
		
		[Inject]
		public var deselectAllBlocksRequest:DeselectAllBlocksRequest;
		
		[Inject]
		public var selectBlockRequest:SelectBlockRequest;
		
		override public function execute():void
		{
		
			if ( selectedBlocksModel.contains( block ) ) {
				// Deselect block.
				deselectBlockRequest.dispatch( new DeselectBlockVO( block ) );
			} else {
				if ( keysModel.isShiftDown ) {
					selectBlockRequest.dispatch( new SelectBlockVO( block, true, true ) );
				} else {
					deselectAllBlocksRequest.dispatch();
					selectBlockRequest.dispatch( new SelectBlockVO( block, false, true ) );
				}
			}
		}
	}
}