import std.stdio;

import gtk.MainWindow;
import gtk.Box;
import gtk.Main;
import gtk.Menu;
import gtk.MenuBar;
import gtk.MenuItem;
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
	string title = "Multiple Menus Example";

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
	string fileHeaderLabel = "File";
	
	FileHeader fileHeader;
	
	this()
	{
		super();
		
		fileHeader = new FileHeader(fileHeaderLabel);
		append(fileHeader);
		
	} // this()

	
} // class MyMenuBar


class FileHeader : MenuItem
{
	FileMenu fileMenu;
	
	// arg: a Menu object
	this(string headerTitle)
	{
		super(headerTitle);
		
		fileMenu = new FileMenu();
		setSubmenu(fileMenu);
		
	} // this()
	
} // class MenuHeader


class FileMenu : Menu
{
	NewFileItem newFileItem;
	OpenFileItem openFileItem;
	CloseFileItem closeFileItem;
	ExitItem exitItem;
	
	// arg: an array of items
	this()
	{
		super();
		
		newFileItem = new NewFileItem();
		append(newFileItem);
		
		openFileItem = new OpenFileItem();
		append(openFileItem);
		
		closeFileItem = new CloseFileItem();
		append(closeFileItem);
		
		exitItem = new ExitItem();
		append(exitItem);
		
	} // this()
	
	
} // class FileMenu


class NewFileSubMenu : Menu
{
	DFileItem dFileItem;
	TextFileItem textFileItem;
	ImageFileItem imageFileItem;
	SpreadsheetFileItem spreadsheetFileItem;
	PdfFileItem pdfFileItem;
	
	this()
	{
		super();
		
		dFileItem = new DFileItem();
		append(dFileItem);
		
		textFileItem = new TextFileItem();
		append(textFileItem);
		
		imageFileItem = new ImageFileItem();
		append(imageFileItem);
		
		spreadsheetFileItem = new SpreadsheetFileItem();
		append(spreadsheetFileItem);
		
		pdfFileItem = new PdfFileItem();
		append(pdfFileItem);
		
	} // this()
	
	
} // class NewFileSubMenu


class ExitItem : MenuItem
{
	string itemLabel = "Exit";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Quitting... Bye.");
		
		Main.quit();
		
	} // exit()
	
} // class ExitItem


class NewFileItem : MenuItem
{
	string itemLabel = "New";
	NewFileSubMenu newFileSubMenu;
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
		newFileSubMenu = new NewFileSubMenu();
		setSubmenu(newFileSubMenu);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("New file created.");
		
	} // doSomethingNew()
	
} // class NewFileItem


class OpenFileItem : MenuItem
{
	string itemLabel = "Open";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("A file dialog will be shown now.");
		
	} // doSomething()
	
} // class OpenFileItem


class CloseFileItem : MenuItem
{
	string itemLabel = "Close";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("The file is closed.");
		
		// If this was the last open file, 
		// ask the user if the the application should also be closed.
		
	} // doSomething()
	
} // class CloseFileItem


class DFileItem : MenuItem
{
	string itemLabel = "D Source File";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Dialog appears with filter: '*.d'");
		
	} // doSomething()
	
} // class UndoItem


class TextFileItem : MenuItem
{
	string itemLabel = "Text File";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Dialog appears with filter: '*.txt'");
		
	} // doSomething()
	
} // class TextFileItem


class ImageFileItem : MenuItem
{
	string itemLabel = "Image File";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Dialog appears with filter: '*.png, *.jpg, *.tiff'");
		
	} // doSomething()
	
} // class CutItem


class SpreadsheetFileItem : MenuItem
{
	string itemLabel = "Spreadsheet File";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Dialog appears with filter: '*.csv, *.xls'");
		
	} // doSomething()
	
} // class SpreadsheetFileItem


class PdfFileItem : MenuItem
{
	string itemLabel = "PDF File";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Dialog appears with filter: '*.pdf'");
		
	} // doSomething()
	
} // class PdfFileItem
