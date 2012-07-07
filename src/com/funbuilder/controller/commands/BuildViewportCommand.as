package com.funbuilder.controller.commands
{
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.PlaneGeometry;
	
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.controller.signals.AddView3DRequest;
	import com.funbuilder.controller.signals.ShowStatsRequest;
	import com.funbuilder.model.TimeModel;
	import com.funbuilder.model.View3DModel;
	import com.funbuilder.model.events.TimeEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class BuildViewportCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var timeModel:TimeModel;
		
		[Inject]
		public var view3dModel:View3DModel;
		
		// Commands.
		
		[Inject]
		public var addView3DRequest:AddView3DRequest;
		
		[Inject]
		public var showStatsRequest:ShowStatsRequest;
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		override public function execute():void
		{
			// Time.
			timeModel.stage = contextView.stage;
			timeModel.init();
			
			// Add view.
			var scene:Scene3D = new Scene3D();
			var camera:Camera3D = new Camera3D( new PerspectiveLens( 90 ) );
			camera.lens.far = 10000;
			var view:View3D = new View3D( scene, camera );
			view.antiAlias = 2; // 2, 4, or 16
			view.width = contextView.stage.stageWidth;
			view.height = contextView.stage.stageHeight;
			view.backgroundColor = 0;
			view3dModel.setView( view );
			addView3DRequest.dispatch( view );
			
			// Add ground plane.
			var planeGeometry:PlaneGeometry = new PlaneGeometry( 12 * 100, 26 * 100, 12, 26, true );
			var planeMaterial:ColorMaterial = new ColorMaterial( 0xffffff, .1 );
			planeMaterial.bothSides = true;
			var planeMesh:Mesh = new Mesh( planeGeometry, planeMaterial );
			addObjectToSceneRequest.dispatch( planeMesh );
			
			// Show stats.
			showStatsRequest.dispatch( true );
			
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateViewCommand, TimeEvent );
			
		}
	}
}