package com.funbuilder.controller.commands
{
	import com.funbuilder.model.CurrentBlockModel;
	import com.funbuilder.model.CurrentSegmentModel;
	import com.funbuilder.model.HistoryModel;
	import com.funbuilder.model.vo.HistoryVO;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddHistoryCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var currentBlockModel:CurrentBlockModel;
		
		[Inject]
		public var currentSegmentModel:CurrentSegmentModel;
		
		[Inject]
		public var historyModel:HistoryModel;
		
		override public function execute():void
		{
			// Save history for:
			// - First reposition
			// - First type change
			// - Add new block
			// - Delete block
			
			var snapshot:String = currentSegmentModel.getJson();
			var selectedBlockPos:Vector3D = ( currentBlockModel.hasBlock() ) ? currentBlockModel.getPositionClone() : null;
			// Save history snapshot if not identical to the current history snapshot.
			var current:HistoryVO = historyModel.getCurrent();
			if ( !current || current.snapshot != snapshot ) {
				var history:HistoryVO = new HistoryVO( snapshot, selectedBlockPos );
				historyModel.add( history );
			}
		}
	}
}