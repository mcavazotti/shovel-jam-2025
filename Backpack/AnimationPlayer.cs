using Godot;
using System;

public partial class AnimationPlayer : Godot.AnimationPlayer
{
    private bool Open = false;
    void PlayOpenBag()
    {
        if (!Open)
        {
            Open = true;
            Play("Open Bag");
        }
    }

    void PlayCloseBag()
    {
        if (Open)
        {
            Open = false;
            PlayBackwards("Open Bag");
        }
    }
}
