package com.funbuilder.view.mediators {

	import com.funbuilder.controller.signals.NewFileRequest;
	import com.funbuilder.controller.signals.OpenFileRequest;
	import com.funbuilder.controller.signals.SaveFileRequest;
	import com.funbuilder.controller.signals.UndoEditRequest;
	import com.funbuilder.view.components.MenuBarView;
	
	import flash.events.Event;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;

	public class MenuBarMediator extends Mediator implements IMediator {
		
		// View.
		
		[Inject]
		public var view:MenuBarView;
		
		// Commands.
		
		[Inject]
		public var newFileRequest:NewFileRequest;
		
		[Inject]
		public var openFileRequest:OpenFileRequest;
		
		[Inject]
		public var saveFileRequest:SaveFileRequest;
		
		[Inject]
		public var undoEditRequest:UndoEditRequest;
		
		override public function onRegister():void {
			view.addEventListener( MenuBarView.EVENT_NEW, onSelectNew );
			view.addEventListener( MenuBarView.EVENT_OPEN, onSelectOpen );
			view.addEventListener( MenuBarView.EVENT_SAVE, onSelectSave );
			view.addEventListener( MenuBarView.EVENT_UNDO, onSelectUndo );
		}
		
		private function onSelectNew( e:Event ):void {
			newFileRequest.dispatch();
		}
		
		private function onSelectOpen( e:Event ):void {
			openFileRequest.dispatch();
		}
		
		private function onSelectSave( e:Event ):void {
			saveFileRequest.dispatch();
		}
		
		private function onSelectUndo( e:Event ):void {
			undoEditRequest.dispatch();
		}
	}
}
