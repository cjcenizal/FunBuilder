package com.funbuilder.controller.commands
{
	import away3d.containers.View3D;
	
	import com.funbuilder.controller.signals.AddItemToLibraryRequest;
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.controller.signals.RemoveObjectFromSceneRequest;
	import com.funbuilder.model.BlocksModel;
	import com.funbuilder.model.View3DModel;
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
			var block:BlockVO;
			for ( var i:int = 0; i < blocksModel.numBlocks; i++ ) {
				// Add block to scene.
				block = blocksModel.getBlockAt( i );
				block.mesh.x = 580;
				block.mesh.y = 110;
				block.mesh.z = 900;
				addObjectToSceneRequest.dispatch( block.mesh );
				// Take snapshot.
				var snapshot:BitmapData = new BitmapData( view.width, view.height );
				view.renderer.swapBackBuffer = false;
				view.render();
				view.stage3DProxy.context3D.drawToBitmapData( snapshot ); 
				view.renderer.swapBackBuffer = true;
				// Store bitmap.
				var bmp:BitmapData = new BitmapData( 100, 100 );
				bmp.copyPixels( snapshot, new Rectangle( 584, 263, 100, 100 ), new Point() );
				var bitmap:Bitmap = new Bitmap( bmp );
				blocksModel.addBitmap( bitmap, block.id );
				// Remove it from scene.
				removeObjectFromSceneRequest.dispatch( block.mesh );
				// Add to library.
				addItemToLibraryRequest.dispatch( new AddItemToLibraryVO( block, bitmap ) );
			}
			
			dispatchComplete( true );
		}
	}
}