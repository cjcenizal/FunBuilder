package com.funbuilder.controller.commands
{
	import away3d.cameras.Camera3D;
	
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.HandleKeyMovementRequest;
	import com.funbuilder.controller.signals.MoveBlockRequest;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.KeysModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.View3DModel;
	import com.funbuilder.model.constants.SegmentConstants;
	import com.funbuilder.model.events.TimeEvent;
	
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateViewCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var event:TimeEvent;
		
		// Models.
		
		[Inject]
		public var view3dModel:View3DModel;
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		[Inject]
		public var keysModel:KeysModel;
		
		// Commands.
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var handleKeyMovementRequest:HandleKeyMovementRequest;
		
		override public function execute():void
		{
			/*
			if ( keysModel.shift ) {
				if ( selectedBlocksModel.timeUntilMovement <= 0 ) {
					if ( event.ticks % 2 == 0 ) {
						handleKeyMovementRequest.dispatch();
					}
				}
			} else {
				handleKeyMovementRequest.dispatch();
			}
			*/
			handleKeyMovementRequest.dispatch();
			
			// Update target.
			cameraTargetModel.update();
			
			// Render scene.
			view3dModel.render();
		}
		
		
	}
}