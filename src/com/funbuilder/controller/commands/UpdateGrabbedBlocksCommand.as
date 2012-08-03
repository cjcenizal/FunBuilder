package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddBlockRequest;
	import com.funbuilder.controller.signals.MoveBlocksRequest;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.AddBlockVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateGrabbedBlocksCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		// Commands.
		
		[Inject]
		public var moveBlocksRequest:MoveBlocksRequest;
		
		[Inject]
		public var addBlockRequest:AddBlockRequest;
		
		override public function execute():void {
			
			// Check movement first!
			
			
			if ( selectedBlocksModel.canDuplicate ) {
				// For each selected block, duplicate it and add to segment.
				var len:int = selectedBlocksModel.numBlocks;
				var block:Mesh;
				for ( var i:int = 0; i < len; i++ ) {
					block = selectedBlocksModel.getAt( i ).clone() as Mesh;
					addBlockRequest.dispatch( new AddBlockVO( block ) );
				}
				selectedBlocksModel.canDuplicate = false;
			} else {
				// Move blocks.
				moveBlocksRequest.dispatch();
			}
		}
	}
}