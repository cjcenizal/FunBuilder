package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.UpdateCollisionsRequest;
	import com.funbuilder.controller.signals.UpdateElevationRequest;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateHudCommand extends Command
	{
		
		// Commands.
		
		[Inject]
		public var updateCollisionsRequest:UpdateCollisionsRequest;
		
		[Inject]
		public var updateElevationRequest:UpdateElevationRequest;
		
		override public function execute():void {
			
			// Update collisions.
			updateCollisionsRequest.dispatch();
			
			// Update elevation.
			updateElevationRequest.dispatch();
			
		}
	}
}