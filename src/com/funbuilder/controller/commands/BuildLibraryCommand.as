package com.funbuilder.controller.commands
{
	import away3d.containers.View3D;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.materials.TextureMaterial;
	
	import com.funbuilder.controller.signals.AddItemToLibraryRequest;
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.controller.signals.RemoveObjectFromSceneRequest;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.LightsModel;
	import com.funbuilder.model.View3dModel;
	import com.funbuilder.model.vo.AddItemToLibraryVo;
	import com.funrun.model.BlockStylesModel;
	import com.funrun.model.constants.Segment;
	import com.funrun.model.vo.BlockStyleVo;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.robotlegs.utilities.macrobot.AsyncCommand;
	
	public class BuildLibraryCommand extends AsyncCommand
	{
		// Models.
		
		[Inject]
		public var blockStylesModel:BlockStylesModel;
		
		[Inject]
		public var view3dModel:View3dModel;
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		[Inject]
		public var lightsModel:LightsModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		[Inject]
		public var addItemToLibraryRequest:AddItemToLibraryRequest;
		
		private var _count:int = 0;
		
		override public function execute():void
		{
			this.contextView.addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		private function onEnterFrame( e:Event ):void {
			
			_count++;
			if ( _count == 10 ) {
				this.contextView.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
				
				view3dModel.cameraController.distance = 600;
				
				lightsModel.light.x = Segment.HALF_WIDTH - 500;
				lightsModel.light.y = 700;
				lightsModel.light.z = Segment.HALF_DEPTH - 500;
				
				var view:View3D = view3dModel.view;
				var prevWidth:Number = view.width;
				var prevHeight:Number = view.height;
				var prevGroundAlpha:Number = ( view3dModel.groundPlane.material as ColorMaterial ).alpha;
				var prevTargetAlpha:Number = ( cameraTargetModel.target.material as ColorMaterial ).alpha;
				view.width = view.height = 700;
				( view3dModel.groundPlane.material as ColorMaterial ).alpha = 0;
				( cameraTargetModel.target.material as ColorMaterial ).alpha = 0;
				var block:Mesh;
				var style:BlockStyleVo = blockStylesModel.getStyle( "default" );
				var keys:Array = style.getKeys();
				for ( var i:int = 0; i < style.length; i++ ) {
					// Add block to scene.
					block = style.getMeshAt( i ).clone() as Mesh;
					block.x = Segment.HALF_WIDTH;
					block.z = Segment.HALF_DEPTH;
					block.y = -50;
					
					// Apply lights.
					var material:TextureMaterial = block.material as TextureMaterial;
					material.lightPicker = lightsModel.lightPicker;
					material.specular = .25;
					material.gloss = 20;
					material.specularMethod = lightsModel.specularMethod;
					
					addObjectToSceneRequest.dispatch( block );
					// Take snapshot.
					var snapshot:BitmapData = new BitmapData( view.width, view.height );
					view.renderer.swapBackBuffer = false;
					view.render();
					view.stage3DProxy.context3D.drawToBitmapData( snapshot ); 
					view.renderer.swapBackBuffer = true;
					// Store bitmap.
					var bmp:BitmapData = new BitmapData( 120, 100 );
					bmp.copyPixels( snapshot, new Rectangle( 290, 300, 120, 100 ), new Point() );
					var bitmap:Bitmap = new Bitmap( bmp );
					style.addBitmap( bitmap, block.name );
					// Remove it from scene.
					removeObjectFromSceneRequest.dispatch( block );
					// Add to library.
					addItemToLibraryRequest.dispatch( new AddItemToLibraryVo( keys[ i ], keys[ i ], bitmap ) );
				}
				view.width = prevWidth;
				view.height = prevHeight;
				( view3dModel.groundPlane.material as ColorMaterial ).alpha = prevGroundAlpha;
				( cameraTargetModel.target.material as ColorMaterial ).alpha = prevTargetAlpha;
				dispatchComplete( true );
			}
		}
	}
}