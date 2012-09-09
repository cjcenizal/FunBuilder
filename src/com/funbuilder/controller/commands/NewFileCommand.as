package com.funbuilder.controller.commands {

	import com.funbuilder.controller.signals.ClearHistoryRequest;
	import com.funbuilder.controller.signals.ClearSegmentRequest;
	import com.funbuilder.controller.signals.FillFloorRequest;
	import com.funbuilder.controller.signals.ShowFileNameRequest;
	import com.funbuilder.model.FileModel;
	import com.funbuilder.model.KeyboardModel;
	
	import flash.filesystem.File;
	
	import org.robotlegs.mvcs.Command;

	public class NewFileCommand extends Command {

		// Models.
		
		[Inject]
		public var fileModel:FileModel;
		
		[Inject]
		public var keysModel:KeyboardModel;
		
		// Commands.
		
		[Inject]
		public var clearSegmentRequest:ClearSegmentRequest;
		
		[Inject]
		public var clearHistoryRequest:ClearHistoryRequest;
		
		[Inject]
		public var showFileNameRequest:ShowFileNameRequest;
		
		[Inject]
		public var fillFloorRequest:FillFloorRequest;
		
		override public function execute():void {
			keysModel.clearModifiers();
			var path:String = ( fileModel.file ) ? fileModel.file.parent.nativePath : File.applicationDirectory.nativePath;
			fileModel.file = new File( path );
			clearSegmentRequest.dispatch();
			fillFloorRequest.dispatch();
			clearHistoryRequest.dispatch();
			showFileNameRequest.dispatch( "New file" );
		}
	}
}
