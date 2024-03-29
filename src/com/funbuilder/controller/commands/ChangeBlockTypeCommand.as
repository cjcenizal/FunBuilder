package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddBlockRequest;
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.InvalidateSavedFileRequest;
	import com.funbuilder.controller.signals.RemoveBlockRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.AddBlockVo;
	import com.funbuilder.model.vo.ChangeBlockTypeVo;
	import com.funbuilder.model.vo.SelectBlockVo;
	import com.funrun.model.BlockStylesModel;
	import com.funrun.model.BlockTypesModel;
	import com.funrun.model.vo.BlockTypeVo;
	
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
		public var blockTypesModel:BlockTypesModel;
		
		[Inject]
		public var blockStylesModel:BlockStylesModel;
		
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
					var oldNameObj:Object = JSON.parse( oldBlock.name );
					var oldId:String = oldNameObj.type;
					
					// Create new block with position.
					var index:int = blockTypesModel.getBlockIndex( oldId ) + changeBlockTypeData.dir;
					if ( index >= blockTypesModel.numBlocks ) {
						index = 0;
					} else if ( index < 0 ) {
						index = blockTypesModel.numBlocks - 1;
					}
					
					var newBlockData:BlockTypeVo = blockTypesModel.getAt( index );
					var newBlock:Mesh = blockStylesModel.getMeshCloneForBlock( newBlockData.id );
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