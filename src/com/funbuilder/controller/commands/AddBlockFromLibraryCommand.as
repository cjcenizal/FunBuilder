package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddBlockRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.model.BlocksModel;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.SelectedBlockModel;
	import com.funbuilder.model.vo.AddBlockVO;
	
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
			mesh.x = cameraTargetModel.target.x;
			mesh.y = cameraTargetModel.target.y;
			mesh.z = cameraTargetModel.target.z;
			addBlockReuqest.dispatch( new AddBlockVO( mesh, id ) );
			// Select it.
			selectBlockRequest.dispatch( mesh );
		}
	}
}