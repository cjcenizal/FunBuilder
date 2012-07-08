package com.funbuilder.controller.commands
{
	import away3d.containers.View3D;
	
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.controller.signals.RemoveObjectFromSceneRequest;
	import com.funbuilder.model.BlocksModel;
	import com.funbuilder.model.View3DModel;
	import com.funrun.model.vo.BlockVO;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
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
				addObjectToSceneRequest.dispatch( block.mesh );
				// Take snapshot.
				var bmp:BitmapData = new BitmapData( view.width, view.height );
				view.renderer.swapBackBuffer = false;
				view.render();
				view.stage3DProxy.context3D.drawToBitmapData( bmp ); 
				view.renderer.swapBackBuffer = true;
				// Store bitmap.
				var bitmap:Bitmap = new Bitmap( bmp );
				blocksModel.addBitmap( bitmap, block.id );
				// Remove it from scene.
				removeObjectFromSceneRequest.dispatch( block.mesh );
			}
			
			dispatchComplete( true );
		}
	}
}