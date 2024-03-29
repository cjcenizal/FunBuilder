package com.funbuilder.controller.commands
{
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.FresnelSpecularMethod;
	import away3d.primitives.CylinderGeometry;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.SphereGeometry;
	
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.controller.signals.AddView3DRequest;
	import com.funbuilder.controller.signals.NewFileRequest;
	import com.funbuilder.controller.signals.RemoveObjectFromSceneRequest;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.ElevationModel;
	import com.funbuilder.model.HandlesModel;
	import com.funbuilder.model.LightsModel;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.TimeModel;
	import com.funbuilder.model.View3dModel;
	import com.funbuilder.model.events.TimeEvent;
	import com.funrun.model.BlockStylesModel;
	import com.funrun.model.BlockTypesModel;
	import com.funrun.model.constants.Block;
	import com.funrun.model.constants.Segment;
	import com.funrun.model.vo.BlockStyleVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class BuildViewCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		[Inject]
		public var timeModel:TimeModel;
		
		[Inject]
		public var view3dModel:View3dModel;
		
		[Inject]
		public var elevationModel:ElevationModel;
		
		[Inject]
		public var handlesModel:HandlesModel;
		
		[Inject]
		public var lightsModel:LightsModel;
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		[Inject]
		public var blockStylesModel:BlockStylesModel;
		
		[Inject]
		public var blockTypesModel:BlockTypesModel;
		
		// Commands.
		
		[Inject]
		public var addView3DRequest:AddView3DRequest;
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
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
			var target:Mesh = new Mesh( new SphereGeometry( 4 ), null );
			target.material = new ColorMaterial( 0xffffff, .5 );
			cameraTargetModel.setMesh( target );
			cameraTargetModel.setPos( Segment.HALF_WIDTH, 0, Segment.HALF_DEPTH );
			addObjectToSceneRequest.dispatch( target );
			
			// Add camera controller.
			var cameraController:HoverController = new HoverController( camera, target, 180 + 45, 20 );
			cameraController.steps = 1;
			view3dModel.cameraController = cameraController;
			
			// Add ground plane.
			var planeGeometry:PlaneGeometry = new PlaneGeometry( Segment.WIDTH, Segment.DEPTH, 12, 26, true );
			var planeMaterial:ColorMaterial = new ColorMaterial( 0xffffff, .2 );
			planeMaterial.bothSides = true;
			var planeMesh:Mesh = new Mesh( planeGeometry, planeMaterial );
			planeMesh.x = Segment.HALF_WIDTH;
			planeMesh.y = Block.SIZE * -.5;
			planeMesh.z = Segment.HALF_DEPTH;
			planeMesh.visible = false;
			addObjectToSceneRequest.dispatch( planeMesh );
			view3dModel.groundPlane = planeMesh;
			
			// Add ground bounds.
			var lineThickness:Number = 3;
			var lineMaterial:ColorMaterial = new ColorMaterial( 0xffffff, .2 );
			var line:Mesh = new Mesh( new CylinderGeometry( lineThickness, lineThickness, 1 ), lineMaterial );
			line.scaleY = Segment.WIDTH;
			line.rotationZ = 90;
			line.x = Segment.WIDTH * .5;
			line.y = -Block.SIZE * .5;
			addObjectToSceneRequest.dispatch( line );
			line = line.clone() as Mesh;
			line.z = Segment.DEPTH;
			addObjectToSceneRequest.dispatch( line );
			line = line.clone() as Mesh;
			line.rotationX = 90;
			line.scaleY = Segment.DEPTH;
			line.x = 0;
			line.z = Segment.DEPTH * .5;
			addObjectToSceneRequest.dispatch( line );
			line = line.clone() as Mesh;
			line.x = Segment.WIDTH;
			addObjectToSceneRequest.dispatch( line );
			
			// Add elevation indicators.
			var positiveIndicator:Mesh;
			var negativeIndicator:Mesh;
			var side:Number = Block.SIZE - 3;
			var indicatorGeo:Geometry = new PlaneGeometry( side, side );
			for ( var x:int = Block.SIZE * .5; x < Segment.WIDTH; x += Block.SIZE ) {
				for ( var z:int = Block.SIZE * .5; z < Segment.DEPTH; z += Block.SIZE ) {
					var positiveIndicatorMaterial:ColorMaterial = new ColorMaterial( 0xddffdd, .8 );
					var negativeIndicatorMaterial:ColorMaterial = new ColorMaterial( 0xddffdd, .8 );
					positiveIndicatorMaterial.bothSides = false;
					negativeIndicatorMaterial.bothSides = false;
					
					positiveIndicator = new Mesh( indicatorGeo, positiveIndicatorMaterial );
					positiveIndicator.x = x;
					positiveIndicator.y = -Block.SIZE * .5 + 1;
					positiveIndicator.z = z;
					positiveIndicator.visible = false;
					elevationModel.add( positiveIndicator, true );
					addObjectToSceneRequest.dispatch( positiveIndicator );
					
					negativeIndicator = new Mesh( indicatorGeo, negativeIndicatorMaterial );
					negativeIndicator.rotationX = 180;
					negativeIndicator.x = x;
					negativeIndicator.y = -Block.SIZE * .5 - 1;
					negativeIndicator.z = z;
					negativeIndicator.visible = false;
					elevationModel.add( negativeIndicator, false );
					addObjectToSceneRequest.dispatch( negativeIndicator );
				}
			}
			
			// Add handles.
			addObjectToSceneRequest.dispatch( handlesModel.xHandle );
			addObjectToSceneRequest.dispatch( handlesModel.yHandle );
			addObjectToSceneRequest.dispatch( handlesModel.zHandle );
			addObjectToSceneRequest.dispatch( handlesModel.xLine );
			addObjectToSceneRequest.dispatch( handlesModel.yLine );
			addObjectToSceneRequest.dispatch( handlesModel.zLine );
			handlesModel.moveTo( Segment.HALF_WIDTH, 0, Segment.HALF_DEPTH );
			
			// Add lights.
			var light:PointLight = new PointLight();
			light.color = 0xffffff;
			light.diffuse = 1;
			light.specular = 1;
			light.radius = 1200;
			light.fallOff = 8000;
			light.ambientColor = 0xa0a0c0;
			light.ambient = .5;
			addObjectToSceneRequest.dispatch( light );
			
			lightsModel.light = light;
			lightsModel.lightPicker = new StaticLightPicker( [ light ] );
			lightsModel.specularMethod = new FresnelSpecularMethod();
			
			// Light materials.
			for ( var i:int = 0; i < blockStylesModel.numStyles; i++ ) {
				var style:BlockStyleVo = blockStylesModel.getStyleAt( i );
				for ( var j:int = 0; j < style.length; j++ ) {
					var mesh:Mesh = style.getMeshAt( j );
					var material:TextureMaterial = mesh.material as TextureMaterial;
					material.lightPicker = lightsModel.lightPicker;
					material.specular = .25;
					material.gloss = 20;
					material.specularMethod = lightsModel.specularMethod;
					addObjectToSceneRequest.dispatch( mesh );
					removeObjectFromSceneRequest.dispatch( mesh );
				}
			}
			
			// Respond to time.
			commandMap.mapEvent( TimeEvent.TICK, UpdateViewCommand, TimeEvent );
			
		}
	}
}