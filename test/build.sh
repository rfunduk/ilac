#!/bin/bash
mxmlc -incremental -debug \
      -compiler.source-path $(dirname $0)/.. \
      -file-specs $(dirname $0)/ItsLikeACircle.mxml \
      -output $(dirname $0)/ItsLikeACircle.swf
