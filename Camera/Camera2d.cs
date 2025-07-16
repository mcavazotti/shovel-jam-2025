using Godot;
using System;

public partial class Camera2d : Camera2D
{
    private double travelledDist = 0;
    private double vel = 100;
    private Vector2 dir = Vector2.Down;
    public override void _Process(double delta)
    {
        if (travelledDist < 200)
        {
            Position += dir * (float)vel * (float)delta;
            travelledDist += vel * delta;
        }
        else
        {
            travelledDist = 0;
            dir = dir.Rotated(Mathf.Pi / 2);
        }
    }

}
