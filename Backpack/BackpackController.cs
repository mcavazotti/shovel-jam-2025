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

	public Backpack Backpack { get => _backpack; }

	public override void _Ready()
	{
		_backpack = GetNode<Backpack>("Backpack");
		_openArea = GetNode<Control>("UiArea/OpenArea");
		_closeArea = GetNode<Control>("UiArea/CloseArea");
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
