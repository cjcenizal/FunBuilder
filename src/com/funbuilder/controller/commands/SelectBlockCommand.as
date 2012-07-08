package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	
	import com.funbuilder.controller.signals.UpdateTargetAppearanceRequest;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.constants.SegmentConstants;
	
	import org.robotlegs.mvcs.Command;
	import com.funbuilder.model.CurrentBlockModel;
	
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
		
		// Commands.
		
		[Inject]
		public var updateTargetAppearanceRequest:UpdateTargetAppearanceRequest;
		
		override public function execute():void
		{
			// Scrollwheel zooms
			
			
			// Hold space to temporarily enter BUILD mode
			// Click to select
			// Click off to deselect
			// Drag in blocks (and block is auto selected once placed)
			
			// LOOK mode:
			// 1) If block is selected, move it around
			// 2) If no block, just look around.
			// Deselect block with esc.
			// Arrow keys change type of selected block
			// While block is selected, show: "Hit Esc to deselect block"
			
			// New/open/close should all prompt a save if unsaved
			
			// Delete a selected block with the delete key
			
			// Trace a line to the ground plane to indicate y position for blocks
			
			// "Thank you! Just for playing, you get 50 credits for free!"
			
			currentBlockModel.setBlock( block );
			
			// Snap target to block.
			cameraTargetModel.target.x = block.x;
			cameraTargetModel.target.y = block.y + SegmentConstants.BLOCK_SIZE * .5;
			cameraTargetModel.target.z = block.z;

			updateTargetAppearanceRequest.dispatch();
		}
	}
}