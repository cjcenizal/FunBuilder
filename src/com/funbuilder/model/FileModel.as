package com.funbuilder.model
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * FileModel contains the current file the user is working with.
	 */
	public class FileModel extends Actor
	{
		
		public var file:File;
		
		public function FileModel()
		{
			super();
		}
		
	}
}