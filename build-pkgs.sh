PROTO_DIR=${HOME}/illumos-gate/proto/root_i386
MVI_DIR=${HOME}/build

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

sh ${MVI_DIR}/packages/zsh.sh -p ${PROTO_DIR}