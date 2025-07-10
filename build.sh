MVI_DIR=${HOME}/build
PROTO_DIR=${HOME}/illumos-gate/proto/root_i386
ISO_NAME=${HOME}/build-$$.iso

while getopts "o:p:b:" opt; do
  case $opt in
    o)
      # output file
      ISO_NAME="$OPTARG"
      ;;
    p)
      # proto directory
      PROTO_DIR="$OPTARG"
      ;;
    b)
      # MVI or build directory
      MVI_DIR="$OPTARG"
      ;;
    *)
	    bail "invalid argument $opt"
	    ;;
  esac
done
shift $((OPTIND-1))

# TODO: Build packages in proto before building ISO
sh ${MVI_DIR}/build-iso.sh -b ${MVI_DIR} -p ${PROTO_DIR} -o ${ISO_NAME}
