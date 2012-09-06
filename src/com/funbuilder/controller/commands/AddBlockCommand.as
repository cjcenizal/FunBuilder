package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.controller.signals.ClickBlockRequest;
	import com.funbuilder.controller.signals.InvalidateHudRequest;
	import com.funbuilder.controller.signals.MouseOutBlockRequest;
	import com.funbuilder.controller.signals.MouseOverBlockRequest;
	import com.funbuilder.model.KeysModel;
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
		public var segmentModel:SegmentModel;
		
		[Inject]
		public var keysModel:KeysModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var clickBlockRequest:ClickBlockRequest;
		
		[Inject]
		public var mouseOverBlockRequest:MouseOverBlockRequest;
		
		[Inject]
		public var mouseOutBlockRequest:MouseOutBlockRequest;
		
		[Inject]
		public var invalidateHudRequest:InvalidateHudRequest;
		
		override public function execute():void
		{
			var indicator:Mesh = segmentModel.getNewIndicatorMesh();
			indicator.x = addBlockData.mesh.x;
			indicator.y = addBlockData.mesh.y;
			indicator.z = addBlockData.mesh.z;
			segmentModel.add( addBlockData.mesh, indicator, addBlockData.key );
			
			// Add listeners for click, right-click, and mouse-over.
			addBlockData.mesh.mouseEnabled = true;
			addBlockData.mesh.addEventListener( MouseEvent3D.MOUSE_DOWN, onMouseDown );
			addBlockData.mesh.addEventListener( MouseEvent3D.MOUSE_OVER, onMouseOver );
			addBlockData.mesh.addEventListener( MouseEvent3D.MOUSE_OUT, onMouseOut );
			
			// Add to scene.
			addObjectToSceneRequest.dispatch( addBlockData.mesh );
			addObjectToSceneRequest.dispatch( indicator );
			
			// Update HUD.
			invalidateHudRequest.dispatch();
		}
		
		private function onMouseDown( e:MouseEvent3D ):void {
			clickBlockRequest.dispatch( e.object as Mesh );
		}
		
		private function onMouseOver( e:MouseEvent3D ):void {
			mouseOverBlockRequest.dispatch( e.object as Mesh );
		}
		
		private function onMouseOut( e:MouseEvent3D ):void {
			mouseOutBlockRequest.dispatch( e.object as Mesh );
		}
	}
}