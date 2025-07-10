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

wget https://www.zsh.org/pub/zsh-5.9.tar.xz
tar -xvf zsh-5.9.tar.xz
cd zsh-5.9
./configure --prefix=${PROTO_DIR}/usr/local
make
make install
cd ..
rm -rf zsh-5.9/ zsh-5.9.tar.xz
