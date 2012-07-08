package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
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
		public var currentBlockModel:SelectedBlockModel;
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		override public function execute():void
		{
			
			// TO-DO:
			
			// BUILD mode:
			// - Drag in blocks (and block is auto selected once placed)
			
			// BOTH:
			// - Delete a selected block with the delete key
			// - Arrow keys change type of selected block
			
			// UX:
			// New/open/exit should all prompt a save if unsaved
			// Trace a line to the ground plane to indicate y position for blocks
			// Scrollwheel zooms
			
			// - First type change
			// - Add new block
			
			// "Thank you! Just for playing, you get 50 credits for free!"
			
			// Bug with y pos of current block in beam.json.
			
			
			// Select block.
			currentBlockModel.setBlock( block );
			
			// Snap target to block.
			cameraTargetModel.target.x = block.x;
			cameraTargetModel.target.y = block.y + SegmentConstants.BLOCK_SIZE * .5;
			cameraTargetModel.target.z = block.z;
		}
	}
}