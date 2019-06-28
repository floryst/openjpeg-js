# Editable config
OPENJPEG_ROOT=$HOME/openjpeg-js/openjpeg
OPENJPEG_BUILD_ROOT=$HOME/openjpeg-js/openjpeg/build
OUTPUT_NAME=openJPEG-FixedMemory.js

mkdir -p out

# edit the switches to your desire
emcc \
  -I"$OPENJPEG_ROOT"/src/lib/openjp2 \
  -I"$OPENJPEG_BUILD_ROOT"/src/lib/openjp2 \
  --memory-init-file 0 \
  -s WASM=0 \
  -s ERROR_ON_UNDEFINED_SYMBOLS=0 \
  -s TOTAL_MEMORY=16777216 \
  -O3 \
  -s EXTRA_EXPORTED_RUNTIME_METHODS=["ccall","cwrap","writeArrayToMemory","getValue"] \
  -s NO_FILESYSTEM=1 \
  -s EXPORTED_FUNCTIONS="['_opj_version','_opj_decode']" \
  -s MODULARIZE=1 \
  -s EXPORT_NAME="'OpenJPEG'" \
  -o out/"$OUTPUT_NAME" \
  "$OPENJPEG_BUILD_ROOT"/bin/libopenjp2.a src/JSOpenJPEGDecoder.c
