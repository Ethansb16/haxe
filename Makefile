HAXE_COMPILER=haxe

all: interp

interp:
	$(HAXE_COMPILER) -main Main --class-path src --interp
