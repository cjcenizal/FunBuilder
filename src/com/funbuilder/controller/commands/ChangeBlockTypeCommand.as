package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddBlockRequest;
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.RemoveBlockRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.model.BlocksModel;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlockModel;
	import com.funbuilder.model.vo.AddBlockVO;
	import com.funbuilder.model.vo.ChangeBlockTypeVO;
	import com.funrun.model.vo.BlockVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class ChangeBlockTypeCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var changeBlockTypeData:ChangeBlockTypeVO;
		
		// Models.
		
		[Inject]
		public var selectedBlockModel:SelectedBlockModel;
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		[Inject]
		public var blocksModel:BlocksModel;
		
		// Commands.
		
		[Inject]
		public var removeBlockRequest:RemoveBlockRequest;
		
		[Inject]
		public var addBlockRequest:AddBlockRequest;
	
		[Inject]
		public var selectBlockRequest:SelectBlockRequest;
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		override public function execute():void
		{
			if ( selectedBlockModel.hasBlock() ) {
				addHistoryRequest.dispatch( false );
				
				var oldBlock:Mesh = selectedBlockModel.getBlock();
				var oldId:String = segmentModel.getIdFor( oldBlock );
				// Get block position and namespace.
				
				// Create new block with position.
				var index:int = blocksModel.getBlockIndex( oldId ) + changeBlockTypeData.dir;
				if ( index >= blocksModel.numBlocks ) {
					index = 0;
				} else if ( index < 0 ) {
					index = blocksModel.numBlocks - 1;
				}
				
				var newBlockData:BlockVO = blocksModel.getBlockAt( index );
				var newBlock:Mesh = blocksModel.getBlock( newBlockData.id ).mesh.clone() as Mesh;
				newBlock.x = oldBlock.x;
				newBlock.y = oldBlock.y;
				newBlock.z = oldBlock.z;
				
				// Remove old block.
				removeBlockRequest.dispatch( oldBlock );
				
				// Add new block.
				addBlockRequest.dispatch( new AddBlockVO( newBlock, newBlockData.id ) );
				
				// Select the new one.
				selectBlockRequest.dispatch( newBlock );
			}
		}
	}
}