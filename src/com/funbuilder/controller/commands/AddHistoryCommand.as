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
		
		// Arguments.
		
		[Inject]
		public var subtle:Boolean;
		
		// Models.
		
		[Inject]
		public var historyModel:HistoryModel;
		
		[Inject]
		public var segmentModel:CurrentSegmentModel;
		
		[Inject]
		public var currentBlockModel:CurrentBlockModel;
		
		override public function execute():void
		{
			// Save history for:
			// - First reposition
			// - First type change
			// - Add new block
			// - Delete block
			
			var snapshot:String = segmentModel.getJson();
			var selectedBlockPos:Vector3D = ( currentBlockModel.hasBlock() ) ? currentBlockModel.getPositionClone() : null;
			var history:HistoryVO = new HistoryVO( snapshot, selectedBlockPos );
			
			// Save history snapshot if not identical to the current history snapshot.
			var current:HistoryVO = historyModel.getCurrent();
			if ( !current || current.snapshot != history.snapshot ) {
				historyModel.add( history, subtle );
			}
		}
	}
}