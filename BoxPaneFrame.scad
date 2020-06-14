
DEFAULT_SIZE = [150, 200, 30];
DEFAULT_PANE_THICKNESS = 3;
DEFAULT_BOX_THICKNESS = 6;
DEFAULT_CORNER_SPACING = 10;

BOX_COLOUR = "Brown";
PANEL_COLOUR = "grey";
PANEL_ALPHA = 0.25;

module BoxColour() { color(BOX_COLOUR) children(); }
module PanelColour() { color(PANEL_COLOUR, PANEL_ALPHA) children(); }

module BoxPaneFrameSide2D(sizeX, sizeY, slotThickness, cornerSpacing)
{
    difference()
    {
        square([sizeX, sizeY]);

        translate([(sizeX - slotThickness) / 2, cornerSpacing])
        square([slotThickness, sizeY - cornerSpacing * 2]);
    }
}

module BoxPaneFrameSideX2D(size, panelThickness, cornerSpacing, boxThickness)
{
    BoxPaneFrameSide2D(size[2], size[0] - boxThickness * 2, panelThickness, cornerSpacing);
}

module BoxPaneFrameSideY2D(size, panelThickness, cornerSpacing)
{
    BoxPaneFrameSide2D(size[2], size[1], panelThickness, cornerSpacing);
}

module BoxPaneFramePane2D(sizeX, sizeY, cornerSpacing, boxThickness)
{
    posX1 = 0;
    posX2 = sizeX - cornerSpacing - boxThickness;
    posY1 = 0;
    posY2 = sizeY - cornerSpacing;

    difference()
    {
        square([sizeX, sizeY]);

        translate([posX1, posY1]) square([cornerSpacing + boxThickness, cornerSpacing]);
        translate([posX1, posY2]) square([cornerSpacing + boxThickness, cornerSpacing]);
        translate([posX2, posY1]) square([cornerSpacing + boxThickness, cornerSpacing]);
        translate([posX2, posY2]) square([cornerSpacing + boxThickness, cornerSpacing]);
    }
}

module BoxPaneFrame2D(
    size = DEFAULT_SIZE,
    panelThickness = DEFAULT_PANE_THICKNESS,
    cornerSpacing = DEFAULT_CORNER_SPACING,
    boxThickness = DEFAULT_BOX_THICKNESS)
{
    buffer = 0.25;
    posX1 = 0;
    posX2 = posX1 + size[2] + buffer;
    posX3 = posX2 + size[2] + buffer;
    posX4 = posX3 + size[2] + buffer;
    posX5 = posX4 + size[2] + buffer;

    BoxColour()
    translate([posX1, 0])
    BoxPaneFrameSideX2D(size, panelThickness, cornerSpacing, boxThickness);

    BoxColour()
    translate([posX2, 0])
    BoxPaneFrameSideX2D(size, panelThickness, cornerSpacing, boxThickness);

    BoxColour()
    translate([posX3, 0])
    BoxPaneFrameSideY2D(size, panelThickness, cornerSpacing);

    BoxColour()
    translate([posX4, 0])
    BoxPaneFrameSideY2D(size, panelThickness, cornerSpacing);

    PanelColour()
    translate([posX5, 0])
    BoxPaneFramePane2D(size[0], size[1], cornerSpacing, boxThickness);
}

module BoxPaneFrame3D(
    size = DEFAULT_SIZE,
    panelThickness = DEFAULT_PANE_THICKNESS,
    cornerSpacing = DEFAULT_CORNER_SPACING,
    boxThickness = DEFAULT_BOX_THICKNESS)
{
    BoxColour()
    {
        translate([boxThickness, 0, 0])
        rotate([0, 270, 270])
        linear_extrude(boxThickness)
        BoxPaneFrameSideX2D(size, panelThickness, cornerSpacing, boxThickness);

        translate([boxThickness, size[1] - boxThickness, 0])
        rotate([0, 270, 270])
        linear_extrude(boxThickness)
        BoxPaneFrameSideX2D(size, panelThickness, cornerSpacing, boxThickness);

        translate([boxThickness, 0, 0])
        rotate([0, 270, 0])
        linear_extrude(boxThickness)
        BoxPaneFrameSideY2D(size, panelThickness, cornerSpacing);

        translate([size[0], 0, 0])
        rotate([0, 270, 0])
        linear_extrude(boxThickness)
        BoxPaneFrameSideY2D(size, panelThickness, cornerSpacing);
    }

    PanelColour()
    translate([0, 0, (size[2] - panelThickness) / 2])
    linear_extrude(panelThickness)
    BoxPaneFramePane2D(size[0], size[1], cornerSpacing, boxThickness);
}
