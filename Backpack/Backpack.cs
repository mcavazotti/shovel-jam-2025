using Godot;
using System;
using System.Linq;

public partial class Backpack : Node2D
{
	[Signal]
	public delegate void BackpackContentChangeEventHandler(ItemData[] items);

	[Export]
	Vector2I GridSize = new Vector2I(6, 8);
	[Export]
	Vector2I SlotSize = new Vector2I(50, 50);
	[Export]
	public PackedScene SlotScene { get; set; }

	private BackpackSlot[,] Slots;

	private bool DraggingError = false;

	public Godot.Collections.Dictionary<int, ItemData> ItemsInside = [];

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
	}

	public void DraggingItem(BagItem item)
	{
		foreach (var slot in Slots)
			slot.ResetState(item.Data.Id);

		var itemSlots = item.GetSlotsGlobalPositions();

		var error = FindIntersectingSlots(itemSlots, out var intersectingSlots);


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


	public void DroppingItem(BagItem item)
	{
		foreach (var slot in Slots)
			slot.ResetState(item.Data.Id);

		var area2D = GetNode<Area2D>("Area2D");
		var overlaps = area2D.OverlapsArea(item.GetNode<Area2D>("Area2D"));
		if (overlaps)
		{
			if (DraggingError)
			{
				item.ResetDragPosition();
				FindIntersectingSlots(item.GetSlotsGlobalPositions(), out var intersectingSlots);
				foreach (var slot in intersectingSlots)
					slot.ItemId = item.Data.Id;
			}
			else
			{
				FindIntersectingSlots(item.GetSlotsGlobalPositions(), out var intersectingSlots);
				var itemSlot = item.GetSlotsGlobalPositions()[0];
				var offset = intersectingSlots[0].GlobalPosition - itemSlot;

				foreach (var slot in intersectingSlots)
					slot.ItemId = item.Data.Id;

				item.InsideBag = true;
				item.Position += offset;
				item.Reparent(this);
				if (!ItemsInside.ContainsKey(item.Data.Id))
					ItemsInside.Add(item.Data.Id, item.Data);
			}
		}
		else
		{
			item.InsideBag = false;
			ItemsInside.Remove(item.Data.Id);
		}
		EmitSignal(SignalName.BackpackContentChange, ItemsInside.Values.ToArray());
	}

	private bool FindIntersectingSlots(Godot.Collections.Array<Vector2> itemSlots, out Godot.Collections.Array<BackpackSlot> intesectingSlots)
	{
		var slots = new Godot.Collections.Array<BackpackSlot>();

		var error = false;
		foreach (var slotPos in itemSlots)
		{
			var pass = false;
			foreach (var slot in Slots)
			{
				var rect = (slot.CollisionShape.Shape as RectangleShape2D).GetRect();
				rect.Position = slot.GlobalPosition;
				var isInside = rect.HasPoint(slotPos);
				if (isInside)
				{
					slots.Add(slot);

					if (slot.ItemId == 0)
						pass = pass || isInside;
				}
			}
			error = error || !pass;
		}

		intesectingSlots = slots;
		return error;
	}
}
