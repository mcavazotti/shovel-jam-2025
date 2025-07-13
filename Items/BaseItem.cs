using Godot;
using System;

public partial class BaseItem : Node2D
{
    [Export]
    Vector2I SlotSize = new Vector2I(50, 50);
    [Export]
    public int Id;
    [Export]
    public string ItemName;
    [Export]
    public Image ShapeMap;
    [Export]
    public Texture2D ItemSprite;

    [Signal]
    public delegate void DragEventHandler(BaseItem i);
    [Signal]
    public delegate void DropEventHandler(BaseItem i);

    private bool InBounds;

    private Vector2 PosBeforeDrag;
    private bool Dragging;
    private Vector2 Offset;
    private Vector2 RectShape;
    private Vector2I ShapeDim;

    public int[,] Shape;


    public override void _Ready()
    {
        var collisionShape = GetNode<CollisionShape2D>("Area2D/CollisionShape2D");

        ShapeDim = ShapeMap.GetSize();
        RectShape = ShapeDim * SlotSize;
        (collisionShape.Shape as RectangleShape2D).Size = RectShape;

        Shape = new int[ShapeDim.X, ShapeDim.Y];

        for (var y = 0; y < ShapeDim.Y; y++)
        {
            for (var x = 0; x < ShapeDim.X; x++)
            {
                if (ShapeMap.GetPixel(x, y) == new Color("000"))
                    Shape[x, y] = 1;
                else Shape[x, y] = 0;
            }
        }

        var sprite = GetNode<Sprite2D>("Sprite2D");
        sprite.Texture = ItemSprite;



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

        if (@event is InputEventMouseMotion eventMouseMotion)
        {
            if (Dragging && Input.IsMouseButtonPressed(MouseButton.Left))
            {
                EmitSignal(SignalName.Drag, this);
                Position = GetGlobalMousePosition() - Offset;
            }

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
        if (slotMousePos < Vector2.Zero || slotMousePos.X >= ShapeDim.X || slotMousePos.Y >= ShapeDim.Y)
            return false;

        return Shape[slotMousePos.X, slotMousePos.Y] == 1;
    }

    public Godot.Collections.Array<Vector2> GetSlotsGlobalPositions()
    {
        var positions = new Godot.Collections.Array<Vector2>();
        var topLeftCorner = (SlotSize - RectShape) / 2;
        for (int y = 0; y < ShapeDim.Y; y++)
        {
            for (int x = 0; x < ShapeDim.X; x++)
            {
                if (Shape[x, y] == 1)
                    positions.Add(GlobalPosition + (topLeftCorner + SlotSize * new Vector2(x, y)).Rotated(GlobalRotation));
            }
        }
        return positions;
    }

    public void ResetDragPosition()
    {
        Position = PosBeforeDrag;
    }
}
