package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddBlockRequest;
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.InvalidateSavedFileRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.model.BlocksModel;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.constants.SegmentConstants;
	import com.funbuilder.model.vo.AddBlockVO;
	import com.funbuilder.model.vo.SelectBlockVO;
	
	import flash.geom.Vector3D;
	
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
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var invalidateSavedFileRequest:InvalidateSavedFileRequest;
		
		override public function execute():void
		{
			addHistoryRequest.dispatch( false );
			// Add block.
			var mesh:Mesh = blocksModel.getWithId( id ).mesh.clone() as Mesh;
			var snappedPos:Vector3D = SegmentConstants.snapPointGrid( cameraTargetModel.targetX, cameraTargetModel.targetY, cameraTargetModel.targetZ );
			mesh.x = snappedPos.x;
			mesh.y = snappedPos.y;
			mesh.z = snappedPos.z;
			addBlockReuqest.dispatch( new AddBlockVO( mesh ) );
			// Select it.
			selectBlockRequest.dispatch( new SelectBlockVO( mesh ) );
			invalidateSavedFileRequest.dispatch();
		}
	}
}