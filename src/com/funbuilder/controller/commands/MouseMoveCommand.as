package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.BrushBlockRequest;
	import com.funbuilder.controller.signals.UpdateBrushRequest;
	import com.funbuilder.model.BrushModel;
	import com.funbuilder.model.KeyboardModel;
	import com.funbuilder.model.MouseModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class MouseMoveCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var mouseModel:MouseModel;
		
		[Inject]
		public var brushModel:BrushModel;
		
		[Inject]
		public var keysModel:KeyboardModel;
		
		// Commands.
		
		[Inject]
		public var updateBrushRequest:UpdateBrushRequest;
		
		[Inject]
		public var brushBlockRequest:BrushBlockRequest;
		
		override public function execute():void {
			// Update mouse.
			mouseModel.moveMouse( contextView.stage.mouseX, contextView.stage.mouseY );
			
			// Update brush.
			updateBrushRequest.dispatch();
			
			// Add blocks with brush.
			if ( mouseModel.isMoving && mouseModel.mouseDown ) {
				if ( brushModel.hasMoved ) {
					brushBlockRequest.dispatch();
				}
			}
		}
	}
}