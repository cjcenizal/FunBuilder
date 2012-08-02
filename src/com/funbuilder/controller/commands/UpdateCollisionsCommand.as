package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlocksModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateCollisionsCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		override public function execute():void {
			// Compared each block to every other block.
			// If it's colliding, color it red, else, color it yellow if selected, hide if not.
			var len:int = segmentModel.numBlocks;
			var thisBlock:Mesh;
			var thatBlock:Mesh;
			var colliding:Boolean;
			for ( var i:int = 0; i < len; i++ ) {
				thisBlock = segmentModel.getAt( i );
				colliding = false;
				for ( var j:int = i + 1; j < len; j++ ) {
					thatBlock = segmentModel.getAt( j );
					// If colliding.
					if ( thisBlock.position.equals( thatBlock.position ) ) {
						colliding = true;
						break;
					}
				}
				if ( colliding ) {
					// Color red and show.
					segmentModel.enableIndicatorFor( thisBlock, true, true );
				} else if ( selectedBlocksModel.contains( thisBlock ) ) {
					// Color yellow and show.
					segmentModel.enableIndicatorFor( thisBlock );
				} else {
					// Hide.
					segmentModel.enableIndicatorFor( thisBlock, false );
				}
			}
		}
	}
}