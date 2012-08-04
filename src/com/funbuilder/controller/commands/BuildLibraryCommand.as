package com.funbuilder.controller.commands
{
	import away3d.containers.View3D;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	
	import com.funbuilder.controller.signals.AddItemToLibraryRequest;
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.controller.signals.RemoveObjectFromSceneRequest;
	import com.funbuilder.model.BlocksModel;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.View3DModel;
	import com.funbuilder.model.constants.SegmentConstants;
	import com.funbuilder.model.vo.AddItemToLibraryVO;
	
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
		public var blocksModel:BlocksModel;
		
		[Inject]
		public var view3dModel:View3DModel;
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
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
				
				var view:View3D = view3dModel.view;
				var prevWidth:Number = view.width;
				var prevHeight:Number = view.height;
				var prevGroundAlpha:Number = ( view3dModel.groundPlane.material as ColorMaterial ).alpha;
				var prevTargetAlpha:Number = ( cameraTargetModel.target.material as ColorMaterial ).alpha;
				view.width = view.height = 700;
				( view3dModel.groundPlane.material as ColorMaterial ).alpha = 0;
				( cameraTargetModel.target.material as ColorMaterial ).alpha = 0;
				var block:Mesh;
				for ( var i:int = 0; i < blocksModel.numBlocks; i++ ) {
					// Add block to scene.
					block = blocksModel.getAt( i ).mesh.clone() as Mesh;
					block.x = SegmentConstants.SEGMENT_HALF_WIDTH;
					block.y = -50;
					block.z = SegmentConstants.SEGMENT_HALF_DEPTH;
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
					blocksModel.addBitmap( bitmap, block.name );
					// Remove it from scene.
					removeObjectFromSceneRequest.dispatch( block );
					// Add to library.
					addItemToLibraryRequest.dispatch( new AddItemToLibraryVO( blocksModel.getAt( i ), bitmap ) );
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