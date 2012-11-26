package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddBlockRequest;
	import com.funbuilder.model.vo.AddBlockVo;
	import com.funrun.model.BlockStylesModel;
	import com.funrun.model.constants.Block;
	import com.funrun.model.constants.Segment;
	
	import org.robotlegs.mvcs.Command;
	
	public class FillFloorCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var blockStylesModel:BlockStylesModel;
		
		// Commands.
		
		[Inject]
		public var addBlockRequest:AddBlockRequest;
		
		override public function execute():void {
			var block:Mesh;
			for ( var x:int = 0; x < Segment.WIDTH_BLOCKS; x++ ) {
				for ( var z:int = 0; z < Segment.DEPTH_BLOCKS; z++ ) {
					block = blockStylesModel.getMeshCloneForBlock( "floor" );
					block.scaleX = block.scaleY = block.scaleZ = 1;
					block.x = x * Block.SIZE + Block.SIZE * .5;
					block.y = -Block.SIZE;
					block.z = z * Block.SIZE + Block.SIZE * .5;
					addBlockRequest.dispatch( new AddBlockVo( block ) );
				}
			}
		}
	}
}