package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.model.BrushModel;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.constants.SegmentConstants;
	import com.funrun.model.vo.BlockVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class SelectBrushCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var blockData:BlockVO;
		
		// Models.
		
		[Inject]
		public var brushModel:BrushModel;
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		override public function execute():void {
			brushModel.data = blockData;
			
			// Add preview.
			brushModel.preview = blockData.mesh.clone() as Mesh;
			cameraTargetModel.matchPosition( brushModel.preview );
			SegmentConstants.snapObjectToGrid( brushModel.preview );
			brushModel.preview.scale( .5 );
			addObjectToSceneRequest.dispatch( brushModel.preview );
		}
	}
}