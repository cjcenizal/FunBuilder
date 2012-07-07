package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import org.robotlegs.mvcs.Command;
	
	public class SelectBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var block:Mesh;
		
		override public function execute():void
		{
			
			
			
			
			// Scrollwheel zooms
			
			
			// CurrentBlockModel
			// Cycle through types for currently select block
			
			// LOOK mode:
			// 1) If block is selected, move it around
			// 2) If no block, just look around.
			// Deselect block with esc.
			
			// SELECT mode:
			// 1) select block and choose new type (or switch to moving to move it around)
			// 2) drag new blocks from library into scene
			
			
			
			// Intersecting an existing block flashes red and doesn't allow you to leave it there
			// (i.e. deselect it)
			if ( block ) {
				// Set selection.
			} else {
				// De-select.
			}
		}
	}
}