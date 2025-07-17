using Godot;
using System;

public partial class BagItem : Node2D
{
    [Export]
    Vector2I SlotSize = new Vector2I(50, 50);

    public PackedScene HouseItemScene;

    public ItemData Data;

    public bool InsideBag = false;
    public BackpackController Controller;

    [Signal]
    public delegate void DragEventHandler(BagItem i);
    [Signal]
    public delegate void DropEventHandler(BagItem i);

    private bool InBounds;

    private Vector2 PosBeforeDrag;
    private float RotBeforeDrag;
    private bool Dragging;
    private Vector2 Offset;
    private Vector2 RectShape;



    public override void _Ready()
    {
        HouseItemScene = GD.Load<PackedScene>("res://Items/HouseItem/HouseItem.tscn");
        var collisionShape = GetNode<CollisionShape2D>("Area2D/CollisionShape2D");

        RectShape = new Vector2(Data.Shape.GetLength(1), Data.Shape.GetLength(0)) * SlotSize;
        (collisionShape.Shape as RectangleShape2D).Size = RectShape;

        var sprite = GetNode<Sprite2D>("Sprite2D");
        sprite.Texture = GD.Load<Texture2D>(Data.Image);

        Controller.CloseBag += TransferItemToHouseContext;
    }
    public override void _Input(InputEvent @event)
    {

        if (@event is InputEventMouseButton eventMouseButton)
        {
            if (eventMouseButton.ButtonIndex == MouseButton.Left)
            {
                if (eventMouseButton.Pressed)
                {
                    Offset = GetGlobalMousePosition() - GlobalPosition;
                    var validPos = Dragging;
                    if (InBounds) validPos = ValidateMousePos();

                    if (validPos)
                    {
                        Dragging = true;
                        PosBeforeDrag = Position;
                        RotBeforeDrag = Rotation;
                    }
                    else
                        Dragging = false;
                }
                else
                {
                    if (Dragging)
                    {
                        EmitSignal(SignalName.Drop, this);
                    }
                    Dragging = false;

                }

            }
        }

        if (@event is InputEventMouseMotion)
        {
            if (Dragging && Input.IsMouseButtonPressed(MouseButton.Left))
            {
                EmitSignal(SignalName.Drag, this);
                GlobalPosition = GetViewport().GetMousePosition() - Offset;
            }

        }

        if (@event.IsActionPressed("r_cw") && Dragging)
        {
            Rotate(Mathf.Pi / 2);
            Offset = Offset.Rotated(Mathf.Pi / 2);
            Position += Offset;
            EmitSignal(SignalName.Drag, this);
        }
        if (@event.IsActionPressed("r_ccw") && Dragging)
        {
            Rotate(-Mathf.Pi / 2);
            Offset = Offset.Rotated(-Mathf.Pi / 2);
            Position -= Offset;
            EmitSignal(SignalName.Drag, this);
        }
    }

    public void MouseEnter()
    {
        InBounds = true;
    }

    public void MouseLeave()
    {
        InBounds = Dragging || false;
    }


    private bool ValidateMousePos()
    {
        var localMousePos = GetLocalMousePosition();
        var mappedMousePos = localMousePos + (RectShape / 2);

        var slotMousePos = (Vector2I)(mappedMousePos / SlotSize);
        if (slotMousePos < Vector2.Zero || slotMousePos.X >= Data.Shape.GetLength(1) || slotMousePos.Y >= Data.Shape.GetLength(0))
            return false;

        return Data.Shape[slotMousePos.Y, slotMousePos.X] == 1;
    }

    public Godot.Collections.Array<Vector2> GetSlotsGlobalPositions()
    {
        var positions = new Godot.Collections.Array<Vector2>();
        var topLeftCorner = (SlotSize - RectShape) / 2;
        for (int y = 0; y < Data.Shape.GetLength(0); y++)
        {
            for (int x = 0; x < Data.Shape.GetLength(1); x++)
            {
                if (Data.Shape[y, x] == 1)
                    positions.Add(GlobalPosition + (topLeftCorner + SlotSize * new Vector2(x, y)).Rotated(GlobalRotation));
            }
        }
        return positions;
    }

    public void ResetDragPosition()
    {
        Position = PosBeforeDrag;
        Rotation = RotBeforeDrag;
    }

    public void ForceDraggingState(Vector2 originalPos)
    {
        PosBeforeDrag = originalPos;
        RotBeforeDrag = 0;
        Offset = Vector2.Zero;
        Dragging = true;
        InBounds = true;
    }

    public void TransferItemToHouseContext()
    {
        if (InsideBag) return;

        var houseItem = HouseItemScene.Instantiate<HouseItem>();
        houseItem.Data = Data;
        houseItem.Name = Data.Name;
        houseItem.Controller = Controller;
        Controller.GetParent().AddChild(houseItem);
        houseItem.Owner = Controller.GetParent();

        var player = GetTree().GetNodesInGroup("Player")[0] as Node2D;
        var angle = (float)GD.RandRange(0, 2 * Mathf.Pi);
        var offset = Vector2.Up.Rotated(angle) * 50;

        houseItem.GlobalPosition = player.GlobalPosition + offset;

        Controller.CloseBag -= TransferItemToHouseContext;
        Free();
    }
}
