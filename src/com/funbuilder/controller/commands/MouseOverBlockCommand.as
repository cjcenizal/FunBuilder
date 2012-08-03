package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.DeselectBlockRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.model.KeysModel;
	import com.funbuilder.model.MouseModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.DeselectBlockVO;
	import com.funbuilder.model.vo.SelectBlockVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class MouseOverBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var block:Mesh;
		
		// Models.
		
		[Inject]
		public var keysModel:KeysModel;
		
		[Inject]
		public var mouseModel:MouseModel;
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		// Commands.
		
		[Inject]
		public var selectBlockRequest:SelectBlockRequest;
		
		[Inject]
		public var deselectBlockRequest:DeselectBlockRequest;
		
		override public function execute():void {
			// Add to and remove from current selection.
			if ( mouseModel.mouseDown ) {
				if ( keysModel.alt ) {
					if ( selectedBlocksModel.contains( block ) ) {
						// Remove from selection.
						deselectBlockRequest.dispatch( new DeselectBlockVO( block ) );
					}
				} else if ( keysModel.shift ) {
					if ( !selectedBlocksModel.contains( block ) ) {
						// Add to selection.
						selectBlockRequest.dispatch( new SelectBlockVO( block, true, true ) );
					}
				}
			}
		}
	}
}