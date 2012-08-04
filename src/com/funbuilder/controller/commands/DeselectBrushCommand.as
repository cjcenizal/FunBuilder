package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.RemoveObjectFromSceneRequest;
	import com.funbuilder.model.BrushModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class DeselectBrushCommand extends Command
	{
		
		// Model.
		
		[Inject]
		public var brushModel:BrushModel;
		
		// Commands.
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		override public function execute():void {
			if ( brushModel.preview ) {
				removeObjectFromSceneRequest.dispatch( brushModel.preview );
				brushModel.deselect();
			}
		}
	}
}