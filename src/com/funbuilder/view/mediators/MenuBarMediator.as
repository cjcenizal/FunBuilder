package com.funbuilder.view.mediators {

	import com.funbuilder.controller.signals.NewFileRequest;
	import com.funbuilder.controller.signals.OpenFileRequest;
	import com.funbuilder.controller.signals.RedoEditRequest;
	import com.funbuilder.controller.signals.SaveFileRequest;
	import com.funbuilder.controller.signals.ShowFileNameRequest;
	import com.funbuilder.controller.signals.ShowSelectionIndicatorRequest;
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
		
		[Inject]
		public var redoEditRequest:RedoEditRequest;
		
		[Inject]
		public var showFileNameRequest:ShowFileNameRequest;
		
		[Inject]
		public var showSelectionIndicatorRequest:ShowSelectionIndicatorRequest;
		
		override public function onRegister():void {
			view.addEventListener( MenuBarView.EVENT_NEW, onSelectNew );
			view.addEventListener( MenuBarView.EVENT_OPEN, onSelectOpen );
			view.addEventListener( MenuBarView.EVENT_SAVE, onSelectSave );
			view.addEventListener( MenuBarView.EVENT_UNDO, onSelectUndo );
			view.addEventListener( MenuBarView.EVENT_REDO, onSelectRedo );
			showFileNameRequest.add( onShowFileNameRequested );
			showSelectionIndicatorRequest.add( onShowSelectionIndicatorRequested );
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
		
		private function onSelectRedo( e:Event ):void {
			redoEditRequest.dispatch();
		}
		
		private function onShowFileNameRequested( fileName:String ):void {
			view.showFileName( fileName );
		}
		
		private function onShowSelectionIndicatorRequested( visible:Boolean ):void {
			view.showSelectionIndicator( visible );
		}
	}
}
