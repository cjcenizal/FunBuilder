package com.funbuilder.controller.commands {

	import com.funbuilder.controller.signals.ClearHistoryRequest;
	import com.funbuilder.controller.signals.ClearSegmentRequest;
	
	import org.robotlegs.mvcs.Command;

	public class NewFileCommand extends Command {

		[Inject]
		public var clearSegmentRequest:ClearSegmentRequest;
		
		[Inject]
		public var clearHistoryRequest:ClearHistoryRequest;
		
		override public function execute():void {
			// TO-DO: Assign new file here, maybe?
			clearSegmentRequest.dispatch();
			clearHistoryRequest.dispatch();
		}
	}
}
