package com.funbuilder.controller.commands
{
	import com.funbuilder.model.HistoryModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class ClearHistoryCommand extends Command
	{
		
		[Inject]
		public var historyModel:HistoryModel;
		
		override public function execute():void
		{
			historyModel.clear();
		}
	}
}