using Godot;
using System;

public partial class HouseItem : Node2D
{
    ItemData Data;
    private bool InBounds = false;
    private bool Dragging = false;
    private Vector2 Offset;

    public override void _Input(InputEvent @event)
    {
        if (@event is InputEventMouseButton eventMouseButton)
        {
            if (InBounds && eventMouseButton.Pressed && eventMouseButton.ButtonIndex == MouseButton.Left)
            {
                Dragging = true;
                Offset = GetGlobalMousePosition() - GlobalPosition;
            }
            if (!eventMouseButton.Pressed)
            {
                Dragging = false;
            }
        }


        if (@event is InputEventMouseMotion)
        {
            if (Dragging && Input.IsMouseButtonPressed(MouseButton.Left))
            {
                Position = GetGlobalMousePosition() - Offset;
            }
        }
    }


    public void SetData(string jsonData)
    {
        var d = Json.ParseString(jsonData).AsGodotDictionary();

        Data = new ItemData();

        Data.Id = (int)d["id"];
        Data.Category = (int)d["category"];
        Data.Tags = (string[])d["tags"];
        Data.Name = (string)d["name"];
        Data.Description = (string)d["description"];
        Data.Image = (string)d["image"];
        Data.Icon = (string)d["icon"];
        Data.SetShapeFromJaggedArray((Godot.Collections.Array)d["shape"]);

        var sprite = GetNode<Sprite2D>("Sprite2D");
        sprite.Texture = GD.Load<Texture2D>(Data.Icon);
        var imageSize = sprite.Texture.GetSize();

        var label = GetNode<Label>("Label");
        label.Text = $"{Data.Name}\n{GetCategoryName(Data.Category)}";
        label.Visible = false;
        label.Position = new Vector2(0, imageSize.Y / 2 + 15);

        var collisionShape2D = GetNode<CollisionShape2D>("Area2D/CollisionShape2D");
        ((RectangleShape2D)collisionShape2D.Shape).Size = imageSize;
    }

    public void CursorEnter()
    {
        GetNode<Label>("Label").Visible = true;
        InBounds = true;
    }
    public void CursorLeave()
    {
        GetNode<Label>("Label").Visible = false;
        InBounds = false;
    }

    private string GetCategoryName(int category)
    {
        switch (category)
        {
            case 1000:
                return "Food";
            case 2000:
                return "Cloathing";
            case 3000:
                return "Weapon";
            case 4000:
            default:
                return "Misc";
        }
    }
}
