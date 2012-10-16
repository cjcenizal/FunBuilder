package com.funbuilder.view.mediators
{
	import com.funbuilder.controller.signals.BrushBlockRequest;
	import com.funbuilder.controller.signals.AddItemToLibraryRequest;
	import com.funbuilder.controller.signals.SelectBrushRequest;
	import com.funbuilder.model.vo.AddItemToLibraryVo;
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
		public var selectLibraryBlockRequest:SelectBrushRequest;
		
		override public function onRegister():void {
			view.addEventListener( view.EVENT_SELECT, onSelectItem );
			addItemToLibraryRequest.add( onAddItemToLibraryRequested );
		}
		
		private function onSelectItem( e:Event ):void {
			selectLibraryBlockRequest.dispatch( view.selected );
		}
		
		private function onAddItemToLibraryRequested( data:AddItemToLibraryVo ):void {
			view.addItem( data.id, data.name, data.bitmap );
		}
	}
}