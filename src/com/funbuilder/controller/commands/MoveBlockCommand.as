package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.model.SelectedBlockModel;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	public class MoveBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var position:Vector3D;
		
		// Models.
		
		[Inject]
		public var currentBlockModel:SelectedBlockModel;
		
		// Commands.
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		override public function execute():void
		{
			if ( !currentBlockModel.isMoved && currentBlockModel.willMove( position ) ) {
				// Save history if we move the block and it's the first time it gets moved.
				addHistoryRequest.dispatch( false );
			}
			if ( currentBlockModel.willMove( position ) ) {
				currentBlockModel.setPosition( position );
			}
		}
	}
}