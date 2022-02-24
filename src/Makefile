OBJ = obj
PDFLATEX_FLAGS = -halt-on-error -output-directory $(OBJ)
SOURCES = archi.tex
IMG     = $(wildcard *.pdf)
IMG    += $(wildcard *.jpg)
IMG    += $(wildcard *.png)
COMMAND = pdflatex $(PDFLATEX_FLAGS) $(SOURCES)

all: $(OBJ) $(SOURCES) $(IMG)
	$(COMMAND) && $(COMMAND)

$(OBJ):
	mkdir -p $(OBJ)

clean:
	rm -rf $(OBJ)
