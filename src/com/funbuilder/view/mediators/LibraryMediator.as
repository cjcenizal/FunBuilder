package com.funbuilder.view.mediators
{
	import com.funbuilder.controller.signals.AddBlockFromLibraryRequest;
	import com.funbuilder.controller.signals.AddItemToLibraryRequest;
	import com.funbuilder.model.vo.AddItemToLibraryVO;
	import com.funbuilder.view.components.LibraryView;
	
	import flash.events.Event;
	
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
		
		[Inject]
		public var addBlockFromLibraryRequest:AddBlockFromLibraryRequest;
		
		override public function onRegister():void {
			view.addEventListener( view.EVENT_SELECT, onSelectItem );
			addItemToLibraryRequest.add( onAddItemToLibraryRequested );
		}
		
		private function onSelectItem( e:Event ):void {
			addBlockFromLibraryRequest.dispatch( view.selectedId );
		}
		
		private function onAddItemToLibraryRequested( data:AddItemToLibraryVO ):void {
			view.addItem( data.block.id, data.bitmap );
		}
	}
}