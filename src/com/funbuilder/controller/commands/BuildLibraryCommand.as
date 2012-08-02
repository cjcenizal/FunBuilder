package com.funbuilder.controller.commands
{
	import away3d.containers.View3D;
	import away3d.materials.ColorMaterial;
	
	import com.funbuilder.controller.signals.AddItemToLibraryRequest;
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.controller.signals.RemoveObjectFromSceneRequest;
	import com.funbuilder.model.BlocksModel;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.View3DModel;
	import com.funbuilder.model.constants.SegmentConstants;
	import com.funbuilder.model.vo.AddItemToLibraryVO;
	import com.funrun.model.vo.BlockVO;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.robotlegs.mvcs.Command;
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
		
		override public function execute():void
		{
			this.contextView.addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		private function onEnterFrame( e:Event ):void {
			this.contextView.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			
			var view:View3D = view3dModel.view;
			var prevWidth:Number = view.width;
			var prevHeight:Number = view.height;
			var prevGroundAlpha:Number = ( view3dModel.groundPlane.material as ColorMaterial ).alpha;
			var prevTargetAlpha:Number = ( cameraTargetModel.target.material as ColorMaterial ).alpha;
			view.width = view.height = 700;
			( view3dModel.groundPlane.material as ColorMaterial ).alpha = 0;
			( cameraTargetModel.target.material as ColorMaterial ).alpha = 0;
			var block:BlockVO;
			for ( var i:int = 0; i < blocksModel.numBlocks; i++ ) {
				// Add block to scene.
				block = blocksModel.getAt( i );
				block.mesh.x = SegmentConstants.SEGMENT_HALF_WIDTH;
				block.mesh.y = -50;
				block.mesh.z = SegmentConstants.SEGMENT_HALF_DEPTH;
				addObjectToSceneRequest.dispatch( block.mesh );
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
				blocksModel.addBitmap( bitmap, block.id );
				// Remove it from scene.
				removeObjectFromSceneRequest.dispatch( block.mesh );
				// Add to library.
				addItemToLibraryRequest.dispatch( new AddItemToLibraryVO( block, bitmap ) );
			}
			view.width = prevWidth;
			view.height = prevHeight;
			( view3dModel.groundPlane.material as ColorMaterial ).alpha = prevGroundAlpha;
			( cameraTargetModel.target.material as ColorMaterial ).alpha = prevTargetAlpha;
			dispatchComplete( true );
		}
	}
}