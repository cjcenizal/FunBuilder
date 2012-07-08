package com.funbuilder.view.mediators
{
	import com.funbuilder.controller.signals.AddItemToLibraryRequest;
	import com.funbuilder.model.vo.AddItemToLibraryVO;
	import com.funbuilder.view.components.LibraryView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class LibraryMediator extends Mediator implements IMediator
	{
		
		// View.
		
		[Inject]
		public var view:LibraryView;
		
		// Commands.
		
		[Inject]
		public var addItemToLibraryRequest:AddItemToLibraryRequest;
		
		override public function onRegister():void {
			addItemToLibraryRequest.add( onAddItemToLibraryRequested );
		}
		
		private function onAddItemToLibraryRequested( data:AddItemToLibraryVO ):void {
			view.addItem( data.block.id, data.bitmap );
		}
	}
}