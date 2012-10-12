package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddBlockRequest;
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.InvalidateSavedFileRequest;
	import com.funbuilder.controller.signals.RemoveBlockRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funrun.model.BlocksModel;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.AddBlockVo;
	import com.funbuilder.model.vo.ChangeBlockTypeVo;
	import com.funbuilder.model.vo.SelectBlockVo;
	import com.funrun.model.vo.BlockVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class ChangeBlockTypeCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var changeBlockTypeData:ChangeBlockTypeVo;
		
		// Models.
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
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
		
		[Inject]
		public var invalidateSavedFileRequest:InvalidateSavedFileRequest;
		
		override public function execute():void
		{
			if ( selectedBlocksModel.numBlocks > 0 ) {
				addHistoryRequest.dispatch();
				
				for ( var i:int = selectedBlocksModel.numBlocks - 1; i >= 0; i-- ) {
					
					var oldBlock:Mesh = selectedBlocksModel.getAt( i );
					var oldId:String = oldBlock.name;
					
					// Create new block with position.
					var index:int = blocksModel.getBlockIndex( oldId ) + changeBlockTypeData.dir;
					if ( index >= blocksModel.numBlocks ) {
						index = 0;
					} else if ( index < 0 ) {
						index = blocksModel.numBlocks - 1;
					}
					
					var newBlockData:BlockVo = blocksModel.getAt( index );
					var newBlock:Mesh = blocksModel.getWithId( newBlockData.id ).mesh.clone() as Mesh;
					newBlock.x = oldBlock.x;
					newBlock.y = oldBlock.y;
					newBlock.z = oldBlock.z;
					
					// Remove old block.
					removeBlockRequest.dispatch( oldBlock );
					
					// Add new block.
					addBlockRequest.dispatch( new AddBlockVo( newBlock ) );
					
					// Select the new one.
					selectBlockRequest.dispatch( new SelectBlockVo( newBlock ) );
				}
				
				invalidateSavedFileRequest.dispatch();
			}
		}
	}
}