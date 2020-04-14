FASMG:=$(HOME)/local/fasmg/source/macos/x64/fasmg
INCLUDE:=$(HOME)/local/fasmg/examples/x86/include

build:
	INCLUDE=$(INCLUDE) $(FASMG) -n b2plasma.asm b2plasma.img

clean:
	rm -f b2plasma.img

all: clean build

