MVI_DIR=${HOME}/build
PROTO_DIR=${HOME}/illumos-gate/proto/root_i386

while getopts "m:p:" opt; do
  case $opt in
    m)
      MVI_DIR="$OPTARG"
      ;;
    p)
      PROTO_DIR="$OPTARG"
      ;;
    *)
	    bail "invalid argument $opt"
	    ;;
  esac
done

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

sh ${MVI_DIR}/iso/pureboot.sh -o build_$$.iso -p ${PROTO_DIR} -b ${MVI_DIR}