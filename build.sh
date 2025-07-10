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

# TODO: Build packages in proto before building ISO
sh ${MVI_DIR}/build-iso.sh -m ${MVI_DIR} -p ${PROTO_DIR}