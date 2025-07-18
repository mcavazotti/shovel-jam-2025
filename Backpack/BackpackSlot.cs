using Godot;
using System;

public partial class BackpackSlot : Node2D
{
    [Export]
    public Color HightlighColor;

    [Export]
    public Color ErrorColor;

    public int ItemId { get; set; }

    public Area2D Area2D;
    public CollisionShape2D CollisionShape;

    public bool Highlight { get; set; } = false;
    public bool Error { get; set; } = false;
    private bool Hover { get; set; } = false;

    public override void _Ready()
    {
        Area2D = GetNode<Area2D>("Area2D");
        CollisionShape = GetNode<CollisionShape2D>("Area2D/CollisionShape2D");
    }

    public override void _Process(double delta)
    {
        if (Error) Modulate = ErrorColor;
        else if (Highlight || Hover) Modulate = HightlighColor;
        else Modulate = new Color("#ffffff");
        if (ItemId != 0) Modulate = new Color("#147a36ff");

    }


    public void MouseEnter()
    {
        Hover = true;
    }
    public void MouseLeave()
    {
        Hover = false;
    }

    public void ResetState(int itemId)
    {
        if (ItemId == itemId) ItemId = 0;
        Highlight = false;
        Error = false;
    }
}
