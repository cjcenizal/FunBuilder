package com.funbuilder.controller.commands
{
	import com.funbuilder.model.HandlesModel;
	import com.funbuilder.model.SelectedBlocksModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateHandlesCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		[Inject]
		public var handlesModel:HandlesModel;
		
		override public function execute():void {
			if ( selectedBlocksModel.numBlocks > 0 ) {
				selectedBlocksModel.update();
				handlesModel.show();
				handlesModel.setSize( selectedBlocksModel.max * .5 );
				handlesModel.moveTo( selectedBlocksModel.centroid.x, selectedBlocksModel.centroid.y, selectedBlocksModel.centroid.z );
			} else {
				handlesModel.hide();
			}
		}
	}
}