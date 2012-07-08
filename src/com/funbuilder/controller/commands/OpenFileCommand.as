package com.funbuilder.controller.commands {

	import com.funbuilder.controller.signals.LoadSegmentRequest;
	import com.funbuilder.model.FileModel;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	import org.robotlegs.mvcs.Command;
	
	public class OpenFileCommand extends Command {

		// Models.
		
		[Inject]
		public var fileModel:FileModel;
		
		// Commands.
		
		[Inject]
		public var loadSegmentRequest:LoadSegmentRequest;
		
		// Private vars.
		
		private var _file:File;
		
		override public function execute():void {
			_file = new File();
			_file.addEventListener( Event.SELECT, onSelectFileToOpen );
			_file.browseForOpen( "Select a Segment JSON file to open" );
		}
		
		private function onSelectFileToOpen( e:Event ):void {
			_file.removeEventListener( Event.SELECT, onSelectFileToOpen );
			fileModel.file = File( e.currentTarget );
			fileModel.file.addEventListener( Event.COMPLETE, onLoadComplete );
			fileModel.file.load();
		}
		
		private function onLoadComplete( e:Event ):void {
			fileModel.file.removeEventListener( Event.COMPLETE, onLoadComplete );
			loadSegmentRequest.dispatch( String( fileModel.file.data ) );
		}
	}
}
