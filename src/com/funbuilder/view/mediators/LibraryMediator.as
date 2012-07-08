package com.funbuilder.view.mediators
{
	import com.funbuilder.view.components.LibraryView;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class LibraryMediator extends Mediator implements IMediator
	{
		
		// View.
		
		[Inject]
		public var libraryView:LibraryView;
		
		// Commands.
		
		override public function onRegister():void {
			
		}
	}
}