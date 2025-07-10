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

if [ ! -f ${MVI_DIR}/iso/pureboot.sh ]; then
  echo "Pureboot script not found!"
  exit 1
fi

if [ ! -f ${MVI_DIR}/iso/hybridize-iso.sh ]; then
  echo "Hybridize script not found!"
  exit 1
fi

if [ ! -f ${MVI_DIR}/iso/uefi.sh ]; then
  echo "UEFI script not found!"
  exit 1
fi

sh ${MVI_DIR}/iso/pureboot.sh -p ${PROTO_DIR} -b ${MVI_DIR} -o ${ISO_NAME}
