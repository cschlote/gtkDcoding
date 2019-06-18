---
topic: window
layout: post
description: How to use the GTK Paned class to split a window into panes.
author: Ron Tarrant

---

# 0046 - Split a Window into Panes

There will be times when you’ll need a window separated into two areas with a handle to adjust the division between them. For instance, a file manager has a directory/folder tree on the left and the contents of a selected directory on the right and as I’m sure you’re aware, if you dig deep enough into a directory hierarchy, you have to widen the left-hand area so you can see the full path which is why it's handy to have that adjustment handle between the two panes.

Today’s code lays the foundation for this type of functionality.

## A Pane in the Window… Two, Really

[The code file can be found here](https://github.com/rontarrant/gtkDcoding/blob/master/014_containers/container_014_01_paned.d).

A `Paned` container can have its child panes side by side or one below the other. And since we may want programmable access to manipulate the child widgets we put in these panes, I’ve created a class derived from `Paned` and called it `SideBySide`:

	class SideBySide : Paned
	{
		Image child01, child02;
		
		this()
		{
			super(Orientation.HORIZONTAL);
			
			auto child01 = new Image("images/e_blues_open.jpg"); 
			add1(child01);
			
			auto child02 = new Image("images/guitar_bridge.jpg");
			add2(child02);
			
			addOnButtonRelease(&showDividerPosition);
			
		} // this()
		
		
		public bool showDividerPosition(Event event, Widget widget)
		{
			writeln("The divider is set to: ", getPosition());
			
			return(true);
			
		} // showDividerPosition()
		
	} // class SideBySide

This is just about as simple as it gets with `Paned` containers. We’ve got two child `Image` widgets, each tucked into its own pane.

And just to show off one of `Paned`’s functions, I’ve connected up a generic `Widget Event` signal to spit out the position of the pane divider handle. Hover the mouse over the handle, click-n-drag, and when you release the mouse button, `showDividerPosition()` spits out the new position of the handle.

### Paned Behaviour

Because there are only two panes in a `Paned` container, the functions for assigning child `Widget`s are numbered:

- `add1(child1)`, and
- `add2(child2)`.

Or if you want to populate both in one go, you can do it with a single function:

	add(child1, child2);

You could also use `pack1()` and `pack2()` if you prefer, but the behaviour will be different, so let’s look at that.

## Paned Packing

[Our second example](https://github.com/rontarrant/gtkDcoding/blob/master/014_containers/container_014_02_paned_pack.d) has a new derived class for a *vertical* `Paned` container:

	class UppyDowny : Paned
	{
		Image child01, child02;
		
		this()
		{
			super(Orientation.VERTICAL);
			
			auto child01 = new Image("images/e_blues_open.jpg"); 
			pack1(child01, true, false);
			
			auto child02 = new Image("images/guitar_bridge_alt.jpg");
			pack2(child02, false, true);
			
			addOnButtonRelease(&showDividerPosition);
			
		} // this()
		
		
		public bool showDividerPosition(Event event, Widget widget)
		{
			writeln("The divider is set to: ", getPosition());
			
			return(true);
			
		} // showDividerPosition()
		
	} // class UppyDowny

Here are the differences between this example and the first:

- the panes are stacked vertically instead of horizontally,
- `pack1()` has three arguments instead of one:
	- the child `Widget`,
	- a `bool` to determine whether or not the child will expand when the divider handle is moved away from it, and
	- another `bool` to control whether or not the child `Widget` will shrink when the handle is moved toward it.
- when you move the divider handle in the first example, each image slides out of the way as the handle is moved toward it, but…
- in the second example, only the guitar bridge image moves.

Note also that even though the panes expand or contract as you move the handle, the `Image`s aren’t resizing. So, it’s just the panes that change size, not their contents.

### How addX() Imitates packX()

The default behaviour for `add1()` or `add2()` allows both panes to resize just as can be done with `pack1()` and `pack2()`. That’s because when using the `addX()` functions, they assume behaviours that would be the same as if you’d used `packX()` while passing the following arguments:

- `pack1(child1, false, true)` = `add(child1)`, and
- `pack2(child2, true, true)` = `add(child2)`.

The corollary is, if you want to mimic the behaviour of `add1()` and `add2()`, using the above arguments to `pack1()` and `pack2()` would do the trick.

And that’s pretty much it for now. See you next time.