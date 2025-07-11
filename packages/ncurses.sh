PROTO_DIR=${HOME}/illumos-gate/proto/root_i386

while getopts "p:" opt; do
  case $opt in
    p)
      # proto directory
      PROTO_DIR="$OPTARG"
      ;;
  esac
done
shift $((OPTIND-1))

wget https://invisible-island.net/datafiles/release/ncurses.tar.gz
tar -zxvf ncurses.tar.gz
cd ncurses
./configure --prefix=${PROTO_DIR}
make 
make install
cd ..
rm -rf ncurses/ ncurses.tar.gz