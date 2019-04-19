# Makefile for java sources

## for Java
%.class : %.java
	$(JAVAC) $(DEBUG) $<

## make variables
JAVAC ?= javac
DEBUG ?= -g

SRC = $(wildcard *.java)
CLASS = $(patsubst %.java, %.class, $(filter-out %Template.java,$(SRC)))

classes: $(CLASS)

all: classes

clean:
	-rm -f *.class *~

.PHONY: all classes clean
