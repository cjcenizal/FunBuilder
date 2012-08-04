package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.BrushBlockRequest;
	import com.funbuilder.controller.signals.UpdateBrushRequest;
	import com.funbuilder.model.BrushModel;
	import com.funbuilder.model.KeysModel;
	import com.funbuilder.model.MouseModel;
	
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class MouseMoveCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var mouseModel:MouseModel;
		
		[Inject]
		public var brushModel:BrushModel;
		
		[Inject]
		public var keysModel:KeysModel;
		
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
			if ( brushModel.preview ) {
				// If we're in brush mode, then see if we need to place a block.
				if ( mouseModel.isMoving && keysModel.contains( Keyboard.A ) ) {
					if ( brushModel.hasMoved ) {
						brushBlockRequest.dispatch();
					}
				}
			}
		}
	}
}