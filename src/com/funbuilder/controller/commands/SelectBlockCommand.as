package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.CurrentBlockModel;
	import com.funbuilder.model.constants.SegmentConstants;
	
	import org.robotlegs.mvcs.Command;
	
	public class SelectBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var block:Mesh;
		
		// Models.
		
		[Inject]
		public var currentBlockModel:CurrentBlockModel;
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		override public function execute():void
		{
			// Scrollwheel zooms
			
			
			// Hold space to temporarily enter BUILD mode
			// - Click off to deselect
			// - Drag in blocks (and block is auto selected once placed)
			
			// LOOK mode:
			// 1) If block is selected, move it around
			// 2) If no block, just look around.
			// Arrow keys change type of selected block
			
			// New/open/close should all prompt a save if unsaved
			
			// Delete a selected block with the delete key
			
			// Trace a line to the ground plane to indicate y position for blocks
			
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