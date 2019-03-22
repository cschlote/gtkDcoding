/*
 Diagram:
 
 MyMenuBar
 	FileMenuHeader
 		FileMenu
 			KeepCheckMenuItem
 	
 */

import std.stdio;

import gtk.MainWindow;
import gtk.Box;
import gtk.Main;
import gtk.Menu;
import gtk.MenuBar;
import gtk.MenuItem;
import gtk.CheckMenuItem;
import gtk.Widget;
import gdk.Event;

void main(string[] args)
{
    Main.init(args);

    TestRigWindow testRig = new TestRigWindow();
    
    Main.run();
    
} // main()


class TestRigWindow : MainWindow
{
	string title = "CheckMenuItem Example";

	this()
	{
		super(title);
		setDefaultSize(640, 480);
		addOnDestroy(&quitApp);

		AppBox appBox = new AppBox();
		add(appBox);
		
		showAll();
		
	} // this()
	
	
	void quitApp(Widget w)
	{
		// do other exit stuff here if necessary
		// like call an external function
		
		Main.quit();
		
	} // quitApp()
	
} // TestRigWindow


class AppBox : Box
{
	int padding = 10;
	MyMenuBar menuBar;
	
	this()
	{
		super(Orientation.VERTICAL, padding);
		
		menuBar = new MyMenuBar();
    	packStart(menuBar, false, false, 0);		
		
	} // this()
	
} // class AppBox


class MyMenuBar : MenuBar
{
	FileMenuHeader fileMenuHeader;
	
	this()
	{
		super();
		
		fileMenuHeader = new FileMenuHeader();
		append(fileMenuHeader);		
		
	} // this()

	
} // class MyMenuBar


class FileMenuHeader : MenuItem
{
	string headerTitle = "File";
	FileMenu fileMenu;
	
	this()
	{
		super(headerTitle);
		
		fileMenu = new FileMenu();
		setSubmenu(fileMenu);
		
		
	} // this()
	
} // class FileMenu


class FileMenu : Menu
{
	KeepCheckMenuItem keepItem;
	MakeItFancyCheckMenuItem makeItFancyItem;
	
	this()
	{
		super();
		
		keepItem = new KeepCheckMenuItem();
		append(keepItem);
		
		makeItFancyItem = new MakeItFancyCheckMenuItem();
		append(makeItFancyItem);
		
	} // this()

} // class FileMenu


class KeepCheckMenuItem : CheckMenuItem
{
	string keepLabel = "Keep";
   
	this()
	{
		super(keepLabel);
		addOnToggled(&choose);
		
	} // this()
	
	
	void choose(CheckMenuItem mi)
	{
		if(getActive() == true)
		{
			keep();
		}
		else
		{
			toss();
		}
		
	} // exit()
	
	
	void keep()
	{
		writeln("We're keeping it.");
		
	} // keep()
	
	
	void toss()
	{
		writeln("OMG! Get rid of it!");
		
	} // toss()
	
} // class KeepCheckMenuItem


class MakeItFancyCheckMenuItem : CheckMenuItem
{
	string makeItFancyLabel = "Make it fancy";
   
	this()
	{
		super(makeItFancyLabel);
		setActive(true);
		addOnToggled(&choose);
		
	} // this()
	
	
	void choose(CheckMenuItem mi)
	{
		if(getActive() == true)
		{
			keepItFancy();
		}
		else
		{
			makeItPlain();
		}
		
	} // exit()
	
	
	void keepItFancy()
	{
		writeln("We're making it fancy, yes, sir.");
		
	} // keep()
	
	
	void makeItPlain()
	{
		writeln("K.I.S.");
		
	} // toss()
	
} // class MakeItFancyCheckMenuItem
