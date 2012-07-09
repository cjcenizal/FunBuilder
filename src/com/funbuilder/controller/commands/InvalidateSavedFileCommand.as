package com.funbuilder.controller.commands
{
	import com.funbuilder.model.FileModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class InvalidateSavedFileCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var fileModel:FileModel;
		
		override public function execute():void
		{
			fileModel.isSaved = false;
		}
	}
}