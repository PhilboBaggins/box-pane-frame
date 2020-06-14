NAME := BoxPaneFrame

COMMON_SRC_FILE := ../BoxPaneFrame.scad

ALL_FRAME := \
	${NAME}-Box.dxf \
	${NAME}-Box.svg

ALL_PANE := \
	${NAME}-Pane.dxf \
	${NAME}-Pane.svg

ALL_ASSEMBLY := \
	${NAME}-Assembly.png

ALL := ${ALL_FRAME} ${ALL_PANE} ${ALL_ASSEMBLY}

.PHONY: all clean

all: ${ALL}

${ALL_FRAME}: ${NAME}-Box.scad ${COMMON_SRC_FILE}
	openscad -o $@ $<

${ALL_PANE}: ${NAME}-Pane.scad ${COMMON_SRC_FILE}
	openscad -o $@ $<

${ALL_ASSEMBLY}: ${NAME}-Assembly.scad ${COMMON_SRC_FILE}
	openscad -o $@ $<

clean:
	rm -f ${ALL}
