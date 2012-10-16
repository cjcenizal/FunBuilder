package com.funbuilder.controller.commands
{
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.macrobot.SequenceCommand;
	
	public class InitAppCommand extends SequenceCommand
	{
		public function InitAppCommand()
		{
			addCommand( LoadBlockTypesCommand );
			addCommand( LoadBlockStylesCommand );
			addCommand( BuildViewCommand );
			addCommand( BuildLibraryCommand );
			addCommand( InitViewCommand );
		}
	}
}