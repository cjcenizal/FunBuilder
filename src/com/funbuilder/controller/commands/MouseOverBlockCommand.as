package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.DeselectBlockRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.model.HandlesModel;
	import com.funbuilder.model.KeyboardModel;
	import com.funbuilder.model.MouseModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.DeselectBlockVo;
	import com.funbuilder.model.vo.SelectBlockVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class MouseOverBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var block:Mesh;
		
		// Models.
		
		[Inject]
		public var keysModel:KeyboardModel;
		
		[Inject]
		public var mouseModel:MouseModel;
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		[Inject]
		public var handlesModel:HandlesModel;
		
		// Commands.
		
		[Inject]
		public var selectBlockRequest:SelectBlockRequest;
		
		[Inject]
		public var deselectBlockRequest:DeselectBlockRequest;
		
		override public function execute():void {
			mouseModel.mouseOver( block );
			
			// Add to and remove from current selection.
			if ( mouseModel.mouseDown && !handlesModel.isGrabbed ) {
				if ( keysModel.alt ) {
					if ( selectedBlocksModel.contains( block ) ) {
						// Remove from selection.
						deselectBlockRequest.dispatch( new DeselectBlockVo( block ) );
					}
				} else if ( keysModel.shift ) {
					if ( !selectedBlocksModel.contains( block ) ) {
						// Add to selection.
						selectBlockRequest.dispatch( new SelectBlockVo( block, true, true ) );
					}
				}
			}
		}
	}
}