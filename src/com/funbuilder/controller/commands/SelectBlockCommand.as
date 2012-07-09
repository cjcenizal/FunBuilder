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
			
			// Scrollwheel zooms
			
			
			// UX:
			// Trace a line to the ground plane to indicate y position for blocks (diff colors for above and below)
			// Or just draw or cut out a dark square on the plane
			// New/open/exit should all prompt a save if unsaved
			
			// Bugs:
			// - Fix Library panel size and position
			// - Fix Library panel snapshot
			
			
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