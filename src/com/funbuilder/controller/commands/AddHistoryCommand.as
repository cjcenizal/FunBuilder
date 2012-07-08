package com.funbuilder.controller.commands
{
	import com.funbuilder.model.HistoryModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddHistoryCommand extends Command
	{
		
		
		
		[Inject]
		public var historyModel:HistoryModel;
		
		override public function execute():void
		{
			trace(this);
			// Save history for:
			// - First reposition
			// - First type change
			// - Add new block
			// - Delete block
		}
	}
}