package com.funbuilder.controller.commands {

	import com.funbuilder.controller.signals.ClearHistoryRequest;
	import com.funbuilder.controller.signals.LoadSegmentRequest;
	import com.funbuilder.controller.signals.ShowFileNameRequest;
	import com.funbuilder.model.FileModel;
	import com.funbuilder.model.KeysModel;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	import org.robotlegs.mvcs.Command;
	
	public class OpenFileCommand extends Command {

		// Models.
		
		[Inject]
		public var fileModel:FileModel;
		
		[Inject]
		public var keysModel:KeysModel;
		
		// Commands.
		
		[Inject]
		public var loadSegmentRequest:LoadSegmentRequest;
		
		[Inject]
		public var clearHistoryRequest:ClearHistoryRequest;
		
		[Inject]
		public var showFileNameRequest:ShowFileNameRequest;
		
		// Private vars.
		
		private var _file:File;
		
		override public function execute():void {
			keysModel.clearModifiers();
			_file = new File();
			_file.addEventListener( Event.SELECT, onSelectFileToOpen );
			_file.browseForOpen( "Select a Segment JSON file to open" );
		}
		
		private function onSelectFileToOpen( e:Event ):void {
			_file.removeEventListener( Event.SELECT, onSelectFileToOpen );
			_file = null;
			fileModel.file = File( e.currentTarget );
			fileModel.file.addEventListener( Event.COMPLETE, onLoadComplete );
			fileModel.file.load();
		}
		
		private function onLoadComplete( e:Event ):void {
			fileModel.file.removeEventListener( Event.COMPLETE, onLoadComplete );
			clearHistoryRequest.dispatch();
			loadSegmentRequest.dispatch( String( fileModel.file.data ) );
			showFileNameRequest.dispatch( fileModel.file.nativePath );
		}
	}
}
