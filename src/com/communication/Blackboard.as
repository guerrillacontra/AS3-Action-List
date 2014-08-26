package com.communication {
	import flash.utils.Dictionary;
	/**
	 * A method of allowing an object to communicate with others
	 * via a wall of shared data known as "entries".
	 * 
	 * Copyright 2014 Extrovert Studios LLP
	 * @author James http://www.earthshatteringcode.com/
	 */
	public final class Blackboard 
	{
		/**
		 * Get an entry based on a key.
		 * (will create a new entry if not created all ready).
		 * @param	key
		 * @return
		 */
		public function getEntry(key:*):Entry
		{
			var entry:Entry = null;
			
			if (!_values[key])
			{
				entry = new Entry(key);
				_values[key] = entry;
			}else
			{
				entry = _values[key];
			}
			
			return  entry;
		}
		
		
		public function destroyEntry(key:*):void
		{
			_values[key] = null;
		}
		
		public function hasEntry(key:*):Boolean
		{
			return _values[key] != null  && _values[key].isSafe;
		}
		
		private var _values:Dictionary = new Dictionary();
	}

}