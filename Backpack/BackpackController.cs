using Godot;
using System;

public partial class BackpackController : CanvasLayer
{
    [Signal]
    public delegate void OpenBagEventHandler();

    public void EmitOpenBag()
    {
        EmitSignal(SignalName.OpenBag);
    }
}
