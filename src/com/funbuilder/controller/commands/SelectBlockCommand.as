package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.model.constants.SegmentConstants;
	import com.funbuilder.model.CameraTargetModel;
	
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
			
			
			
			
			// LOOK mode:
			// 1) If block is selected, move it around
			// 2) If no block, just look around.
			// Deselect block with esc.
			
			// SELECT mode:
			// 1) select block and choose new type (or switch to moving to move it around)
			// 2) drag new blocks from library into scene
			
			
			currentBlockModel.block = block;
			
			// Snap target to block.
			cameraTargetModel.target.x = block.x;
			cameraTargetModel.target.y = block.y + SegmentConstants.BLOCK_SIZE * .5;
			cameraTargetModel.target.z = block.z;

		}
	}
}