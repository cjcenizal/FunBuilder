package com.funbuilder.view.mediators {

	import com.funbuilder.view.components.MenuBarView;
	
	import flash.events.Event;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;

	public class MenuBarMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:MenuBarView;
		
		override public function onRegister():void {
			view.addEventListener( MenuBarView.EVENT_NEW, onSelectNew );
		}
		
		private function onSelectNew( e:Event ):void {
			trace("new");
		}
		
	}
}
