package com.funbuilder.controller.commands {

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
		
		// Private vars.
		
		private var _file:File;
		
		override public function execute():void {
			_file = new File();
			_file.addEventListener( Event.SELECT, onSelectFileToSave );
			_file.browseForSave( "Save your JSON segment." );
		}
		
		private function onSelectFileToSave( e:Event ):void {
			var stream:FileStream = new FileStream();
			stream.open( _file, FileMode.WRITE );
			stream.writeUTFBytes( segmentModel.getJson() );
			stream.close();
			_file.removeEventListener( Event.SELECT, onSelectFileToSave );
			_file = null;
		}
	}
}
