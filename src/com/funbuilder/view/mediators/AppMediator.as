package com.funbuilder.view.mediators {

	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;

	public class AppMediator extends Mediator implements IMediator {
		
		[Inject]
		public var view:FunBuilder;

		override public function onRegister():void {
			view.createChildren();
		}
	}
}
