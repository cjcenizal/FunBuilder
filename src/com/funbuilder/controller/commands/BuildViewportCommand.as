package com.funbuilder.controller.commands
{
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PlaneGeometry;
	
	import com.funbuilder.controller.signals.AddCameraControllerRequest;
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.controller.signals.AddView3DRequest;
	import com.funbuilder.controller.signals.NewFileRequest;
	import com.funbuilder.controller.signals.SetEditingModeRequest;
	import com.funbuilder.controller.signals.ShowStatsRequest;
	import com.funbuilder.controller.signals.UpdateTargetAppearanceRequest;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.EditingModeModel;
	import com.funbuilder.model.ElevationModel;
	import com.funbuilder.model.TimeModel;
	import com.funbuilder.model.View3DModel;
	import com.funbuilder.model.constants.SegmentConstants;
	import com.funbuilder.model.events.TimeEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class BuildViewportCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		[Inject]
		public var timeModel:TimeModel;
		
		[Inject]
		public var view3dModel:View3DModel;
		
		[Inject]
		public var editingModeModel:EditingModeModel;
		
		[Inject]
		public var elevationModel:ElevationModel;
		
		// Commands.
		
		[Inject]
		public var setEditingModeRequest:SetEditingModeRequest;
		
		[Inject]
		public var addView3DRequest:AddView3DRequest;
		
		[Inject]
		public var showStatsRequest:ShowStatsRequest;
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var updateTargetAppearanceRequest:UpdateTargetAppearanceRequest;
		
		[Inject]
		public var addCameraControllerRequest:AddCameraControllerRequest;
		
		[Inject]
		public var newFileRequest:NewFileRequest;
		
		override public function execute():void
		{
			// Time.
			timeModel.stage = contextView.stage;
			timeModel.init();
			
			// Add view.
			var scene:Scene3D = new Scene3D();
			var camera:Camera3D = new Camera3D( new PerspectiveLens( 90 ) );
			camera.lens.far = 100000;
			var view:View3D = new View3D( scene, camera );
			view.antiAlias = 2; // 2, 4, or 16
			view.width = contextView.stage.stageWidth;
			view.height = contextView.stage.stageHeight;
			view.backgroundColor = 0;
			view3dModel.setView( view );
			addView3DRequest.dispatch( view );
			
			// Add camera target.
			var target:Mesh = new Mesh( new CubeGeometry( 110, 110, 110 ), null );
			cameraTargetModel.setMesh( target );
			cameraTargetModel.setPos( SegmentConstants.SEGMENT_HALF_WIDTH, 0, SegmentConstants.SEGMENT_HALF_DEPTH );
			addObjectToSceneRequest.dispatch( target );
			
			// Add camera controller.
			var cameraController:HoverController = new HoverController( camera, target, 45, 10, 800 );
			cameraController.steps = 1;
			view3dModel.cameraController = cameraController;
			addCameraControllerRequest.dispatch( cameraController );
			
			// Add ground plane.
			var planeGeometry:PlaneGeometry = new PlaneGeometry( SegmentConstants.SEGMENT_WIDTH, SegmentConstants.SEGMENT_DEPTH, 12, 26, true );
			var planeMaterial:ColorMaterial = new ColorMaterial( 0xffffff, .2 );
			planeMaterial.bothSides = true;
			var planeMesh:Mesh = new Mesh( planeGeometry, planeMaterial );
			planeMesh.x = SegmentConstants.SEGMENT_HALF_WIDTH;
			planeMesh.z = SegmentConstants.SEGMENT_HALF_DEPTH;
			addObjectToSceneRequest.dispatch( planeMesh );
			view3dModel.groundPlane = planeMesh;
			
			// Add elevation indicators.
			var positiveIndicator:Mesh;
			var negativeIndicator:Mesh;
			var side:Number = SegmentConstants.BLOCK_SIZE - 3;
			var indicatorGeo:Geometry = new PlaneGeometry( side, side );
			for ( var x:int = SegmentConstants.BLOCK_SIZE * .5; x < SegmentConstants.SEGMENT_WIDTH; x += SegmentConstants.BLOCK_SIZE ) {
				for ( var z:int = SegmentConstants.BLOCK_SIZE * .5; z < SegmentConstants.SEGMENT_DEPTH; z += SegmentConstants.BLOCK_SIZE ) {
					var positiveIndicatorMaterial:ColorMaterial = new ColorMaterial( 0xddffdd, 0 );
					var negativeIndicatorMaterial:ColorMaterial = new ColorMaterial( 0xddddff, 0 );
					positiveIndicator = new Mesh( indicatorGeo, positiveIndicatorMaterial );
					positiveIndicator.x = x;
					positiveIndicator.y = 1;
					positiveIndicator.z = z;
					elevationModel.add( positiveIndicator, true );
					addObjectToSceneRequest.dispatch( positiveIndicator );
					
					negativeIndicator = new Mesh( indicatorGeo, negativeIndicatorMaterial );
					negativeIndicator.rotationX = 180;
					negativeIndicator.x = x;
					negativeIndicator.y = -1;
					negativeIndicator.z = z;
					elevationModel.add( negativeIndicator, false );
					addObjectToSceneRequest.dispatch( negativeIndicator );
				}
			}
			
			// Show/hide stats.
			showStatsRequest.dispatch( true );
			
			// Start interaction.
			setEditingModeRequest.dispatch( EditingModeModel.LOOK );
			
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateViewCommand, TimeEvent );
			
			// Create a new file.
			newFileRequest.dispatch();
		}
	}
}