package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.controller.signals.UpdateElevationRequest;
	import com.funbuilder.model.EditingModeModel;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.vo.AddBlockVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var addBlockData:AddBlockVO;
		
		// Models.
		
		[Inject]
		public var currentSegmentModel:SegmentModel;
		
		[Inject]
		public var editingModeModel:EditingModeModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var selectBlockRequest:SelectBlockRequest;
		
		[Inject]
		public var updateElevationRequest:UpdateElevationRequest;
		
		override public function execute():void
		{
			currentSegmentModel.add( addBlockData.mesh, addBlockData.id, addBlockData.key );
			// TO-DO: Should this be done here, or in initial set up?
			addBlockData.mesh.mouseEnabled = true;
			addBlockData.mesh.addEventListener( MouseEvent3D.CLICK, onClick );
			addObjectToSceneRequest.dispatch( addBlockData.mesh );
			updateElevationRequest.dispatch();
		}
		
		private function onClick( e:MouseEvent3D ):void {
			selectBlockRequest.dispatch( e.object as Mesh );
		}
	}
}