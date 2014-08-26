package com.actionlists
{
	import com.communication.Blackboard;
	
	/**
	 * An action list that can trace useful info
	 * to the console so we can see/track the actions
	 * when debugging.
	 * 
	 * Recommended to use only in debugging as it will slow down
	 * the application due to excessive traces.
	 * 
	 * Copyright 2014 Extrovert Studios LLP
	 * @author James http://www.earthshatteringcode.com/
	 */
	public final class DebugActionList extends ActionList
	{
		
		public function DebugActionList(blackboard:Blackboard = null)
		{
			super(blackboard);
		}
		
		override protected function onUpdated():Boolean
		{
			if (!_head)
			{
				return true;
			}
			
			print("Update");
			var lanesThatAreBlocked:uint = 0;
			
			var i:int = 0;
			var finished:Boolean = false;
			
			for (var action:Action = _head; action; action = action._next)
			{
				print("Action #" + i);
				
				if (lanesThatAreBlocked & action.laneMask)
				{
					print("Action " + action + " was blocked");
					i++;
					continue;
				}
				
				if (action.isBlocking)
				{
					print("Action " + action + " is blocking lanes... ");
					
					printLanes(action.lanesToBlockMask);
					
					lanesThatAreBlocked |= action.lanesToBlockMask;
					
					print("Current blocked lanes...");
					printLanes(lanesThatAreBlocked);
				}
				
				if (!action.hasStarted)
				{
					print("Action " + action + " is about to start...");
					finished = action.start();
					print("Action " + action + " has started");
					
					if (finished)
					{
						print("Action " + action + " is about to stop...");
						action.stop();
						print("Action " + action + " has been stopped");
						
						print("Action " + action + " is about to be removed...");
						remove(action);
						print("Action " + action + " has been removed");
						
						i++;
						continue;
					}
				}
				
				print("Action " + action + " is about to update...");
				finished = action.update();
				print("Action " + action + " has been updated");
				
				if (finished)
				{
					print("Action " + action + " is about to stop...");
					action.stop();
					print("Action " + action + " has been stopped");
					
					print("Action " + action + " is about to be removed...");
					remove(action);
					print("Action " + action + " has been removed");
					
				}
				
				i++;
			}
			
			return _head == null;
		}
		
		private function print(msg:String):void
		{
			trace(this + " : " + msg);
		}
		
		private function printLanes(mask:uint):void
		{
			var actionMask:uint = mask;
			
			var masks:String = "";
			
			while (actionMask != 0)
			{
				if (masks.length == 0)
				{
					masks = "" + actionMask;
				}
				else
				{
					masks += "," + actionMask;
				}
				
				actionMask = (actionMask >> 1) & 1;
				
			}

			print("Lanes [" + masks + "]");
		}
	
	}

}