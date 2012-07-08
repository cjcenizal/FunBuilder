package com.funbuilder.controller.commands {

	import com.funbuilder.controller.signals.ClearHistoryRequest;
	import com.funbuilder.controller.signals.ClearSegmentRequest;
	import com.funbuilder.model.FileModel;
	
	import flash.filesystem.File;
	
	import org.robotlegs.mvcs.Command;

	public class NewFileCommand extends Command {

		// Models.
		[Inject]
		public var fileModel:FileModel;
		
		// Commands.
		
		[Inject]
		public var clearSegmentRequest:ClearSegmentRequest;
		
		[Inject]
		public var clearHistoryRequest:ClearHistoryRequest;
		
		override public function execute():void {
			var path:String = ( fileModel.file ) ? fileModel.file.parent.nativePath : File.applicationDirectory.nativePath;
			fileModel.file = new File( path );
			clearSegmentRequest.dispatch();
			clearHistoryRequest.dispatch();
		}
	}
}
