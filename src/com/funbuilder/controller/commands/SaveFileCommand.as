package com.funbuilder.controller.commands {

	import com.funbuilder.controller.signals.ShowFileNameRequest;
	import com.funbuilder.model.FileModel;
	import com.funbuilder.model.SegmentModel;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import org.robotlegs.mvcs.Command;

	public class SaveFileCommand extends Command {

		// Models.
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		[Inject]
		public var fileModel:FileModel;
		
		// Commands.
		
		[Inject]
		public var showFileNameRequest:ShowFileNameRequest;
		
		// Private vars.
		
		private var _file:File;
		
		override public function execute():void {
			var path:String = ( fileModel.file ) ? fileModel.file.nativePath : File.applicationDirectory.nativePath;
			_file = new File( path );
			_file.addEventListener( Event.SELECT, onSelectFileToSave );
			_file.browseForSave( "Save your JSON segment." );
		}
		
		private function onSelectFileToSave( e:Event ):void {
			showFileNameRequest.dispatch( _file.nativePath );
			var stream:FileStream = new FileStream();
			stream.open( _file, FileMode.WRITE );
			stream.writeUTFBytes( segmentModel.getJson() );
			stream.close();
			_file.removeEventListener( Event.SELECT, onSelectFileToSave );
			_file = null;
			fileModel.isSaved = true;
		}
	}
}
