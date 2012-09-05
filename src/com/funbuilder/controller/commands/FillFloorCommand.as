package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddBlockRequest;
	import com.funbuilder.model.BlocksModel;
	import com.funbuilder.model.constants.SegmentConstants;
	import com.funbuilder.model.vo.AddBlockVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class FillFloorCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var blocksModel:BlocksModel;
		
		// Commands.
		
		[Inject]
		public var addBlockRequest:AddBlockRequest;
		
		override public function execute():void {
			var block:Mesh;
			for ( var x:int = 0; x < SegmentConstants.NUM_BLOCKS_WIDE; x++ ) {
				for ( var z:int = 0; z < SegmentConstants.NUM_BLOCKS_DEPTH; z++ ) {
					var block:Mesh = blocksModel.getWithId( "floor" ).mesh.clone() as Mesh;
					block.scaleX = block.scaleY = block.scaleZ = 1;
					block.x = x * SegmentConstants.BLOCK_SIZE + SegmentConstants.BLOCK_SIZE * .5;
					block.y = -SegmentConstants.BLOCK_SIZE;
					block.z = z * SegmentConstants.BLOCK_SIZE + SegmentConstants.BLOCK_SIZE * .5;
					addBlockRequest.dispatch( new AddBlockVO( block ) );
				}
			}
		}
	}
}