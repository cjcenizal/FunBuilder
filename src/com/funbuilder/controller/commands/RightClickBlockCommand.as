package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.DeselectAllBlocksRequest;
	import com.funbuilder.controller.signals.DeselectBlockRequest;
	import com.funbuilder.model.KeysModel;
	import com.funbuilder.model.MouseModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.DeselectBlockVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class RightClickBlockCommand extends Command
	{
		// Arguments.
		
		[Inject]
		public var block:Mesh;
		
		// Models.
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		[Inject]
		public var keysModel:KeysModel;
		
		[Inject]
		public var mouseModel:MouseModel;
		
		// Commands.
		
		[Inject]
		public var deselectBlockRequest:DeselectBlockRequest;
		
		[Inject]
		public var deselectAllBlocksRequest:DeselectAllBlocksRequest;
		
		override public function execute():void {
			if ( mouseModel.canClick ) {
				// If block is already selected.
				if ( selectedBlocksModel.contains( block ) ) {
					if ( keysModel.shift ) {
						// If shift is down, deselect just it.
						deselectBlockRequest.dispatch( new DeselectBlockVO( block ) );
					} else {
						// Else, deselect all.
						deselectAllBlocksRequest.dispatch();
					}
				}
			}
		}
	}
}