package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.controller.signals.DeselectAllBlocksRequest;
	import com.funbuilder.controller.signals.DeselectBrushRequest;
	import com.funbuilder.model.BrushModel;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.constants.Grid;
	import com.funrun.model.BlockStylesModel;
	import com.funrun.model.BlockTypesModel;
	import com.funrun.model.vo.BlockTypeVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class SelectBrushCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var styleId:String;
		
		// Models.
		
		[Inject]
		public var brushModel:BrushModel;
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		[Inject]
		public var blockTypesModel:BlockTypesModel;
		
		[Inject]
		public var blockStylesModel:BlockStylesModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var deselectBrushRequest:DeselectBrushRequest;
		
		[Inject]
		public var deselectAllBlocksRequest:DeselectAllBlocksRequest;
		
		override public function execute():void {
			deselectBrushRequest.dispatch();
			deselectAllBlocksRequest.dispatch();
			
			// Add preview.
			brushModel.select( blockTypesModel.getWithId( styleId ), blockStylesModel.getMeshCloneForBlock( styleId ) );
			cameraTargetModel.matchPosition( brushModel.preview );
			Grid.snapObjectToGrid( brushModel.preview );
			addObjectToSceneRequest.dispatch( brushModel.preview );
		}
	}
}