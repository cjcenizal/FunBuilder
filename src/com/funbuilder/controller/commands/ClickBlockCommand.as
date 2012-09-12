package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.DeselectAllBlocksRequest;
	import com.funbuilder.controller.signals.DeselectBlockRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.model.BrushModel;
	import com.funbuilder.model.KeyboardModel;
	import com.funbuilder.model.MouseModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.DeselectBlockVo;
	import com.funbuilder.model.vo.SelectBlockVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class ClickBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var block:Mesh;
		
		// Models.
		
		[Inject]
		public var keysModel:KeyboardModel;
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		[Inject]
		public var mouseModel:MouseModel;
		
		[Inject]
		public var brushModel:BrushModel;
		
		// Commands.
		
		[Inject]
		public var deselectBlockRequest:DeselectBlockRequest;
		
		[Inject]
		public var deselectAllBlocksRequest:DeselectAllBlocksRequest;
		
		[Inject]
		public var selectBlockRequest:SelectBlockRequest;
		
		override public function execute():void
		{
			if ( !brushModel.preview && mouseModel.canClick ) {
				if ( keysModel.alt && keysModel.shift ) {
					// Deselect block.
					deselectBlockRequest.dispatch( new DeselectBlockVo( block ) );
				} else if ( keysModel.alt ) {
					// Deselect block.
					deselectBlockRequest.dispatch( new DeselectBlockVo( block ) );
				} else if ( keysModel.shift ) {
					// Add it to selection.
					selectBlockRequest.dispatch( new SelectBlockVo( block, true, true ) );
				} else {
					// Select it and deselect all others.
					deselectAllBlocksRequest.dispatch();
					selectBlockRequest.dispatch( new SelectBlockVo( block, false, true ) );
				}
			}
		}
	}
}