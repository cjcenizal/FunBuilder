package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.vo.ChangeBlockStyleVo;
	import com.funrun.model.BlockStylesModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class ChangeBlockStyleCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var vo:ChangeBlockStyleVo;
		
		// Models.
		
		[Inject]
		public var blockStylesModel:BlockStylesModel;
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		override public function execute():void
		{
			// Select new style.
			var len:int = blockStylesModel.numStyles;
			var index:int = blockStylesModel.currentStyle.index;
			index += vo.dir;
			if ( index >= len ) index = 0;
			else if ( index < 0 ) index = len - 1;
			blockStylesModel.currentStyle = blockStylesModel.getStyleAt( index );
			
			// For all blocks in segment, replace them with their analogues in the next style.
			if ( segmentModel.numBlocks > 0 ) {
		//		addHistoryRequest.dispatch();
				
				for ( var i:int = segmentModel.numBlocks - 1; i >= 0; i-- ) {
					
					var oldBlock:Mesh = segmentModel.getAt( i );
					var oldId:String = oldBlock.name;
					
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