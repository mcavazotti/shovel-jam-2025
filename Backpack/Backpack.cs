using Godot;
using System;

public partial class Backpack : Node2D
{
    [Export]
    Vector2I GridSize = new Vector2I(6, 8);
    [Export]
    Vector2I SlotSize = new Vector2I(50, 50);
    [Export]
    public PackedScene SlotScene { get; set; }

    private BackpackSlot[,] Slots;

    private bool DraggingError = false;

    public override void _EnterTree()
    {
        Slots = new BackpackSlot[GridSize.X, GridSize.Y];
        for (int idxY = 0; idxY < GridSize.Y; idxY++)
        {
            var y = -GridSize.Y / 2 + idxY;
            for (int idxX = 0; idxX < GridSize.X; idxX++)
            {
                var x = -GridSize.X / 2 + idxX;

                var slot = SlotScene.Instantiate<BackpackSlot>();

                slot.Position = new Vector2(x, y) * SlotSize;
                AddChild(slot);
                slot.Owner = this;

                Slots[idxX, idxY] = slot;

            }
        }
    }

    public override void _Ready()
    {
        var collisionShape = GetNode<CollisionShape2D>("Area2D/CollisionShape2D");
        var rectShape = GridSize * SlotSize;
        (collisionShape.Shape as RectangleShape2D).Size = rectShape;

        var items = GetTree().GetNodesInGroup("Items");

        foreach (var i in items)
        {
            if (i is BaseItem item)
            {
                item.Drag += DraggingItem;
                item.Drop += DroppingItem;
                
            }

        }

    }

    private void DraggingItem(BaseItem item)
    {
        foreach (var slot in Slots)
            slot.ResetState();


        var itemSlots = item.GetSlotsGlobalPositions();

        var error = FindIntersectingSlots(itemSlots,out var intersectingSlots);


        foreach (var slot in intersectingSlots)
        {
            if (error)
            {
                slot.Error = true;
                DraggingError = true;
            }
            else
            {
                slot.Highlight = true;
                DraggingError = false;

            }
        }

    }


    private void DroppingItem(BaseItem item)
    {
        foreach (var slot in Slots)
            slot.ResetState();

        var area2D = GetNode<Area2D>("Area2D");
        var overlaps = area2D.OverlapsArea(item.GetNode<Area2D>("Area2D"));
        if (DraggingError && overlaps)
        {
            item.ResetDragPosition();
        }
        if (!DraggingError)
        {
            FindIntersectingSlots(item.GetSlotsGlobalPositions().Slice(0, 1), out var intersectingSlots);
            var itemSlot = item.GetSlotsGlobalPositions()[0];
            var offset =  intersectingSlots[0].GlobalPosition - itemSlot;
            item.Position = item.Position + offset;

        }
    }

    private bool FindIntersectingSlots(Godot.Collections.Array<Vector2> itemSlots, out Godot.Collections.Array<BackpackSlot> intesectingSlots)
    {
        var slots = new Godot.Collections.Array<BackpackSlot>();

        var error = false;
        foreach (var slotPos in itemSlots)
        {
            var localPos = slotPos - GlobalPosition;
            var slotIndex = (Vector2I)((localPos + GridSize * SlotSize / 2) / SlotSize);
            if (slotIndex.X >= 0 && slotIndex.Y >= 0 && slotIndex.X < GridSize.X && slotIndex.Y < GridSize.Y)
            {
                if (Slots[slotIndex.X, slotIndex.Y].ItemId != 0) error = true;
                slots.Add(Slots[slotIndex.X, slotIndex.Y]);
            }
            else error = true;
        }
        error = error || slots.Count != itemSlots.Count;

        intesectingSlots = slots;
        return error;
    }
}
