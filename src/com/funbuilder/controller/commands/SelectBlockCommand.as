package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.DeselectAllBlocksRequest;
	import com.funbuilder.controller.signals.DeselectBlockRequest;
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
		public var deselectBlockRequest:DeselectBlockRequest;
		
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
			// Fix block movement
			// Make scroll crane blocks
			// Add history to deselect all blocks command
			// Warning when a block intersects other blocks
			// Duplicate selection
			// New/open/exit should all prompt a save if unsaved
			

			
			// "Thank you! Just for playing, you get 50 credits for free!"
			
			
			
			
			
			
			if ( selectData.saveHistory ) {
				addHistoryRequest.dispatch();
			}
			// Select block.
			selectedBlocksModel.select( selectData.block );
			segmentModel.enableIndicatorFor( selectData.block, true );
			// Snap target to block.
			//cameraTargetModel.setPos( selectData.block.x, selectData.block.y + SegmentConstants.BLOCK_SIZE * .5, selectData.block.z );	
			updateTargetAppearanceRequest.dispatch();
		}
	}
}