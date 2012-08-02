package com.funbuilder.controller.commands
{
	import com.funbuilder.model.HandlesModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class GrabHandleCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var axis:String;
		
		// Models.
		
		[Inject]
		public var handlesModel:HandlesModel;
		
		override public function execute():void {
			// Store grabbed handle.
			handlesModel.grab( true, axis );
		}
	}
}