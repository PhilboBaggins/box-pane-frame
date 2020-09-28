
DEFAULT_SIZE = [150, 200, 30];
DEFAULT_PANE_THICKNESS = 3;
DEFAULT_BOX_THICKNESS = 6;
DEFAULT_CORNER_SPACING = DEFAULT_BOX_THICKNESS;

BOX_COLOUR_X = "brown";
BOX_COLOUR_Y = "orange";
PANEL_COLOUR = "grey";
PANEL_ALPHA = 0.25;

module BoxColourX() { color(BOX_COLOUR_X) children(); }
module BoxColourY() { color(BOX_COLOUR_Y) children(); }
module PanelColour() { color(PANEL_COLOUR, PANEL_ALPHA) children(); }

module BoxPaneFrameSide2D(sizeX, sizeY, slotThickness, cornerSpacing, joinerCutPositions)
{
    joinerCutDivisions = 6;
    joinerCutThickness = sizeX / joinerCutDivisions;

    difference()
    {
        // Overall shape
        square([sizeX, sizeY]);

        // Slot for panel
        translate([(sizeX - slotThickness) / 2, cornerSpacing])
        square([slotThickness, sizeY - cornerSpacing * 2]);

        // Cutouts to help join this box side with the other sides
        translate([joinerCutThickness * joinerCutPositions[0], 0]) square([joinerCutThickness, joinerCutThickness]);
        translate([joinerCutThickness * joinerCutPositions[1], 0]) square([joinerCutThickness, joinerCutThickness]);
        translate([joinerCutThickness * joinerCutPositions[0], sizeY - joinerCutThickness]) square([joinerCutThickness, joinerCutThickness]);
        translate([joinerCutThickness * joinerCutPositions[1], sizeY - joinerCutThickness]) square([joinerCutThickness, joinerCutThickness]);
    }
}

module BoxPaneFrameSideX2D(size, panelThickness, cornerSpacing)
{
    BoxColourX()
    BoxPaneFrameSide2D(size[2], size[0], panelThickness, cornerSpacing, [0, 5]);
}

module BoxPaneFrameSideY2D(size, panelThickness, cornerSpacing)
{
    BoxColourY()
    BoxPaneFrameSide2D(size[2], size[1], panelThickness, cornerSpacing, [1, 4]);
}

module BoxPaneFramePane2D(
    size = DEFAULT_SIZE,
    cornerSpacing = DEFAULT_CORNER_SPACING,
    boxThickness = DEFAULT_BOX_THICKNESS)
{
    posX1 = 0;
    posX2 = size[0] - cornerSpacing;
    posY1 = 0;
    posY2 = size[1] - cornerSpacing;

    difference()
    {
        square([size[0], size[1]]);

        translate([posX1, posY1]) square([cornerSpacing, cornerSpacing]);
        translate([posX1, posY2]) square([cornerSpacing, cornerSpacing]);
        translate([posX2, posY1]) square([cornerSpacing, cornerSpacing]);
        translate([posX2, posY2]) square([cornerSpacing, cornerSpacing]);
    }
}

module BoxPaneFrameBox2D(
    size = DEFAULT_SIZE,
    panelThickness = DEFAULT_PANE_THICKNESS,
    cornerSpacing = DEFAULT_CORNER_SPACING,
    boxThickness = DEFAULT_BOX_THICKNESS)
{
    buffer = 0.25;

    posX1 = buffer;
    posX2 = buffer * 2 + size[2];
    posY1 = 0;
    posY2 = buffer + size[0] - boxThickness * 2;

    translate([posX1, posY1]) BoxPaneFrameSideX2D(size, panelThickness, cornerSpacing);
    translate([posX2, posY1]) BoxPaneFrameSideX2D(size, panelThickness, cornerSpacing);
    translate([posX1, posY2]) BoxPaneFrameSideY2D(size, panelThickness, cornerSpacing);
    translate([posX2, posY2]) BoxPaneFrameSideY2D(size, panelThickness, cornerSpacing);
}

module BoxPaneFrame2D(
    size = DEFAULT_SIZE,
    panelThickness = DEFAULT_PANE_THICKNESS,
    cornerSpacing = DEFAULT_CORNER_SPACING,
    boxThickness = DEFAULT_BOX_THICKNESS)
{
    BoxPaneFrameBox2D(size, panelThickness, cornerSpacing, boxThickness);

    PanelColour()
    translate([-size[0], 0])
    BoxPaneFramePane2D(size[0], size[1], cornerSpacing, boxThickness);
}

module BoxPaneFrame3D(
    size = DEFAULT_SIZE,
    panelThickness = DEFAULT_PANE_THICKNESS,
    cornerSpacing = DEFAULT_CORNER_SPACING,
    boxThickness = DEFAULT_BOX_THICKNESS)
{
    BoxColourX()
    translate([0, 0, 0])
    rotate([0, 270, 270])
    linear_extrude(boxThickness)
    BoxPaneFrameSideX2D(size, panelThickness, cornerSpacing);

    BoxColourX()
    translate([0, size[1] - boxThickness, 0])
    rotate([0, 270, 270])
    linear_extrude(boxThickness)
    BoxPaneFrameSideX2D(size, panelThickness, cornerSpacing);

    BoxColourY()
    translate([boxThickness, 0, 0])
    rotate([0, 270, 0])
    linear_extrude(boxThickness)
    BoxPaneFrameSideY2D(size, panelThickness, cornerSpacing);

    BoxColourY()
    translate([size[0], 0, 0])
    rotate([0, 270, 0])
    linear_extrude(boxThickness)
    BoxPaneFrameSideY2D(size, panelThickness, cornerSpacing);

    PanelColour()
    translate([0, 0, (size[2] - panelThickness) / 2])
    linear_extrude(panelThickness)
    BoxPaneFramePane2D(size, cornerSpacing, boxThickness);
}
