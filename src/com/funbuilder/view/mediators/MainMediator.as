package com.funbuilder.view.mediators {
	
	import com.funbuilder.view.components.MainView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class MainMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:com.funbuilder.view.components.MainView;
		
		override public function onRegister():void {
		}
		
	}
}
