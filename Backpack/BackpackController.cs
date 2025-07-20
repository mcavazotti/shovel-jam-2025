using Godot;
using System;

public partial class BackpackController : CanvasLayer
{
	[Signal]
	public delegate void OpenBagEventHandler();
	[Signal]
	public delegate void CloseBagEventHandler();
	[Signal]
	public delegate void ContentChangeEventHandler(ItemData[] items);

	private Backpack _backpack;
	private Control _openArea;
	private Control _closeArea;
	private Sprite2D _reminder;

	public Backpack Backpack { get => _backpack; }

	public override void _Ready()
	{
		_backpack = GetNode<Backpack>("Backpack");
		_reminder = GetNode<Sprite2D>("UiArea/Reminder");
		_openArea = GetNode<Control>("UiArea/OpenArea");
		_closeArea = GetNode<Control>("UiArea/CloseArea");
		
		_backpack.Position = new Vector2(1500, 1600);
		_reminder.Rotation = -180.0f;
	}


	public void EmitOpenBag()
	{
		EmitSignal(SignalName.OpenBag);
	}

	public void EmitCloseBag()
	{
		EmitSignal(SignalName.CloseBag);
	}

	public void EmitItemsChange(ItemData[] items)
	{
		EmitSignal(SignalName.ContentChange, items);
	}
}
