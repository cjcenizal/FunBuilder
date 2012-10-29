package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddBlockRequest;
	import com.funbuilder.controller.signals.RemoveBlockRequest;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.vo.AddBlockVo;
	import com.funbuilder.model.vo.ChangeBlockStyleVo;
	import com.funrun.model.BlockStylesModel;
	import com.funrun.model.BlockTypesModel;
	
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
		public var blockTypesModel:BlockTypesModel;
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		// Commands.
		
		[Inject]
		public var removeBlockRequest:RemoveBlockRequest;
		
		[Inject]
		public var addBlockRequest:AddBlockRequest;
		
		override public function execute():void
		{
			// Select new style.
			var len:int = blockStylesModel.numStyles;
			var index:int = blockStylesModel.currentStyle.index;
			index += vo.dir;
			if ( index >= len ) {
				index = 0;
			} else if ( index < 0 ) {
				index = len - 1;
			}
			blockStylesModel.currentStyle = blockStylesModel.getStyleAt( index );
			
			// For all blocks in segment, replace them with their analogues in the next style.
			if ( segmentModel.numBlocks > 0 ) {
				
				for ( var i:int = segmentModel.numBlocks - 1; i >= 0; i-- ) {
					
					var oldBlock:Mesh = segmentModel.getAt( i );
					var oldNameObj:Object = JSON.parse( oldBlock.name );
					var type:String = oldNameObj.type;
				
					var newBlock:Mesh = blockStylesModel.getMeshCloneForBlock( type );
					newBlock.x = oldBlock.x;
					newBlock.y = oldBlock.y;
					newBlock.z = oldBlock.z;
					
					// Remove old block.
					removeBlockRequest.dispatch( oldBlock );
					
					// Add new block.
					addBlockRequest.dispatch( new AddBlockVo( newBlock ) );
				}
			}
		}
	}
}