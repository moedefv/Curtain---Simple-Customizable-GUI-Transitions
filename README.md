# Curtain - Simple, Customizable GUI Transitions

Curtain is a lightweight, customizable Roblox GUI transition library that makes switching between interfaces simple and visually appealing. It includes multiple built-in transition effects such as Fade, Slide, Grid, and more to come. It has support for customizable speeds, easing styles, and colors. Curtain provides a consistent API so you can create smooth, professional-looking UI transitions with minimal setup.

You can even put CUSTOM CALLBACK FUNCTIONS. These functions are called in between the 2 frames, in the middle of the transition. Best for teleporting players, making more UI invisible/visible, and many more uses.

## Installation
1. Click on the Creator Store link on the bottom of the page
2. Add it to your inventory
3. Go to Toolbox -> Inventory, and you'll see Curtain right there. Add it to your place and put it in ReplicatedStorage.

## Usage

A quick example:
```lua
Curtain:Fade(frame1, frame2, {Duration = 1, EasingStyle = Enum.EasingStyle.Back}, function()
  -- custom function here
end)
```

Frame 1 could be nil, in case you want to transition from nothing to Frame 2.
You don't even need to configure anything, You could simply do:
```lua
Curtain:Slide(nil, frame2)
```

The current transitions and their settings:
```lua
Grid = {
    Duration: number,
    Color: Color3,
    EasingStyle: Enum.EasingStyle,
}

Slide = {
    Duration: number,
    Color: Color3,
    Direction: string,
    EasingStyle: Enum.EasingStyle,
    ReverseOut: boolean,
}

Fade = {
    Duration: number,
    Color: Color3,
    EasingStyle: Enum.EasingStyle,
}
```

## Creator Store Link:
https://create.roblox.com/store/asset/104953184936909/Curtain
