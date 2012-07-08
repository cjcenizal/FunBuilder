package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddBlockRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.model.BlocksModel;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.SelectedBlockModel;
	import com.funbuilder.model.vo.AddBlockVO;
	import com.funbuilder.model.constants.SegmentConstants;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddBlockFromLibraryCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var id:String;
		
		// Models.
		
		[Inject]
		public var blocksModel:BlocksModel;
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		// Commands.
		
		[Inject]
		public var addBlockReuqest:AddBlockRequest;
		
		[Inject]
		public var selectBlockRequest:SelectBlockRequest;
		
		override public function execute():void
		{
			// Add block.
			var mesh:Mesh = blocksModel.getBlock( id ).mesh.clone() as Mesh;
			mesh.x = SegmentConstants.snapToGrid( cameraTargetModel.target.x - SegmentConstants.BLOCK_SIZE * .5 ) + SegmentConstants.BLOCK_SIZE * .5;
			mesh.y = SegmentConstants.snapToGrid( cameraTargetModel.target.y - SegmentConstants.BLOCK_SIZE * .5 );
			mesh.z = SegmentConstants.snapToGrid( cameraTargetModel.target.z - SegmentConstants.BLOCK_SIZE * .5 ) + SegmentConstants.BLOCK_SIZE * .5;
			addBlockReuqest.dispatch( new AddBlockVO( mesh, id ) );
			// Select it.
			selectBlockRequest.dispatch( mesh );
		}
	}
}