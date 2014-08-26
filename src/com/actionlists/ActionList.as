package com.actionlists
{
	import com.communication.*;
	
	/**
	 * A list of actions that are processed in order.
	 *
	 * Copyright 2014 Extrovert Studios LLP
	 * @author James http://www.earthshatteringcode.com/
	 */
	public class ActionList extends Action
	{
		
		public function ActionList(blackboard:Blackboard = null):void
		{
			super(0, 0)
			
			_blackboard = blackboard ? blackboard : new Blackboard();
		}
		
		/**
		 * A blackboard to allow actions to communicate and share
		 * data within this action list
		 */
		public final function get blackboard():Blackboard
		{
			return _blackboard;
		}
		
		/**
		 * Push an action ontop of the others.
		 * @param	action
		 */
		public final function push(action:Action):void
		{
			if (!_head)
			{
				_head = _tail = action;
				action._next = action._previous = null;
			}
			else
			{
				_tail._next = action;
				action._previous = _tail;
				action._next = null;
				_tail = action;
			}
			
			action._parent = this;
		}
		
		public function remove(action:Action):void
		{
			if (_head == action)
			{
				_head = _head._next;
			}
			if (_tail == action)
			{
				_tail = _tail._previous;
			}
			
			if (action._previous)
			{
				action._previous._next = action._next;
			}
			
			if (action._next)
			{
				action._next._previous = action._previous;
			}
			
			action._parent = null;
		}
		
		/**
		 * Pop the latest (head) action from the list
		 * @return
		 */
		public final function pop():Action
		{
			var tail:Action = tail;
			remove(tail);
			return tail;
		}
		
		/**
		 * Remove an action at a specific index
		 * @param	index
		 * @return
		 */
		public final function removeAt(index:int):Action
		{
			var i:int = 0;
			var result:Action = null;
			
			for (var action:Action = _head; action; action = action._next)
			{
				if (i == index)
				{
					result = action;
					remove(action);
					break;
				}
				
				i++;
			}
			
			return result;
		}
		
		public function clear():void
		{
			while (_head)
			{
				var node:Action = _head;
				_head = node._next;
				node._previous = null;
				node._next = null;
				node._parent = null;
			}
			_tail = null;
		}
		
		public function get empty():Boolean
		{
			return _head == null;
		}
		
		override protected function onUpdated():Boolean
		{
			var lanesThatAreBlocked:uint = 0;
			
			for (var action:Action = _head; action; action = action._next)
			{
				if (lanesThatAreBlocked & action.laneMask)
					continue;
				
				if (action.isBlocking)
				{
					lanesThatAreBlocked |= action.lanesToBlockMask;
				}
				
				if (!action.hasStarted)
				{
					if (action.start())
					{
						action.stop();
						
						remove(action);
						
						continue;
					}
				}
				
				if (action.update())
				{
					action.stop();
					
					remove(action);
					
				}
			}
			
			return _head == null;
		}
		
		public function swap(a1:Action, a2:Action):void
		{
			if (a1._previous == a2)
			{
				a1._previous = a2._previous;
				a2._previous = a1;
				a2._next = a1._next;
				a1._next = a2;
			}
			else if (a2._previous == a1)
			{
				a2._previous = a1._previous;
				a1._previous = a2;
				a1._next = a2._next;
				a2._next = a1;
			}
			else
			{
				var temp:Action = a1._previous;
				a1._previous = a2._previous;
				a2._previous = temp;
				temp = a1._next;
				a1._next = a2._next;
				a2._next = temp;
			}
			if (_head == a1)
			{
				_head = a2;
			}
			else if (_head == a2)
			{
				_head = a1;
			}
			if (_tail == a1)
			{
				_tail = a2;
			}
			else if (_tail == a2)
			{
				_tail = a1;
			}
			if (a1._previous)
			{
				a1._previous._next = a1;
			}
			if (a2._previous)
			{
				a2._previous._next = a2;
			}
			if (a1._next)
			{
				a1._next._previous = a1;
			}
			if (a2._next)
			{
				a2._next._previous = a2;
			}
		}
		
		private var _blackboard:Blackboard;
		
		internal var _head:Action;
		internal var _tail:Action;
	}

}