package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.DeselectBlockRequest;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.SelectedBlockModel;
	import com.funbuilder.model.constants.SegmentConstants;
	
	import org.robotlegs.mvcs.Command;
	
	public class SelectBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var block:Mesh;
		
		// Models.
		
		[Inject]
		public var selectedBlockModel:SelectedBlockModel;
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		// Commands.
		
		[Inject]
		public var deselectBlockRequest:DeselectBlockRequest;
		
		override public function execute():void
		{
			
			// TO-DO:
			
			// UX:
			// Trace a line to the ground plane to indicate y position for blocks (diff colors for above and below)
			// New/open/exit should all prompt a save if unsaved
			// Scrollwheel zooms
			
			
			// Snap point to grid in SegmentConstants, and do this to incoming blocks, added blocks, and snap to cam target
			
			// "Thank you! Just for playing, you get 50 credits for free!"
			
			// Deselect current block.
			if ( selectedBlockModel.hasBlock() ) {
				deselectBlockRequest.dispatch();
			}
			
			// Select block.
			selectedBlockModel.setBlock( block );
			
			// Snap target to block.
			cameraTargetModel.target.x = block.x;
			cameraTargetModel.target.y = block.y + SegmentConstants.BLOCK_SIZE * .5;
			cameraTargetModel.target.z = block.z;
		}
	}
}