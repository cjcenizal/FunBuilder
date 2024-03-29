package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.DrawHandlesRequest;
	import com.funbuilder.controller.signals.HideHandlesRequest;
	import com.funbuilder.model.HandlesModel;
	import com.funbuilder.model.KeyboardModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.View3dModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateHandlesCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		[Inject]
		public var handlesModel:HandlesModel;
		
		[Inject]
		public var view3dModel:View3dModel;
		
		[Inject]
		public var keysModel:KeyboardModel;
		
		// Commands.
		
		[Inject]
		public var drawHandlesRequest:DrawHandlesRequest;
		
		[Inject]
		public var hideHandlesRequest:HideHandlesRequest;
		
		override public function execute():void {
			if ( !handlesModel.isGrabbed && ( keysModel.alt || keysModel.shift ) ) {
				handlesModel.hide();
				hideHandlesRequest.dispatch();
			} else {
				if ( selectedBlocksModel.numBlocks > 0 ) {
					selectedBlocksModel.update();
					handlesModel.show();
					handlesModel.setSize( selectedBlocksModel.max * .5 );
					handlesModel.moveTo( selectedBlocksModel.centroid.x, selectedBlocksModel.centroid.y, selectedBlocksModel.centroid.z );
					drawHandlesRequest.dispatch(
						view3dModel.project( handlesModel.xLine.position ), view3dModel.project( handlesModel.xHandle.position ), handlesModel.xColor,
						view3dModel.project( handlesModel.yLine.position ), view3dModel.project( handlesModel.yHandle.position ), handlesModel.yColor,
						view3dModel.project( handlesModel.zLine.position ), view3dModel.project( handlesModel.zHandle.position ), handlesModel.zColor );
				} else {
					handlesModel.hide();
					hideHandlesRequest.dispatch();
				}
			}
		}
	}
}