
install:
	stack install

compile:
	stack build

clean:
	stack clean

osx:
	brew install libxrandr
	brew install libXScrnSaver
	brew install libxft
	stack build --system-ghc
