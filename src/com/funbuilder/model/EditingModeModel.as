package com.funbuilder.model
{
	import org.robotlegs.mvcs.Actor;
	
	public class EditingModeModel extends Actor
	{
		
		public static const SELECT:String = "SELECT";
		public static const LOOK:String = "LOOK";
		
		public var mode:String = LOOK;
		
		public function EditingModeModel()
		{
			super();
		}
	}
}