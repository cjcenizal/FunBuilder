package com.funbuilder.controller.commands
{
	import com.funbuilder.model.SelectedBlockModel;
	import com.funbuilder.model.SegmentModel;
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
		public var segmentModel:SegmentModel;
		
		[Inject]
		public var selectedBlockModel:SelectedBlockModel;
		
		override public function execute():void
		{
			
			var snapshot:String = segmentModel.getJson();
			var selectedBlockKey:String = ( selectedBlockModel.hasBlock() ) ? segmentModel.getKeyFor( selectedBlockModel.getBlock() ) : null;
			var history:HistoryVO = new HistoryVO( snapshot, selectedBlockKey );
			
			// Save history snapshot if not identical to the current history snapshot.
			var current:HistoryVO = historyModel.getCurrent();
			if ( !current || current.snapshot != history.snapshot ) {
				historyModel.add( history, subtle );
			}
		}
	}
}