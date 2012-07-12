package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.DeselectAllBlocksRequest;
	import com.funbuilder.controller.signals.DeselectSingleBlockRequest;
	import com.funbuilder.controller.signals.UpdateTargetAppearanceRequest;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.KeysModel;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.constants.SegmentConstants;
	import com.funbuilder.model.vo.SelectBlockVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class SelectBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var selectData:SelectBlockVO;
		
		// Models.
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		[Inject]
		public var keysModel:KeysModel;
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		// Commands.
		
		[Inject]
		public var deselectBlockRequest:DeselectSingleBlockRequest;
		
		[Inject]
		public var deselectAllBlocksRequest:DeselectAllBlocksRequest;
		
		[Inject]
		public var updateTargetAppearanceRequest:UpdateTargetAppearanceRequest;
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		override public function execute():void
		{
			
			// TO-DO:
			
			
			// UX:
			// Duplicate selection
			// Warning when a block intersects other blocks
			// New/open/exit should all prompt a save if unsaved
			
			
			// Need selection indicators for selected blocks (these can be used for error indicators too)
			// Once indicators are in place, test selection states w/ undo/redo history.
			
			// "Thank you! Just for playing, you get 50 credits for free!"
			
			// If shift is pressed, enable multiple select.
			// Else, deselect the current block.
			
			if ( selectData.saveHistory ) {
				addHistoryRequest.dispatch();
			}
			
			if ( keysModel.isShiftDown || selectData.multipleSelect ) {
				// Select additional block or deselect an already-selected block.
				if ( selectedBlocksModel.contains( selectData.block ) ) {
					// Deselect block.
					deselectBlockRequest.dispatch( selectData );
				} else {
					doSelectBlock();
				}
			} else {
				// Deselect all.
				if ( selectedBlocksModel.hasAnySelected() ) {
					deselectAllBlocksRequest.dispatch();
				}
				doSelectBlock();
			}
		}
		
		private function doSelectBlock():void {
			// Select block.
			selectedBlocksModel.select( selectData.block );
			segmentModel.enableIndicatorFor( selectData.block, true );
			// Snap target to block.
			cameraTargetModel.setPos( selectData.block.x, selectData.block.y + SegmentConstants.BLOCK_SIZE * .5, selectData.block.z );	
			updateTargetAppearanceRequest.dispatch();
		}
	}
}