using Godot;
using System;

public partial class ItemData : RefCounted
{
    readonly public int Id; 
    readonly public int Category; 
    readonly public String[] Tags; 
    readonly public String Name; 
    readonly public String Description; 
    readonly public String Image; 
    readonly public int[,] Shape; 
}
