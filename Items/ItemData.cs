using Godot;
using System;

public partial class ItemData : RefCounted
{
    public int Id;
    public int Category;
    public string[] Tags;
    public string Name;
    public string Description;
    public string Image;
    public string Icon;
    public int[,] Shape;

    public void SetShapeFromJaggedArray(Godot.Collections.Array arr)
    {
        int rows = arr.Count;
        int cols = rows > 0 ? ((int[])arr[0]).Length : 0;
        Shape = new int[rows, cols];
        for (int i = 0; i < rows; i++)
        {
            for (int j = 0; j < cols; j++)
            {
                Shape[i, j] = ((int[])arr[i])[j];
            }
        }
    }
}
